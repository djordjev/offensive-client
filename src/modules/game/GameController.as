package modules.game {
	import com.netease.protobuf.Int64;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import modules.base.BaseController;
	import modules.base.BaseModel;
	import modules.game.classes.ActionPerformedAttack;
	import modules.game.classes.ActionPerformedTroopDeployment;
	import modules.game.classes.ActionPerformedWaitingForOpponents;
	import modules.game.classes.GamePhase;
	import modules.game.classes.IGameActionPerformed;
	import modules.game.events.ChangedNumberOfUnits;
	import modules.game.events.ClickOnTerritory;
	import starling.events.Event;
	import utils.Alert;
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
		
		public function set numberOfReinforcements(value:int):void {
			view.numberOfReinforcements.text = "Reinforcements left: " + value.toString();
		}
		
		public function set unitsCount(value:int):void {
			view.unitsCount.text = "Units in game: " + value.toString();
		}
		
		override protected function addHandlers():void {
			view.backButton.addEventListener(Event.TRIGGERED, goBack);
			view.addEventListener(ClickOnTerritory.CLICKED_ON_TERRITORY, clickOnTerritoryHandler);
			view.commitButton.addEventListener(Event.TRIGGERED, commitClickHandler);
			model.addEventListener(ChangedNumberOfUnits.CHANGED_NUMBER_OF_UNITS, changedNumberOfUnitsOnTerritory);
			model.addEventListener(GameModel.GAME_PHASE_COMMITED, gamePhaseCommited);
			model.addEventListener(GameModel.ADVANCED_TO_NEXT_PHASE, advancedToNextGamePhase);
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
			
			view.gamePhase.text = GamePhase.getPhaseName(gameContext.phase);
			unitsCount = model.numberOfMyUnits;
			numberOfReinforcements = model.numberOfReinforcements;
		}
		
		private function clickOnTerritoryHandler(e:ClickOnTerritory):void {
			_actionPerformed.clickOnTerritory(e.territory);
		}
		
		private function createActionPerformedForPhase():void {
			switch(model.phase) {
				case GamePhase.TROOP_DEPLOYMENT_PHASE:
					_actionPerformed = new ActionPerformedTroopDeployment();
					break;
				case GamePhase.ATTACK_PHASE:
					_actionPerformed = new ActionPerformedAttack();
					break;
				default:
					throw new Error("Can't go into phase " + model.phase);
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
		
		private function commitClickHandler(e:Event):void {
			switch(model.phase) {
				case GamePhase.TROOP_DEPLOYMENT_PHASE:
					if (model.numberOfReinforcements == 0) {
						model.submitPhase();
					} else {
						// can't commit round
						Alert.showMessage("Can't commit operation",
							"You can't commit reinforcements phase until you place all reinforcements");
					}
				default:
					return;
			}
		}
		
		private function gamePhaseCommited(e:Event):void {
			view.commitButton.isEnabled = false;
		}
		
		private function advancedToNextGamePhase(e:Event):void {
			view.commitButton.isEnabled = true;
			view.gamePhase.text = GamePhase.getPhaseName(model.phase);
			createActionPerformedForPhase();
		}
	}

}