package utils {
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public dynamic class Globals {
		
		public static const SCREEN_WIDTH:int = 1024;
		public static const SCREEN_HEIGHT:int = 768;
		
		private static var _instance:Globals;
		
		public static function get instance():Globals {
			if (_instance == null) {
				_instance = new Globals();
			}
			return _instance;
		}
		
		public var parameters:Object;
		public var game:Game;
		
		public function Globals() {
		}
	
	}

}