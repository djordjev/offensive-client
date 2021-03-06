package modules.game {
	import com.netease.protobuf.Int64;
	import communication.protos.Card;
	import communication.protos.Command;
	import communication.protos.PlayerCardCountNotification;
	import components.CardPopup;
	import components.common.LinkButton;
	import components.events.RollDicesClickEvent;
	import components.MyCardsPopup;
	import components.TerritoryBattle;
	import components.TerritoryVisual;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	import modules.base.BaseController;
	import modules.base.BaseModel;
	import modules.game.classes.ActionPerformedAttack;
	import modules.game.classes.ActionPerformedTroopDeployment;
	import modules.game.classes.ActionPerformedTroopRelocation;
	import modules.game.classes.ArrowManager;
	import modules.game.classes.GamePhase;
	import modules.game.classes.IGameActionPerformed;
	import modules.game.classes.Territories;
	import modules.game.events.AttackEvent;
	import modules.game.events.BattleEvent;
	import modules.game.events.ChangedNumberOfUnits;
	import modules.game.events.ClickOnTerritory;
	import modules.game.events.DicesEvent;
	import modules.game.events.NewCardAwardedEvent;
	import modules.game.events.PlayerDefeatedEvent;
	import modules.game.events.RelocationEvent;
	import modules.main.MainControlsController;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import utils.Alert;
	import utils.Globals;
	import utils.PlayerColors;
	import utils.Screens;
	import utils.Utilities;
	import wrappers.BattleInfoWrapper;
	import wrappers.CommandWrapper;
	import wrappers.GameContextWrapper;
	import wrappers.PlayerWrapper;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameController extends BaseController {
		
		private static const ZOOM_ANIMATION_DURATION:int = 1; // in seconds
		
		private static const GAME_RESULT_DISPLAY:int = 5000;
		
		private static var _instance:GameController;
		
		public static function get instance():GameController {
			if (_instance == null) {
				_instance = new GameController(Globals.instance.game.gameScreenView, GameModel.instance);
			}
			
			return _instance;
		}
		
		private var _actionPerformed:IGameActionPerformed;
		
		private var _arrowManager:ArrowManager;
		
		private var _mapZoom:Number = GameView.NORMAL_SCALE;
		
		private var _territoriesInCurrentBattle:Array = [];
		
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
			return model.gameId;
		}
		
		public function set numberOfReinforcements(value:int):void {
			view.numberOfReinforcements.text = "Reinforcements left: " + value.toString();
		}
		
		public function set unitsCount(value:int):void {
			view.unitsCount.text = "Units in game: " + value.toString();
		}
		
		override protected function addHandlers():void {
			
			view.addEventListener(ClickOnTerritory.CLICKED_ON_TERRITORY, clickOnTerritoryHandler);
			
			view.backButton.addEventListener(Event.TRIGGERED, goBack);
			view.commitButton.addEventListener(Event.TRIGGERED, commitClickHandler);
			view.cardsButton.addEventListener(Event.TRIGGERED, showMyCardsPopup);
			
			model.addEventListener(ChangedNumberOfUnits.CHANGED_NUMBER_OF_UNITS, changedNumberOfUnitsOnTerritory);
			model.addEventListener(GameModel.GAME_PHASE_COMMITED, gamePhaseCommited);
			model.addEventListener(GameModel.ADVANCED_TO_NEXT_PHASE, advancedToNextGamePhase);
			model.addEventListener(AttackEvent.TERRITORY_ATTACK, attackExecuted);
			model.addEventListener(GameModel.ALL_COMMANDS_RECEIVED, displayAllCommands);
			
			model.addEventListener(GameModel.BORDER_CLASHES_RECEIVED, displayBorderClashes);
			model.addEventListener(GameModel.MULTIPLE_ATTACKS_RECEIVED, displayMultipleAttacks);
			model.addEventListener(GameModel.SINGLE_ATTACKS_RECEIVED, displaySingleAttacks);
			model.addEventListener(GameModel.SPOILS_OF_WAR_RECEIVED, displaySpoilsOfWar);
			
			model.addEventListener(BattleEvent.ADVANCE_NO_NEXT_BATTLE, advanceToBattle);
			model.addEventListener(BattleEvent.BATTLE_ROUND_FINISHED, roundFinished);
			model.addEventListener(BattleEvent.BATTLE_VIEW_RESULTS_FINISHED, roundViewResultsFinished);
			model.addEventListener(BattleEvent.BATTLE_TIMER_TICK, battleTimerTick);
			model.addEventListener(BattleEvent.BATTLE_FINISHED, battleFinished);
			
			model.addEventListener(RelocationEvent.UNITS_RELOCATED, unitIsRelocated);
			
			model.addEventListener(GameModel.NUMBER_OF_CARDS_UPDATED, numberOfCardsUpdated);
			model.addEventListener(GameModel.REINFORCEMENTS_RECEIVED, reinforcementsReceived);
			model.addEventListener(NewCardAwardedEvent.NEW_CARD_RECEIVED, newCardAwarded);
			
			model.addEventListener(PlayerDefeatedEvent.OPPONEND_DEFEATED, playerDefeated);
			
			model.addEventListener(DicesEvent.DICES_ROLLED, opponentRolledDices);
			model.addEventListener(DicesEvent.OPPONENT_DIED_IN_BATTLE, participantDiedInBattle);
			//model.addEventListener
			
			view.addEventListener(RollDicesClickEvent.ROLL_CLICKED, rollClicked);
		}
		
		private function goBack(e:Event = null):void {
			model.disposeModel();
			mainScreenNavigator.showScreen(Screens.MENUS);
		}
		
		public function initForGame(gameContext:GameContextWrapper):void {
			Utilities.callWhenInitialized(view, function viewInitialized():void {
					model.initForGame(gameContext);
					// remove after all teritories are always sent
					for each (var territory:TerritoryWrapper in model.territories) {
						view.getTerritoryVisual(territory.id).territory = territory;
					}
					
					_arrowManager.clearAllArrows();
					// populate players list
					updatePlayersListView();
					
					unitsCount = model.numberOfMyUnits;
					
					switchToCurrentGamePhase();
					
					view.mapScale = GameView.NORMAL_SCALE;
					
					view.commitButton.isEnabled = !gameContext.isPlayedMove;
				});
			_territoriesInCurrentBattle = [];
		}
		
		private function openingInTroopDeployment():void {
			_actionPerformed = new ActionPerformedTroopDeployment();
			
			_arrowManager.clearAllArrows();
			view.numberOfReinforcements.visible = true;
			numberOfReinforcements = model.numberOfReinforcements;
		}
		
		private function openingInAttackPhase():void {
			_actionPerformed = new ActionPerformedAttack();
			
			view.numberOfReinforcements.visible = false;
			// show pending commands
			for each (var command:Command in model.pendingCommands) {
				var sourceTerritory:TerritoryWrapper = model.getTerritory(command.sourceTerritory);
				var destinationTerritory:TerritoryWrapper = model.getTerritory(command.destinationTerritory);
				
				_arrowManager.drawArrow(sourceTerritory, destinationTerritory, PlayerColors.getColor(model.me.color), _mapZoom);
			}
		}
		
		private function openingInTroopRelocationPhase():void {
			_actionPerformed = new ActionPerformedTroopRelocation();
			_arrowManager.clearAllArrows();
			focusMap();
		}
		
		private function openingInBattlePhase():void {
			trace("Battle phase");
			_arrowManager.clearAllArrows();
			view.commitButton.isEnabled = false;
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
				case GamePhase.TROOP_RELOCATION_PHASE: 
					openingInTroopRelocationPhase();
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
			updatePlayersListView();
		}
		
		private function commitClickHandler(e:Event):void {
			view.commitButton.isEnabled = false;
			switch (model.phase) {
				case GamePhase.TROOP_DEPLOYMENT_PHASE: 
					if (model.numberOfReinforcements == 0) {
						model.submitPhase();
					} else {
						// can't commit round
						view.commitButton.isEnabled = true;
						Alert.showMessage("Can't commit operation", "You can't commit reinforcements phase until you place all reinforcements");
					}
					break;
				case GamePhase.ATTACK_PHASE: 
					model.submitPhase();
					break;
				case GamePhase.TROOP_RELOCATION_PHASE: 
					model.submitPhase();
					break;
				default: 
					return;
			}
		}
		
		private function gamePhaseCommited(e:Event):void {
		}
		
		private function advancedToNextGamePhase(e:Event):void {
			view.commitButton.isEnabled = true;
			view.gamePhase.text = GamePhase.getPhaseName(model.phase);
			switchToCurrentGamePhase();
		}
		
		private function attackExecuted(e:AttackEvent):void {
			var visualTerritory:TerritoryVisual = view.getTerritoryVisual(e.territoryFrom.id);
			visualTerritory.refreshNumberOfUnits();
			_arrowManager.drawArrow(e.territoryFrom, e.territoryTo, PlayerColors.getColor(model.me.color), _mapZoom);
		}
		
		private function displayAllCommands(e:Event):void {
			var source:TerritoryWrapper;
			var dest:TerritoryWrapper;
			var regularCommands:Dictionary = new Dictionary();
			// this array has to have even number of elements, so clash is attack on position i and i+1 
			var borderClashes:Array = [];
			for each (var command:Command in model.allCommands) {
				source = model.getTerritory(command.sourceTerritory);
				dest = model.getTerritory(command.destinationTerritory);
				if (regularCommands[dest.id + "*" + source.id] != null) {
					// this is border clash
					var otherCommand:Command = regularCommands[dest.id + "*" + source.id];
					delete regularCommands[dest.id + "*" + source.id];
					borderClashes.push(otherCommand);
					borderClashes.push(command);
				} else {
					// potential regular attack
					regularCommands[source.id + "*" + dest.id] = command;
				}
				
				view.getTerritoryVisual(source.id).refreshNumberOfUnits();
			}
			
			// draw regular attack
			for each (var regularCommand:Command in regularCommands) {
				source = model.getTerritory(regularCommand.sourceTerritory);
				dest = model.getTerritory(regularCommand.destinationTerritory);
				_arrowManager.drawArrow(source, dest, PlayerColors.getColor(source.owner.color), _mapZoom);
			}
			
			// draw border clashes
			for (var i:int = 0; i < borderClashes.length; i += 2) {
				source = model.getTerritory(borderClashes[i].sourceTerritory);
				dest = model.getTerritory(borderClashes[i + 1].sourceTerritory);
				_arrowManager.drawDoubleArrow(source, dest, _mapZoom);
			}
		}
		
		private function focusOn(territories:Array, callback:Function = null):void {
			var lowY:int = int.MAX_VALUE;
			var lowX:int = int.MAX_VALUE;
			var highY:int = 0;
			var highX:int = 0;
			
			for each (var territory:TerritoryWrapper in territories) {
				var visualTerritory:TerritoryVisual = view.getTerritoryVisual(territory.id);
				var visualTerritoryPosition:Point = Territories.getTerritoryPosition(territory.id);
				
				lowY = Math.min(lowY, visualTerritoryPosition.y);
				lowX = Math.min(lowX, visualTerritoryPosition.x);
				
				highX = Math.max(highX, visualTerritoryPosition.x + visualTerritory.width);
				highY = Math.max(highY, visualTerritoryPosition.y + visualTerritory.height);
			}
			
			var xOffset:int = Math.max(0, (Globals.SCREEN_WIDTH - (highX - lowX)) / 2);
			var yOffset:int = Math.max(0, (Globals.SCREEN_HEIGHT - (highY - lowY)) / 2);
			
			var tween:Tween = new Tween(view, ZOOM_ANIMATION_DURATION, Transitions.EASE_IN);
			tween.animate("mapX", -(lowX - xOffset));
			tween.animate("mapY", -(lowY - yOffset));
			tween.animate("mapScale", 1);
			
			var self:GameController = this;
			tween.onComplete = function():void {
				self._mapZoom = 1;
				if (callback != null) {
					callback();
				}
			};
			
			Starling.juggler.add(tween);
		}
		
		private function focusMap(callback:Function = null):void {
			var tween:Tween = new Tween(view, ZOOM_ANIMATION_DURATION, Transitions.EASE_IN);
			tween.animate("mapX", 0);
			tween.animate("mapY", 0);
			tween.animate("mapScale", GameView.NORMAL_SCALE);
			
			var self:GameController = this;
			tween.onComplete = function():void {
				self._mapZoom = GameView.NORMAL_SCALE;
				if (callback != null) {
					callback();
				}
			};
			
			Starling.juggler.add(tween);
		}
		
		private function displayBorderClashes(e:Event):void {
			trace("Border clashes");
		}
		
		private function displayMultipleAttacks(e:Event):void {
			trace("Multiple attacks");
		}
		
		private function displaySingleAttacks(e:Event):void {
			trace("Single attacks");
		}
		
		private function displaySpoilsOfWar(e:Event):void {
			trace("Spoils of War");
		}
		
		private function advanceToBattle(event:BattleEvent):void {
			trace("Advance to next battle");
			var affectedTerritories:Dictionary = new Dictionary();
			var myTerritories:Array = [];
			var command:CommandWrapper
			
			for each (command in event.battleInfo.allCommands) {
				var source:TerritoryWrapper = command.sourceTerrotiry;
				var destionation:TerritoryWrapper = command.destionationTerritory;
				
				affectedTerritories[source.id.toString()] = source;
				affectedTerritories[destionation.id.toString()] = destionation;
				
				if (source.owner.playerId == model.me.playerId) {
					myTerritories.push(source);
				}
				
			}
			
			_territoriesInCurrentBattle = [];
			
			for each (var t:TerritoryWrapper in affectedTerritories) {
				_territoriesInCurrentBattle.push(t);
			}
			
			displayBattle(_territoriesInCurrentBattle, myTerritories, event.battleInfo);
		}
		
		private function battleTimerTick(e:BattleEvent):void {
			for each (var territory:TerritoryWrapper in _territoriesInCurrentBattle) {
				var visualTerritory:TerritoryVisual = view.getTerritoryVisual(territory.id);
				visualTerritory.battleDisplay.setRemainingTime(e.remainingTime);
			}
		}
		
		private function roundFinished(e:BattleEvent):void {
			// update number of remaining units
			for each (var command:CommandWrapper in model.currentBattle.allCommands) {
				var visualTerritory:TerritoryVisual = view.getTerritoryVisual(command.sourceTerrotiry.id);
				
				visualTerritory.battleDisplay.numberOfUnits = command.numberOfUnits;
				
				if (command.dicesResults != null) {
					for (var i:int = 0; i < command.dicesResults.length; i++) {
						visualTerritory.battleDisplay.highlightDice(i, command.dicesResults[i]);
					}
				}
				
			}
		
		}
		
		private function roundViewResultsFinished(e:BattleEvent):void {
			for each (var command:CommandWrapper in model.currentBattle.allCommands) {
				
				var visualTerritory:TerritoryVisual = view.getTerritoryVisual(command.sourceTerrotiry.id);
				
				visualTerritory.battleDisplay.rollButton.isEnabled = true;
				visualTerritory.battleDisplay.clearDices();
				
				if (!command.isAlive) {
					visualTerritory.battleDisplay.hide();
				}
			}
		}
		
		private function opponentRolledDices(e:DicesEvent):void {
			var territoryComponent:TerritoryVisual = view.getTerritoryVisual(e.command.sourceTerrotiry.id);
			territoryComponent.battleDisplay.setDices(e.command.dices());
		}
		
		private function participantDiedInBattle(e:DicesEvent):void {
			var visualTerritory:TerritoryVisual = view.getTerritoryVisual(e.command.sourceTerrotiry.id);
			// TODO Display something showing that he's dead
		}
		
		private function battleFinished(e:BattleEvent):void {
			removeAllBattleInfos();
			_territoriesInCurrentBattle = [];
			updateViewAfterBattle(e.battleInfo);
			focusMap();
		}
		
		/** @param territories - Array of TerritoryWrapper */
		private function displayBattle(territories:Array, myTerritories:Array, battle:BattleInfoWrapper):void {
			// focus on selected territories
			focusOn(territories, function focusOnFinished():void {
					for each (var command:CommandWrapper in battle.allCommands) {
						var territory:TerritoryWrapper = command.sourceTerrotiry;
						var visualTerritory:TerritoryVisual = view.getTerritoryVisual(territory.id);
						
						if (model.isMyTerritoryOnTheStartOfPhase(territory.id)) {
							visualTerritory.battleDisplay.show(true);
						} else {
							visualTerritory.battleDisplay.show(false);
						}
						
						visualTerritory.battleDisplay.side = command.isAttacking ? "Attacker" : "Defender";
						visualTerritory.battleDisplay.numberOfUnits = command.numberOfUnits;
					}
				});
		
		}
		
		private function removeAllBattleInfos():void {
			view.battleInfoGroup.removeChildren();
		}
		
		private function rollClicked(e:RollDicesClickEvent):void {
			(e.target as TerritoryBattle).rollButton.isEnabled = false;
			var territory:TerritoryWrapper = e.territoryClicked;
			
			model.rollMyDice(territory);
		}
		
		private function updateViewAfterBattle(battle:BattleInfoWrapper):void {
			var command:CommandWrapper;
			
			if (model.subphase == GamePhase.SUBPHASE_BORDER_CLASHES) {
				// border clashes
				updateViewAfterBorderClash(battle);
			} else {
				var firstCommand:CommandWrapper = battle.getFirstLiveCommand();
				// other phases
				if (numberOfUniqueSurvivors(battle) == 1) {
					// only one player survived so battle is over
					if (isDefender(firstCommand)) {
						var defendingCommand:CommandWrapper = firstCommand;
						// only survivor is defender - return units from attack to territory
						defendingCommand.sourceTerrotiry.troopsOnIt = defendingCommand.numberOfUnits;
						view.getTerritoryVisual(defendingCommand.sourceTerrotiry.id).refreshNumberOfUnits();
					} else {
						// only survivor is attacker
						var survivedUnits:int = 0;
						for each (command in battle.allCommands) {
							if (command.isAlive) {
								survivedUnits += command.numberOfUnits;
							}
						}
						
						firstCommand.destionationTerritory.conquer(firstCommand.sourceTerrotiry.owner, survivedUnits);
						view.getTerritoryVisual(firstCommand.destionationTerritory.id).refreshWholeComponent();
					}
				} else {
					// more players survived - spoils of war will happen
					firstCommand.destionationTerritory.troopsOnIt = 0;
					view.getTerritoryVisual(firstCommand.destionationTerritory.id).refreshNumberOfUnits();
				}
			}
		}
		
		private function updateViewAfterBorderClash(battle:BattleInfoWrapper):void {
			var oneSide:CommandWrapper = battle.oneSide[0];
			var otherSide:CommandWrapper = battle.otherSide[0];
			
			_arrowManager.removeDoubleArrow(oneSide.destionationTerritory, otherSide.destionationTerritory);
			
			if (oneSide.numberOfUnits == 0) {
				_arrowManager.drawArrow(otherSide.sourceTerrotiry, otherSide.destionationTerritory, PlayerColors.getColor(otherSide.sourceTerrotiry.owner.color), _mapZoom);
			} else {
				_arrowManager.drawArrow(oneSide.sourceTerrotiry, oneSide.destionationTerritory, PlayerColors.getColor(oneSide.sourceTerrotiry.owner.color), _mapZoom);
			}
		}
		
		private function numberOfUniqueSurvivors(battle:BattleInfoWrapper):int {
			var survivorsCount:int = 0;
			var survivers:Dictionary = new Dictionary();
			
			for each (var command:CommandWrapper in battle.allCommands) {
				if (command.isAlive) {
					survivers[command.sourceTerrotiry.owner.playerId.toString()] = true;
				}
			}
			
			for each (var cnt:Boolean in survivers) {
				survivorsCount++;
			}
			
			return survivorsCount;
		}
		
		private function isDefender(command:CommandWrapper):Boolean {
			return command.sourceTerrotiry.id == command.destionationTerritory.id;
		}
		
		private function unitIsRelocated(e:RelocationEvent):void {
			var fromTerritoryVisual:TerritoryVisual = view.getTerritoryVisual(e.fromTerritory.id);
			var toTerritoryVisual:TerritoryVisual = view.getTerritoryVisual(e.toTerritory.id);
			
			fromTerritoryVisual.refreshNumberOfUnits();
			toTerritoryVisual.refreshNumberOfUnits();
			
			_arrowManager.drawArrow(e.fromTerritory, e.toTerritory, PlayerColors.getColor(e.fromTerritory.owner.color), _mapZoom);
		}
		
		private function showMyCardsPopup(e:Event):void {
			MyCardsPopup.instance.showPopup(model.myCards, function cardsForTradeSelected(card1:Card, card2:Card, card3:Card):void {
					if (card1 != null && card2 != null && card3 != null) {
						if (model.phase == GamePhase.TROOP_DEPLOYMENT_PHASE) {
							model.tradeCards(card1, card2, card3, cardsSuccessfullyTraded);
						} else {
							Alert.showMessage("Trade Cards", "You can't trade cards in game phase that is not troop deployment");
						}
						
					}
				});
		}
		
		private function cardsSuccessfullyTraded(numberOfReinforcements:int):void {
			if (numberOfReinforcements > 0) {
				Alert.showMessage("Cards", "Cards successfully traded");
			}
			updatePlayersListView();
			reinforcementsReceived();
		}
		
		public function newCardAwarded(e:NewCardAwardedEvent):void {
			CardPopup.instance.showCard(e.card);
		}
		
		public function numberOfCardsUpdated(e:Event):void {
			updatePlayersListView();
		}
		
		private function updatePlayersListView():void {
			view.playersList.dataProvider = null;
			view.playersList.validate();
			view.playersList.dataProvider = new ListCollection(model.getAllPlayers());
		}
		
		private function reinforcementsReceived(e:Event = null):void {
			numberOfReinforcements = model.me.numberOdReinforcements;
		}
		
		private function playerDefeated(e:PlayerDefeatedEvent):void {
			if (e.opponent.playerId == model.me.playerId) {
				// game over
				Alert.showMessage("Game Over", "You have been defeated");
				setTimeout(function meDefeated():void {
					goBack();
					MainControlsController.instance.gameOver(model.gameId);
				}, GAME_RESULT_DISPLAY);
			} else {
				updatePlayersListView();
				// opponent defeated
				if (model.opponents.length == 0) {
					// I won
					Alert.showMessage("Victory", "You have defeated all opponents");
					setTimeout(function meDefeated():void {
						goBack();
						MainControlsController.instance.gameOver(model.gameId);
					}, GAME_RESULT_DISPLAY);
				}
			}
		}
	
	}

}