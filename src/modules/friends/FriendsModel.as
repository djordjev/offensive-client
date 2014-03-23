package modules.friends {
	import modules.base.BaseModel;
	import wrappers.UserWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class FriendsModel extends BaseModel {
		
		private var _friends:Array;
		
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
		
		public function intialize():void {
			_friends = [];
			for (var i:int = 0; i < 13; i++) {
				var newUser:UserWrapper = new UserWrapper();
				newUser.name = "Prijatelj broj " + (i + 1);
				_friends.push(newUser);
			}
		}
	
	}

}