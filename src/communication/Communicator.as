package communication {
	import com.netease.protobuf.Message;

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

		private static var _instance:Communicator;

		public static function get instance():Communicator {
			if (_instance == null) {
				_instance = new Communicator();
			}

			return _instance;
		}

		private var _socket:Socket;

		private var _callbacks:Dictionary = new Dictionary();

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

		private function receive(event:flash.events.Event):void {
			var protocolMessage:ProtocolMessage = new ProtocolMessage();

			// read header
			protocolMessage.handlerId = _socket.readInt();
			protocolMessage.ticketId = _socket.readInt();
			protocolMessage.dataLength = _socket.readInt();
			protocolMessage.status = _socket.readByte();
			protocolMessage.serialization = _socket.readByte();

			// read message 
			var serializedMessage:ByteArray = new ByteArray();
			_socket.readBytes(serializedMessage, 0, protocolMessage.dataLength);

			var messageClass:Class = HandlerMapping.mapping[protocolMessage.handlerId];
			var message:Message = new messageClass();

			message.mergeFrom(serializedMessage);
			protocolMessage.data = message;

			// call callback function for this ticket
			var delegate:Function = _callbacks[protocolMessage.ticketId];
			if (delegate != null) {
				delete _callbacks[protocolMessage.ticketId];
				delegate(protocolMessage);
			}
		}
	}
}
