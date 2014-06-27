package modules.game {
	import com.netease.protobuf.Int64;
	import communication.protos.Command;
	import components.TerritoryVisual;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import modules.base.BaseController;
	import modules.base.BaseModel;
	import modules.game.classes.ActionPerformedAttack;
	import modules.game.classes.ActionPerformedTroopDeployment;
	import modules.game.classes.ActionPerformedWaitingForOpponents;
	import modules.game.classes.ArrowManager;
	import modules.game.classes.GamePhase;
	import modules.game.classes.IGameActionPerformed;
	import modules.game.events.AttackEvent;
	import modules.game.events.ChangedNumberOfUnits;
	import modules.game.events.ClickOnTerritory;
	import starling.events.Event;
	import utils.Alert;
	import utils.Globals;
	import utils.PlayerColors;
	import utils.Screens;
	import utils.Utilities;
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
		
		private var _arrowManager:ArrowManager;
		
		public function get model():GameModel {
			return _model as GameModel;
		}
		
		public function get view():GameView {
			return _view as GameView;
		}
		
		public function GameController(view:FeathersControl, model:BaseModel) {
			super(view, model);
			_arrowManager = new ArrowManager(this.view);
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
			model.addEventListener(AttackEvent.TERRITORY_ATTACK, attackExecuted);
		}
		
		private function goBack(e:Event):void {
			_currentGameId = null;
			mainScreenNavigator.showScreen(Screens.MENUS);
		}
		
		public function initForGame(gameContext:GameContextWrapper):void {
			Utilities.callWhenInitialized(view, function viewInitialized():void {
				_currentGameId = gameContext.gameId;
				
				model.initForGame(gameContext);
				// remove after all teritories are always sent
				for each (var territory:TerritoryWrapper in model.territories) {
					view.getTerritoryVisual(territory.id).territory = territory;
				}
				
				_arrowManager.clearAllArrows();
				// populate players list
				view.playersList.dataProvider = new ListCollection(model.getAllPlayers());
				
				unitsCount = model.numberOfMyUnits;
				
				switchToCurrentGamePhase();
				
			});
		}
		
		private function openingInTroopDeployment():void {
			_actionPerformed = new ActionPerformedTroopDeployment();
			
			view.numberOfReinforcements.visible = true;
			numberOfReinforcements = model.numberOfReinforcements;
		}
		
		private function openingInAttackPhase():void {
			_actionPerformed = new ActionPerformedAttack();
			
			view.numberOfReinforcements.visible = false;
			// show pending commands
			for each(var command:Command in model.pendingCommands) {
				var sourceTerritory:TerritoryWrapper = model.getTerritory(command.sourceTerritory);
				var destinationTerritory:TerritoryWrapper = model.getTerritory(command.destinationTerritory);
				
				_arrowManager.drawArrow(sourceTerritory, destinationTerritory, PlayerColors.getColor(model.me.color));
			}
		}
		
		private function openingInBattlePhase():void {
			trace("Battle phase");
		}
		
		private function clickOnTerritoryHandler(e:ClickOnTerritory):void {
			_actionPerformed.clickOnTerritory(e.territory);
		}
		
		private function switchToCurrentGamePhase():void {
			view.gamePhase.text = GamePhase.getPhaseName(model.phase);
			_arrowManager.clearAllArrows();
			
			switch (model.phase) {
				case GamePhase.TROOP_DEPLOYMENT_PHASE: 
					openingInTroopDeployment();
					break;
				case GamePhase.ATTACK_PHASE: 
					openingInAttackPhase();
					break;
				case GamePhase.BATTLE_PHASE:
					openingInBattlePhase();
					break;
				default: 
					throw new Error("Can't go into phase " + model.phase);
			}
		}
		
		private function changedNumberOfUnitsOnTerritory(e:ChangedNumberOfUnits):void {
			view.getTerritoryVisual(e.territory).refreshWholeComponent();
		}
		
		public function newPlayerJoined(player:PlayerWrapper):void {
			model.newPlayerJoined(player);
			// redraw player list
			view.playersList.dataProvider = new ListCollection(model.getAllPlayers());
		}
		
		private function commitClickHandler(e:Event):void {
			switch (model.phase) {
				case GamePhase.TROOP_DEPLOYMENT_PHASE: 
					if (model.numberOfReinforcements == 0) {
						model.submitPhase();
					} else {
						// can't commit round
						Alert.showMessage("Can't commit operation", "You can't commit reinforcements phase until you place all reinforcements");
					}
					break;
				case GamePhase.ATTACK_PHASE:
					model.submitPhase();
					break;
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
			switchToCurrentGamePhase();
		}
		
		private function attackExecuted(e:AttackEvent):void {
			var visualTerritory:TerritoryVisual = view.getTerritoryVisual(e.territoryFrom.id);
			visualTerritory.refreshNumberOfUnits();
			_arrowManager.drawArrow(e.territoryFrom, e.territoryTo, PlayerColors.getColor(model.me.color));
		}
	}

}