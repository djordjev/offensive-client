package modules.main 
{
	import modules.base.BaseModel;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class MainControlsModel extends BaseModel 
	{
		private static var _instance:MainControlsModel;
		
		public static function get instance():MainControlsModel {
			if (_instance == null) {
				_instance = new MainControlsModel();
			}
			return _instance;
		}
		
		public function MainControlsModel() 
		{
			super();
		}
		
		public function requestJoinableGames(callback:Function):void {
			if (callback != null) {
				callback();
			}
		}
		
	}

}