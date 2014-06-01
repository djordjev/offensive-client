package processors {
	import com.netease.protobuf.Int64;
	import communication.Communicator;
	import communication.HandlerCodes;
	import communication.HandlerMapping;
	import communication.Me;
	import communication.ProtocolMessage;
	import communication.protos.GetUserDataRequest;
	import communication.protos.GetUserDataResponse;
	import modules.friends.FriendsController;
	import modules.friends.FriendsModel;
	import modules.game.GameController;
	import modules.game.GameModel;
	import modules.main.MainControlsController;
	import modules.main.MainControlsModel;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import utils.Alert;
	import utils.Settings;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class LoginProcessor extends EventDispatcher {
		public static const LOGIN_COMPLETED:String = "login completed";
		
		private static var _instance:LoginProcessor;
		
		private var _myUserInfo:GetUserDataResponse;
		
		public static function get instance():LoginProcessor {
			if (_instance == null) {
				_instance = new LoginProcessor();
			}
			return _instance;
		}
		
		public function LoginProcessor() {
		}
		
		public function processLogin():void {
			new HandlerMapping();
			connectToServer();
		}
		
		public function connectToServer():void {
			trace("INITIATING CONNECTION");
			Communicator.instance.addEventListener(Communicator.SOCKET_CONNECTED, requestUserInfo);
			Communicator.instance.addEventListener(Communicator.SOCKET_DISCONNECTED, socketDisconnected);
			Communicator.instance.addEventListener(Communicator.SOCKET_IO_ERROR, unableToConnect);
			Communicator.instance.connect(Settings.HOSTNAME, Settings.PORT);
		}
		
		public function socketDisconnected(e:Event):void {
			Alert.showConnectionBrokenAlert();
		}
		
		private function unableToConnect(e:Event):void {
			Alert.showConnectionBrokenAlert();
		}
		
		public function requestUserInfo(event:Event):void {
			trace("CONNECTED TO " + Settings.HOSTNAME + " ON PORT " + Settings.PORT);
			var getUserData:GetUserDataRequest = new GetUserDataRequest();
			getUserData.userId = Int64.parseInt64(Me.instance.userIdAsString); 
			Communicator.instance.send(HandlerCodes.GET_USER_DATA, getUserData, function handleResponse(message:ProtocolMessage):void {
				var response:GetUserDataResponse = message.data as GetUserDataResponse;
				_myUserInfo = response;
				initializeModels();
			});
		}
		
		public function initializeModels():void {
			Me.instance.userInfo = _myUserInfo.userData;
			FriendsModel.instance;
			MainControlsModel.instance.initialize(_myUserInfo.userData);
			GameModel.instance;
			initializeControllers();
		}
		
		public function initializeControllers():void {
			FriendsController.instance;
			MainControlsController.instance;
			GameController.instance;
			this.dispatchEvent(new Event(LOGIN_COMPLETED));
		}
	
	}

}