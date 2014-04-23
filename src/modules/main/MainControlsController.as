package modules.main 
{
	import components.events.CreateGameEvent;
	import components.events.GameManipulationEvent;
	import components.events.OpenGameEvent;
	import components.GameActionsDialog;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import flash.display.Bitmap;
	import modules.base.BaseController;
	import modules.base.BaseModel;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import utils.Assets;
	import utils.FacebookCommunicator;
	import utils.Globals;
	import utils.Screens;
	
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
			view.gameActionsDialog.existingGamesList.dataProvider = new ListCollection(model.activeGames);
		}
		
		override protected function addHandlers():void {
			view.addEventListener(CreateGameEvent.CREATED_OPEN_GAME, newOpenGameCreation);
			view.addEventListener(GameActionsDialog.REQUEST_LIST_OF_GAMES, getListOfOpenGames);
			view.gameActionsDialog.existingGamesList.addEventListener(OpenGameEvent.OPEN_GAME, openGame);
			view.addEventListener(GameManipulationEvent.SELECTED_GAME_ACTION, selectedGameAction);
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
		
		private function openGame(e:OpenGameEvent):void {
			mainScreenNavigator.showScreen(Screens.GAME);
		}
		
		private function selectedGameAction(e:GameManipulationEvent):void {
			if (e.gameAction != null) {
				var bitmap:Class = Assets.getBackgroundImage(e.gameAction);
				if (view.backgroundImage != null) {
					// remove old background image
					view.removeChild(view.backgroundImage);
				}
				view.backgroundImage = new Image(Texture.fromBitmap(new bitmap()));
				// add new image as background as first child
				view.addChildAt(view.backgroundImage, 0);
			}
		}
		
	}

}