package modules.friends {
	import com.netease.protobuf.Int64;
	import communication.Communicator;
	import communication.HandlerCodes;
	import communication.ProtocolMessage;
	import communication.protos.FilterFriendsRequest;
	import communication.protos.FilterFriendsResponse;
	import communication.protos.User;
	import flash.utils.Dictionary;
	import modules.base.BaseModel;
	import wrappers.FacebookUser;
	import wrappers.UserWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class FriendsModel extends BaseModel {
		
		private var _friends:Array = [];
		
		private static var _instance:FriendsModel;
		
		public static function get instance():FriendsModel {
			if (_instance == null) {
				_instance = new FriendsModel;
			}
			return _instance;
		}
		
		public function FriendsModel() {
			super();
		}
		
		public function get friends():Array {
			return _friends;
		}
		
		/** Array of fb ids as string */
		public function filterFriends(friendsList:Array, callback:Function):void {
			var request:FilterFriendsRequest = new FilterFriendsRequest();
			request.facebookIds = [];
			for each(var friendId:String in friendsList) {
				request.facebookIds.push(Int64.parseInt64(friendId));
			}
			
			Communicator.instance.send(HandlerCodes.FILTER_FRIENDS, request, function friendsListReceived(message:ProtocolMessage):void {
				var response:FilterFriendsResponse = message.data as FilterFriendsResponse;
				for each(var user:User in response.friends) {
					var userWrapper:UserWrapper = new UserWrapper();
					userWrapper.facebookUser = FacebookUser.facebookUserLightInfo[user.facebookId.toString()];
					userWrapper.user = user;
					_friends.push(userWrapper);
				}
				
				if (callback != null) {
					callback();
				}
			});
		}
	
	}

}