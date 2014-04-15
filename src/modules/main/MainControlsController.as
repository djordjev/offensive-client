package modules.main 
{
	import components.events.CreateGameEvent;
	import components.GameActionsDialog;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import flash.external.ExternalInterface;
	import modules.base.BaseController;
	import modules.base.BaseModel;
	import starling.events.Event;
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
			trace("Setting data provider");
			view.gameActionsDialog.existingGamesList.dataProvider = new ListCollection(model.activeGames);
		}
		
		override protected function addHandlers():void {
			view.addEventListener(CreateGameEvent.CREATED_OPEN_GAME, newOpenGameCreation);
			view.addEventListener(GameActionsDialog.REQUEST_LIST_OF_GAMES, getListOfOpenGames);
		}
		
		private function newOpenGameCreation(e:CreateGameEvent):void {
			model.createOpenGame(e.gameName, e.numberOfPlayers, e.objective, function createdNewOpenGame():void {
				view.gameActionsDialog.existingGamesList.dataProvider = new ListCollection(model.activeGames);
				view.gameActionsDialog.state = GameActionsDialog.STATE_MENU;
			});
		}
		
		private function getListOfOpenGames(e:Event):void {
			model.getListOfOpenGames(function receivedListOfGames():void {
				view.gameActionsDialog.gamesAvailableForJoining.dataProvider = new ListCollection(model.openGamesAvailableForJoin);
			});
		}
		
	}

}