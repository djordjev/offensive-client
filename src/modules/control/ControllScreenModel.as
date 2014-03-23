package modules.control 
{
	import modules.base.BaseModel;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ControllScreenModel extends BaseModel 
	{
		private static var _instance:ControllScreenModel;
		
		public static function get instance():ControllScreenModel {
			if (_instance == null) {
				_instance = new ControllScreenModel();
			}
			return _instance;
		}
		
		public function ControllScreenModel() 
		{
			super();
			
		}
		
	}

}