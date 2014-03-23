package modules.control
{
	import feathers.core.FeathersControl;
	import modules.base.BaseController;
	import modules.base.BaseModel;
	import utils.Globals;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ControllScreenController extends BaseController
	{
		
		private static var _instance:ControllScreenController;
		
		public static function get instance():ControllScreenController {
			if (_instance == null) {
				_instance = new ControllScreenController(Globals.instance.game.controllScreenView, ControllScreenModel.instance);
			}
			return _instance;
		}
		
		public function ControllScreenController(view:FeathersControl, model:BaseModel) {
			super(view, model);
		}
	
	}

}