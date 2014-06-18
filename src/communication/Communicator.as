package communication {
	import com.netease.protobuf.Message;
	import feathers.controls.Callout;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import utils.Alert;
	
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	public class Communicator extends EventDispatcher {
		// This function dispatches Starling events
		
		public static const SOCKET_CONNECTED:String = "socket connected";
		public static const SOCKET_DISCONNECTED:String = "socket disconnected";
		public static const SOCKET_IO_ERROR:String = "socket io error";
		
		private static const HEADER_SIZE:int = 14; // size in bytes
		
		private static const WAIT_FOR_RESPONSE_TIME:int = 30000;
		
		private static var _instance:Communicator;
		
		public static function get instance():Communicator {
			if (_instance == null) {
				_instance = new Communicator();
			}
			
			return _instance;
		}
		
		private var _socket:Socket;
		
		/** Mapping ticketId to callback */
		private var _callbacks:Dictionary = new Dictionary();
		
		/** Mapping handlerId to callback function */
		private var _subscriptionCallbacks:Dictionary = new Dictionary();
		
		private var _timers:Dictionary = new Dictionary();
		
		private var _ticket:int = 1;
		
		public function Communicator() {
		
		}
		
		public function connect(hostname:String, port:int):void {
			_socket = new Socket();
			_socket.addEventListener(flash.events.Event.CONNECT, socketConnected);
			_socket.addEventListener(flash.events.IOErrorEvent.IO_ERROR, socketError);
			_socket.addEventListener(flash.events.Event.CLOSE, socketClosed);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, receive);
			_socket.connect(hostname, port);
		}
		
		private function socketConnected(e:flash.events.Event):void {
			trace("Socket connected");
			dispatchEvent(new Event(SOCKET_CONNECTED, true));
		}
		
		private function socketError(e:flash.events.Event):void {
			trace("Socket IO Error");
			dispatchEvent(new Event(SOCKET_IO_ERROR, true));
		}
		
		private function socketClosed(e:flash.events.Event):void {
			trace("Socket closed");
			dispatchEvent(new Event(SOCKET_DISCONNECTED, true));
		}
		
		public function send(handlerCode:int, message:Message, callback:Function):void {
			var messageBytes:ByteArray = new ByteArray();
			message.writeTo(messageBytes);
			var messageHeader:ByteArray = buildHeader(handlerCode, messageBytes.length, _ticket);
			
			var finalMessage:ByteArray = new ByteArray();
			finalMessage.writeBytes(messageHeader);
			finalMessage.writeBytes(messageBytes);
			
			// store callback
			if (callback != null) {
				_callbacks[_ticket] = callback;
			}
			
			var timer:Timer = new Timer(WAIT_FOR_RESPONSE_TIME, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerIsUp);
			
			_timers[_ticket] = timer;
			timer.start();
			
			_ticket++;
			
			if (_socket.connected) {
				_socket.writeBytes(finalMessage, 0, finalMessage.length);
				_socket.flush();
			}
		}
		
		private function buildHeader(handlerCode:int, size:int, ticketId:int):ByteArray {
			var header:ByteArray = new ByteArray();
			header.writeInt(handlerCode);
			header.writeInt(ticketId);
			header.writeInt(size);
			header.writeByte(0);
			header.writeByte(0);
			return header;
		}
		
		private var _protocolMessageInProgress:ProtocolMessage = null;
		private var _messageInProgress:ByteArray = null;
		
		private function receive(event:flash.events.Event):void {
			// read message 
			var serializedMessage:ByteArray = new ByteArray();
			
			if (_protocolMessageInProgress == null && _messageInProgress == null) {
				_protocolMessageInProgress = new ProtocolMessage();
				// read header
				_protocolMessageInProgress.handlerId = _socket.readInt();
				_protocolMessageInProgress.ticketId = _socket.readInt();
				_protocolMessageInProgress.dataLength = _socket.readInt();
				_protocolMessageInProgress.status = _socket.readByte();
				_protocolMessageInProgress.serialization = _socket.readByte();
				
				if (_socket.bytesAvailable >= _protocolMessageInProgress.dataLength) {
					_socket.readBytes(serializedMessage, 0, _protocolMessageInProgress.dataLength);
					wholeMessageIsReceived(_protocolMessageInProgress, serializedMessage);
					_protocolMessageInProgress = null;
					_messageInProgress = null;
				} else {
					_socket.readBytes(serializedMessage);
					_messageInProgress = new ByteArray();
					_messageInProgress.writeBytes(serializedMessage);
				}
			} else {
				if (_socket.bytesAvailable >= _protocolMessageInProgress.dataLength - _messageInProgress.length) {
					// all bytes are now read
					_socket.readBytes(serializedMessage, 0, _protocolMessageInProgress.dataLength - _messageInProgress.length);
					_messageInProgress.writeBytes(serializedMessage);
					_messageInProgress.position = 0;
					wholeMessageIsReceived(_protocolMessageInProgress, _messageInProgress);
					_protocolMessageInProgress = null;
					_messageInProgress = null;
				} else {
					// message is still not completely received
					_socket.readBytes(serializedMessage);
					_messageInProgress.writeBytes(serializedMessage);
				}
			}
			
			
		}
		
		private function wholeMessageIsReceived(receivedMessage:ProtocolMessage, messageData:ByteArray):void {
			var messageClass:Class = HandlerMapping.mapping[receivedMessage.handlerId];
			var message:Message = new messageClass();
			
			message.mergeFrom(messageData);
			receivedMessage.data = message;
			
			// call callback function for this ticket
			var delegate:Function = null;
			if (_subscriptionCallbacks[receivedMessage.handlerId] != null) {
				delegate = _subscriptionCallbacks[receivedMessage.handlerId];
			} else {
				delegate = _callbacks[receivedMessage.ticketId];
			}
			if (delegate != null) {
				delete _callbacks[receivedMessage.ticketId];
				delegate(receivedMessage);
			}
			
			if (receivedMessage.ticketId != 0) {
				var timer:Timer = _timers[receivedMessage.ticketId];
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerIsUp);
				timer.stop();
				delete _timers[receivedMessage.ticketId];
			}
		}
		
		private function timerIsUp(e:TimerEvent):void {
			Alert.showConnectionBrokenAlert();
		}
		
		public function subscribe(handlerId:int, callback:Function):void {
			if (callback != null) {
				_subscriptionCallbacks[handlerId] = callback;
			}
		}
	}
}
