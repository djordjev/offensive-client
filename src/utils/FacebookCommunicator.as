package utils 
{
	import flash.external.ExternalInterface;
	import wrappers.FacebookUser;
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class FacebookCommunicator 
	{
		private static var _instance:FacebookCommunicator;
		
		public static function get instance():FacebookCommunicator {
			if (_instance == null) {
				_instance = new FacebookCommunicator();
			}
			return _instance;
		}
		
		private var facebookId:String;
		
		private var _me:FacebookUser;
		
		private var _initializedCallback:Function;
		
		public function FacebookCommunicator() {
		}
		
		public function get me():FacebookUser {
			return _me;
		}
		
		public function initialize(fbId:String, callback:Function):void {
			facebookId = fbId;
			
			if(facebookId != null && facebookId != "") {
				ExternalInterface.addCallback("playerInfoReceived", playerInfoReceived);
				_initializedCallback = callback;
				ExternalInterface.call("getMyInfo");
			} else {
				_me = new FacebookUser();
				_me.setUsernameAndImages("vukovic.djordje");
				_me.name = "Djordje Vukovic";
				callback();
			}
		}
		
		private function playerInfoReceived(userInfo:Object):void {
			_me = new FacebookUser();
			_me.setUsernameAndImages(userInfo.username);
			_me.name = userInfo.name;
			
			
			if (_initializedCallback != null) {
				_initializedCallback();
			}
		}
		
	}

}