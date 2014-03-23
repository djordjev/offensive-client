package processors 
{
	import modules.control.ControllScreenController;
	import modules.friends.FriendsController;
	import modules.friends.FriendsModel;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class LoginProcessor extends EventDispatcher
	{
		public static const LOGIN_COMPLETED:String = "login completed";
		
		private static var _instance:LoginProcessor;
		
		public static function get instance():LoginProcessor {
			if (_instance == null) {
				_instance = new LoginProcessor();
			}
			return _instance;
		}
		
		
		public function LoginProcessor() {
		}
		
		
		public function processLogin():void {
			initializeModels();
		}
		
		public function connectToServer():void {
			
		}
		
		public function loginToServer(event:Event):void {
			
		}
		
		public function requestUserInfo():void {
			
		}
		
		public function requestGameData():void {
			
		}
		
		public function initializeModels():void {
			FriendsModel.instance.intialize();
			initializeControllers();
		}
		
		public function initializeControllers():void {
			FriendsController.instance;
			ControllScreenController.instance;
			this.dispatchEvent(new Event(LOGIN_COMPLETED));
		}
		
	}

}