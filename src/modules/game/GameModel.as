package modules.game 
{
	import modules.base.BaseModel;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameModel extends BaseModel 
	{
		
		private static var _instance:GameModel;
		
		public static function get instance():GameModel {
			if (_instance == null) {
				_instance = new GameModel();
			}
			
			return _instance;
		}
		
		public function GameModel() 
		{
			super();
		}
		
	}

}