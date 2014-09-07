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
		
		private var _fbUserCallbacks:Dictionary = new Dictionary();
		
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
				_me.name = "Dummy User";
				_me.username = "dummy.user";
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
		
		public function requestFBUserInfo(facebookId:String, callback:Function):void {
			if (facebookId != null && facebookId != "" && _fbUserCallbacks[facebookId] == null) {
				if (FacebookUser.facebookUserLightInfo[facebookId] == null) {
					ExternalInterface.addCallback("facebookUserInfoReceived", facebookUserInfoReceived);
					_fbUserCallbacks[facebookId] = callback;
					ExternalInterface.call("getFBUserInfo", facebookId);
				} else {
					if (callback == null) {
						callback(FacebookUser.facebookUserLightInfo[facebookId]);
					}
				}
				
			}
		}
		
		private function facebookUserInfoReceived(userInfo:Object):void {
			if (userInfo.id != null && _fbUserCallbacks[userInfo.id] != null) {
				var facebookUser:FacebookUser = new FacebookUser();
				facebookUser.setFacebookId(userInfo.id);
				facebookUser.locale = userInfo.locale;
				facebookUser.name = userInfo.name;
				facebookUser.username = userInfo.username;
				
				var callback:Function = _fbUserCallbacks[userInfo.id];
				_fbUserCallbacks[userInfo.id] = null; // remove callback
				
				if (callback != null) {
					callback(facebookUser);
				}
			}
		}
		
	}

}