package modules.game {
	import com.netease.protobuf.Int64;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import modules.base.BaseController;
	import modules.base.BaseModel;
	import modules.game.classes.ActionPerformedTroopDeployment;
	import modules.game.classes.ActionPerformedWaitingForOpponents;
	import modules.game.classes.GamePhase;
	import modules.game.classes.IGameActionPerformed;
	import modules.game.events.ChangedNumberOfUnits;
	import modules.game.events.ClickOnTerritory;
	import starling.events.Event;
	import utils.Globals;
	import utils.Screens;
	import wrappers.GameContextWrapper;
	import wrappers.PlayerWrapper;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameController extends BaseController {
		
		private static var _instance:GameController;
		
		public static function get instance():GameController {
			if (_instance == null) {
				_instance = new GameController(Globals.instance.game.gameScreenView, GameModel.instance);
			}
			
			return _instance;
		}
		
		private var _actionPerformed:IGameActionPerformed;
		
		private var _currentGameId:Int64;
		
		public function get model():GameModel {
			return _model as GameModel;
		}
		
		public function get view():GameView {
			return _view as GameView;
		}
		
		public function GameController(view:FeathersControl, model:BaseModel) {
			super(view, model);
		}
		
		public function get currentGameId():Int64 {
			return _currentGameId;
		}
		
		override protected function addHandlers():void {
			view.backButton.addEventListener(Event.TRIGGERED, goBack);
			view.addEventListener(ClickOnTerritory.CLICKED_ON_TERRITORY, clickOnTerritoryHandler);
			model.addEventListener(ChangedNumberOfUnits.CHANGED_NUMBER_OF_UNITS, changedNumberOfUnitsOnTerritory);
		}
		
		private function goBack(e:Event):void {
			_currentGameId = null;
			mainScreenNavigator.showScreen(Screens.MENUS);
		}
		
		public function initForGame(gameContext:GameContextWrapper):void {
			_currentGameId = gameContext.gameId;
			
			model.initForGame(gameContext);
			// remove after all teritories are always sent
			for each (var territory:TerritoryWrapper in model.territories) {
				view.getTerritoryVisual(territory.id).territory = territory;
			}
			
			createActionPerformedForPhase();
			// populate players list
			view.playersList.dataProvider = new ListCollection(model.getAllPlayers());
		}
		
		private function clickOnTerritoryHandler(e:ClickOnTerritory):void {
			_actionPerformed.clickOnTerritory(e.territory);
		}
		
		private function createActionPerformedForPhase():void {
			switch(model.phase) {
				case GamePhase.WAITING_FOR_OPPONENTS_PHASE:
					_actionPerformed = new ActionPerformedWaitingForOpponents();
				case GamePhase.TROOP_DEPLOYMENT_PHASE:
					_actionPerformed = new ActionPerformedTroopDeployment(model);
					break;
				default:
					_actionPerformed = null;
			}
		}
		
		private function changedNumberOfUnitsOnTerritory(e:ChangedNumberOfUnits):void {
			view.getTerritoryVisual(e.territory).refresh();
		}
		
		public function newPlayerJoined(player:PlayerWrapper):void {
			model.newPlayerJoined(player);
			// redraw player list
			view.playersList.dataProvider = new ListCollection(model.getAllPlayers());
		}
	
	}

}