package utils 
{
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public dynamic class Globals 
	{
		private static var _instance:Globals;
		
		public static function get instance():Globals {
			if (_instance == null) {
				_instance = new Globals();
			}
			return _instance;
		}
		
		public var parameters:Object;
		
	}

}