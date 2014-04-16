package utils 
{
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;
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
		
		public var facebookId:String;
		
		private var _me:FacebookUser;
		
		private var _initializedCallback:Function;
		
		private var _friendsReceivedCallback:Function;
		
		public function FacebookCommunicator() {
		}
		
		public function get me():FacebookUser {
			return _me;
		}
		
		public function get isMeFacebookUser():Boolean {
			return facebookId != null;
		}
		
		public function initialize(fbId:String, callback:Function):void {
			if(fbId != null && fbId != "") {
				ExternalInterface.addCallback("playerInfoReceived", playerInfoReceived);
				_initializedCallback = callback;
				facebookId = fbId;
				ExternalInterface.call("getMyInfo");
			} else {
				facebookId = null;
				_me = new FacebookUser();
				_me.setFacebookId("1282639449");
				_me.name = "Djordje Vukovic";
				_me.username = "vukovic.djordje";
				callback();
			}
		}
		
		private function playerInfoReceived(userInfo:Object):void {
			_me = new FacebookUser();
			_me.setFacebookId(facebookId);
			_me.name = userInfo.name;
			_me.username = userInfo.username;
			
			if (_initializedCallback != null) {
				_initializedCallback();
			}
		}
		
		/** Callback is function with one argument - array of facebookIds as String */
		public function requestMyFriendsList(callback:Function):void {
			if (callback != null && _friendsReceivedCallback == null) {
				ExternalInterface.addCallback("friendsListReceived", friendsListReceived);
				_friendsReceivedCallback = callback;
				ExternalInterface.call("getFriendsList");
			}
		}
		
		private function friendsListReceived(friends:Object):void {
			if (_friendsReceivedCallback != null) {
				for each(var friend:Object in friends.data) {
					var fbUser:FacebookUser = new FacebookUser();
					fbUser.name = friend.name as String;
					fbUser.setFacebookId(friend.id as String);
				}
				_friendsReceivedCallback(friends.data as Array);
				_friendsReceivedCallback = null;
			}
		}
		
	}

}