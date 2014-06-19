package communication 
{
	import communication.protos.UserData;
	import utils.Settings;
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class Me 
	{
		private static var _instance:Me;
		
		public static function get instance():Me {
			if (_instance == null) {
				_instance = new Me();
			}
			return _instance;
		}
		
		public var userInfo:UserData;
		
		public var userIdAsString:String;
		
		public function initialize(userIdString:String):void {
			if (userIdString != null && userIdString != "") {
				userIdAsString = userIdString;
			} else {
				userIdAsString = Settings.DUMMY_USER_ID.toString();
			}
		}
		
	}

}