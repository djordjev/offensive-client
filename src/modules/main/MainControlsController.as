package modules.main 
{
	import communication.protos.GameDescription;
	import components.events.CreateGameEvent;
	import components.events.GameManipulationEvent;
	import components.events.JoinGameEvent;
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
			view.currentUserInfoDisplay.inviteToPrivateGame.numberOfInvitations = 3;
			view.currentUserInfoDisplay.playerName.text = FacebookCommunicator.instance.me.name.toUpperCase();
			view.currentUserInfoDisplay.playerJoined.text = "JOINED";
			view.currentUserInfoDisplay.playerLocation.text = "BEOGRAD";
			view.currentUserInfoDisplay.stats.text = "Some stupid statistics".toUpperCase();
			view.currentUserInfoDisplay.userImage.userImageSource = FacebookCommunicator.instance.me.largeImageURL;
			
			view.gameActionsDialog.state = GameActionsDialog.STATE_MENU;
			view.gameActionsDialog.existingGamesList.dataProvider = new ListCollection(model.activeGames);
		}
		
		override protected function addHandlers():void {
			view.addEventListener(CreateGameEvent.CREATED_OPEN_GAME, newOpenGameCreation);
			view.addEventListener(JoinGameEvent.JOINED_TO_GAME, joinToGame);
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
		
		private function joinToGame(e:JoinGameEvent):void {
			var gameToJoin:GameDescription = e.gameToJoin;
			if (gameToJoin != null) {
				model.joinToGame(gameToJoin, function joinedToGame():void {
					// joined to game
					view.gameActionsDialog.existingGamesList.dataProvider = new ListCollection(model.activeGames);
					view.gameActionsDialog.state = GameActionsDialog.STATE_MENU;
				});
			}
		}
		
	}

}