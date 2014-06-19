package wrappers {
	import com.netease.protobuf.Int64;
	import communication.protos.User;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class UserWrapper {
		
		public static function getUserByUserId(userId:Int64):UserWrapper {
			return _users[userId.toString()];
		}
		
		private static var _users:Dictionary = new Dictionary();
		
		public static function buildUserWrapper(user:User, facebookUser:FacebookUser=null):UserWrapper {
			var wrapper:UserWrapper = new UserWrapper();
			wrapper.userId = user.userId;
			wrapper.facebookUser = facebookUser;
			
			_users[wrapper.userId.toString()] = wrapper;
			
			return wrapper;
		}
		
		public var facebookUser:FacebookUser;
		public var userId:Int64;
		
		public function UserWrapper() {
		
		}
	
	}

}