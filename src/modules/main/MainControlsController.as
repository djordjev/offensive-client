package modules.main 
{
	import components.GameActionsDialog;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.core.FeathersControl;
	import flash.external.ExternalInterface;
	import modules.base.BaseController;
	import modules.base.BaseModel;
	import utils.FacebookCommunicator;
	import utils.Globals;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class MainControlsController extends BaseController 
	{
		private static var _instance:MainControlsController;
		
		public static function get instance():MainControlsController {
			if (_instance == null) {
				_instance = new MainControlsController(Globals.instance.game.controllScreenView.mainControlsView, MainControlsModel.instance);
			}
			return _instance;
		}
		
		public function MainControlsController(view:FeathersControl, model:BaseModel) 
		{
			super(view, model);
		}
		
		public function get view():MainControlsView {
			return _view as MainControlsView;
		}
		
		public function get model():MainControlsModel {
			return _model as MainControlsModel;
		}
		
		override protected function initializeView():void 
		{
			view.currentUserInfoDisplay.inviteToPrivateGame.label = "Invites to private games";
			view.currentUserInfoDisplay.playerName.text = FacebookCommunicator.instance.me.name;
			view.currentUserInfoDisplay.stats.text = "Some stupid statistics";
			view.currentUserInfoDisplay.userImage.source = FacebookCommunicator.instance.me.largeImageURL;
			
			view.gameActionsDialog.state = GameActionsDialog.STATE_MENU;
		}
		
	}

}