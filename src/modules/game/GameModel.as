package modules.game {
	import com.netease.protobuf.Int64;
	import communication.Communicator;
	import communication.HandlerCodes;
	import communication.Me;
	import communication.ProtocolMessage;
	import communication.protos.AddUnitRequest;
	import communication.protos.AdvancePhaseNotification;
	import communication.protos.AllCommands;
	import communication.protos.AttackRequest;
	import communication.protos.BattleInfo;
	import communication.protos.BorderClashes;
	import communication.protos.Card;
	import communication.protos.Command;
	import communication.protos.CommandsSubmittedRequest;
	import communication.protos.MoveUnitsRequest;
	import communication.protos.MoveUnitsResponse;
	import communication.protos.MultipleAttacks;
	import communication.protos.PlayerCardCountNotification;
	import communication.protos.PlayerRolledDice;
	import communication.protos.RollDiceClicked;
	import communication.protos.SingleAttacks;
	import communication.protos.SpoilsOfWar;
	import communication.protos.Territory;
	import communication.protos.TradeCardsRequest;
	import communication.protos.TradeCardsResponse;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import modules.base.BaseModel;
	import modules.game.classes.GamePhase;
	import modules.game.events.AttackEvent;
	import modules.game.events.BattleEvent;
	import modules.game.events.ChangedNumberOfUnits;
	import modules.game.events.DicesEvent;
	import modules.game.events.NewCardAwardedEvent;
	import modules.game.events.RelocationEvent;
	import starling.events.Event;
	import utils.Globals;
	import wrappers.BattleInfoWrapper;
	import wrappers.CommandWrapper;
	import wrappers.GameContextWrapper;
	import wrappers.PlayerWrapper;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameModel extends BaseModel {
		
		public static const GAME_PHASE_COMMITED:String = "game phase changed";
		public static const ADVANCED_TO_NEXT_PHASE:String = "advanced to next phase";
		
		public static const ALL_COMMANDS_RECEIVED:String = "all commands received";
		
		public static const BORDER_CLASHES_RECEIVED:String = "border clashes received";
		public static const MULTIPLE_ATTACKS_RECEIVED:String = "multiple attacks received";
		public static const SINGLE_ATTACKS_RECEIVED:String = "single attacks received";
		public static const SPOILS_OF_WAR_RECEIVED:String = "spoils of war received";
		
		public static const NUMBER_OF_CARDS_UPDATED:String = "number of cards updated";
		public static const REINFORCEMENTS_RECEIVED:String = "reinforcements received";
		
		public static const MAX_DICES:int = 3;
		
		private static const ADDING_UNITS_ON_TRADE:int = 2;
		
		public static const TIME_FOR_ROLL:int = 10; // seconds
		public static const TIME_FOR_DISPLAY_RESULTS:int = 1500; // milliseconds
		
		private var _gameName:String;
		private var _gameId:Int64;
		private var _me:PlayerWrapper;
		private var _opponents:Array; // array of PlayerWrappers
		private var _objective:int;
		private var _round:int;
		private var _phase:int;
		private var _allPlayers:Dictionary; // Dictionary playerId -> PlayerWrapper
		private var _myCards:Array = [];
		/** mapping territory id to TerritoryWrapper */
		private var _territories:Dictionary;
		private var _pendingCommands:Array;
		
		private var _numberOfMyUnits:int;
		
		private var _subphase:int;
		
		/** All commands in battle phase */
		private var _allCommands:Array;
		
		private var _subphaseBattles:Array;
		
		private var _currentBattle:BattleInfoWrapper;
		
		private var _currentBattleTimer:Timer;
		
		private static var _instance:GameModel;
		
		public static function get instance():GameModel {
			if (_instance == null) {
				_instance = new GameModel();
			}
			return _instance;
		}
		
		public function GameModel() {
			super();
		}
		
		public function get territories():Dictionary {
			return _territories;
		}
		
		public function get phase():int {
			return _phase;
		}
		
		public function get subphase():int {
			return _subphase;
		}
		
		public function get me():PlayerWrapper {
			return _me;
		}
		
		public function get numberOfMyUnits():int {
			return _numberOfMyUnits;
		}
		
		public function get pendingCommands():Array {
			return _pendingCommands;
		}
		
		public function get gameId():Int64 {
			return _gameId;
		}
		
		public function get allCommands():Array {
			return _allCommands;
		}
		
		public function get borderClashes():Array {
			return _subphaseBattles;
		}
		
		public function get currentBattle():BattleInfoWrapper {
			return _currentBattle;
		}
		
		public function get myCards():Array {
			return _myCards;
		}
		
		public function initForGame(gameContext:GameContextWrapper):void {
			_gameName = gameContext.gameName;
			_gameId = gameContext.gameId;
			_myCards = gameContext.myCards;
			_opponents = [];
			_allPlayers = new Dictionary();
			for each (var playerWrapper:PlayerWrapper in gameContext.players) {
				if (!playerWrapper.isDummy && playerWrapper.userWrapper.userId.toString() == Me.instance.userIdAsString) {
					_me = playerWrapper;
				} else {
					_opponents.push(playerWrapper);
				}
				
				_allPlayers[playerWrapper.playerId.toString()] = playerWrapper;
			}
			_objective = gameContext.objective;
			_round = gameContext.round;
			_phase = gameContext.phase;
			
			_territories = new Dictionary();
			_numberOfMyUnits = 0;
			for each (var territory:TerritoryWrapper in gameContext.terrotiries) {
				_territories[territory.id] = territory;
				var owner:PlayerWrapper = getPlayerByPlayerId(territory.playerId);
				_territories[territory.id].conquer(owner, territory.troopsOnIt);
				if (!owner.isDummy) {
					owner.numberOfTerritories++;
				}
				if (owner.userIdAsString == _me.userIdAsString) {
					_numberOfMyUnits += territory.troopsOnIt;
				}
			}
			
			_allCommands = null;
			_subphaseBattles = null;
			_pendingCommands = gameContext.pendingCommands;
		}
		
		public function getPlayerByPlayerId(playerId:int):PlayerWrapper {
			return _allPlayers[playerId.toString()];
		}
		
		public function get numberOfReinforcements():int {
			if (_phase == GamePhase.TROOP_DEPLOYMENT_PHASE) {
				return _me.numberOdReinforcements;
			}
			return 0;
		}
		
		/** Asynch send to server. Not waiting response. */
		public function addReinforcement(territoryId:int):void {
			if (numberOfReinforcements > 0) {
				var request:AddUnitRequest = new AddUnitRequest();
				request.gameId = _gameId;
				request.territoryId = territoryId;
				Communicator.instance.send(HandlerCodes.ADD_UNIT, request, null);
				_me.numberOdReinforcements--;
				var territory:TerritoryWrapper = _territories[territoryId];
				territory.troopsOnIt++;
				_numberOfMyUnits++;
				dispatchEvent(new ChangedNumberOfUnits(ChangedNumberOfUnits.CHANGED_NUMBER_OF_UNITS, territoryId));
			}
		}
		
		public function getAllPlayers():Array {
			var onlyMe:Array = [_me];
			return onlyMe.concat(_opponents);
		}
		
		public function newPlayerJoined(player:PlayerWrapper):void {
			for (var i:int = 0; i < _opponents.length; i++) {
				if ((_opponents[i] as PlayerWrapper).playerId == player.playerId) {
					_opponents[i] = player;
					_allPlayers[player.playerId.toString()] = player;
					break;
				}
			}
		}
		
		public function submitPhase():void {
			var request:CommandsSubmittedRequest = new CommandsSubmittedRequest();
			request.gameId = _gameId;
			Communicator.instance.send(HandlerCodes.COMMANDS_SUBMIT, request, function phaseChanged(e:ProtocolMessage):void {
					dispatchEvent(new Event(GAME_PHASE_COMMITED));
				});
		}
		
		public function advancedToNextPhase(response:AdvancePhaseNotification):void {
			_phase = (_phase + 1) % 4;
			_currentBattle = null;
			switch (_phase) {
				case GamePhase.TROOP_DEPLOYMENT_PHASE: 
					_subphase = GamePhase.SUBPHASE_NO_SUBPHASE;
					advanceToTroopDeploymentPhase(response);
					break;
				case GamePhase.ATTACK_PHASE: 
					_subphase = GamePhase.SUBPHASE_NO_SUBPHASE;
					advanceToAttackPhase(response);
					break;
				case GamePhase.BATTLE_PHASE: 
					break;
				case GamePhase.TROOP_RELOCATION_PHASE: 
					_subphase = GamePhase.SUBPHASE_NO_SUBPHASE;
					advanceToRelocationPhase(response);
					break;
				default: 
					break;
			}
			dispatchEvent(new Event(ADVANCED_TO_NEXT_PHASE));
		}
		
		public function attack(territoryFrom:TerritoryWrapper, territoryTo:TerritoryWrapper, numberOfUnits:uint):void {
			trace("Attacking " + territoryFrom.name + " to " + territoryTo.name + " with " + numberOfUnits + " units");
			var request:AttackRequest = new AttackRequest();
			request.gameId = _gameId;
			request.command = new Command();
			request.command.sourceTerritory = territoryFrom.id;
			request.command.destinationTerritory = territoryTo.id;
			request.command.numberOfUnits = numberOfUnits;
			Communicator.instance.send(HandlerCodes.ATTACK, request, function attackResponseReceived(message:ProtocolMessage):void {
					territoryFrom.troopsOnIt -= numberOfUnits;
					dispatchEvent(new AttackEvent(AttackEvent.TERRITORY_ATTACK, territoryFrom, territoryTo, numberOfUnits));
				});
		}
		
		private function advanceToTroopDeploymentPhase(response:AdvancePhaseNotification):void {
			updateNumberOfUnits(response.territories);
		}
		
		private function advanceToAttackPhase(response:AdvancePhaseNotification):void {
			updateNumberOfUnits(response.territories);
		}
		
		private function advanceToRelocationPhase(response:AdvancePhaseNotification):void {
			updateNumberOfUnits(response.territories);
		}
		
		private function updateNumberOfUnits(territories:Array):void {
			// update number of units on territories
			for each (var territory:Territory in territories) {
				var playerOnIt:PlayerWrapper = getPlayerByPlayerId(territory.playerId);
				(_territories[territory.id] as TerritoryWrapper).conquer(playerOnIt, territory.troopsOnIt);
				dispatchEvent(new ChangedNumberOfUnits(ChangedNumberOfUnits.CHANGED_NUMBER_OF_UNITS, territory.id));
			}
		}
		
		public function getTerritory(id:int):TerritoryWrapper {
			return _territories[id] as TerritoryWrapper;
		}
		
		public function disposeModel():void {
			_gameId == null;
			_allCommands = null;
			_subphaseBattles = null;
			_currentBattle = null;
			_myCards = [];
			if (_currentBattleTimer != null) {
				_currentBattleTimer.stop();
				_currentBattleTimer = null;
			}
			// reset other fields
		}
		
		public function allCommandsReceived(allCommands:AllCommands):void {
			if (_phase == GamePhase.BATTLE_PHASE) {
				_allCommands = allCommands.commands;
				
				for each (var command:Command in allCommands.commands) {
					var issuerTerritory:TerritoryWrapper = getTerritory(command.sourceTerritory);
					
					if (issuerTerritory.owner.playerId != _me.playerId && command.sourceTerritory != command.destinationTerritory) {
						issuerTerritory.troopsOnIt -= command.numberOfUnits;
					}
				}
				dispatchEvent(new Event(ALL_COMMANDS_RECEIVED));
			} else {
				trace("Received all commands in phase that is not battle phase. Phase " + GamePhase.getPhaseName(_phase));
			}
		}
		
		public function borderClashesReceived(borderClashes:BorderClashes):void {
			if (_phase == GamePhase.BATTLE_PHASE) {
				_subphase = GamePhase.SUBPHASE_BORDER_CLASHES;
				_subphaseBattles = borderClashes.battleInfo;
				dispatchEvent(new Event(BORDER_CLASHES_RECEIVED));
			} else {
				trace("Received border clashes in phase that is not battle phase. Phase " + GamePhase.getPhaseName(_phase));
			}
		}
		
		public function multipleAttacksReceived(multipleAttacks:MultipleAttacks):void {
			if (_phase == GamePhase.BATTLE_PHASE) {
				_subphase = GamePhase.SUBPHASE_MULTIPLE_ATTACKS;
				_subphaseBattles = multipleAttacks.battleInfo;
				dispatchEvent(new Event(MULTIPLE_ATTACKS_RECEIVED));
			} else {
				trace("Received multiple attacks in phase that is not battle phase. Phase " + GamePhase.getPhaseName(_phase));
			}
		}
		
		public function singleAttacksReceived(singleAttacks:SingleAttacks):void {
			if (_phase == GamePhase.BATTLE_PHASE) {
				_subphase = GamePhase.SUBPHASE_SINGLE_ATTACKS;
				_subphaseBattles = singleAttacks.battleInfo;
				dispatchEvent(new Event(SINGLE_ATTACKS_RECEIVED));
			} else {
				trace("Received single attacks in phase that is not battle phase. Phase " + GamePhase.getPhaseName(_phase));
			}
		}
		
		public function spoilsOfWarReceived(spoilsOfWar:SpoilsOfWar):void {
			if (_phase == GamePhase.BATTLE_PHASE) {
				_subphase = GamePhase.SUBPHASE_SPOILS_OF_WAR;
				_subphaseBattles = spoilsOfWar.battleInfo;
				dispatchEvent(new Event(SPOILS_OF_WAR_RECEIVED));
			} else {
				trace("Received spoils of war in phase that is not battle phase. Phase " + GamePhase.getPhaseName(_phase));
			}
		}
		
		public function advanceToNextBattle(battleInfo:BattleInfo):void {
			_currentBattle = BattleInfoWrapper.buildBattleInfoWrapper(battleInfo);
			setUpTimers();
			dispatchEvent(new BattleEvent(BattleEvent.ADVANCE_NO_NEXT_BATTLE, _currentBattle, TIME_FOR_ROLL));
		}
		
		private function setUpTimers():void {
			_currentBattleTimer = new Timer(Globals.ONE_SECOND, TIME_FOR_ROLL);
			_currentBattleTimer.addEventListener(TimerEvent.TIMER, function tickTimer(e:TimerEvent):void {
					dispatchEvent(new BattleEvent(BattleEvent.BATTLE_TIMER_TICK, _currentBattle, TIME_FOR_ROLL - (e.currentTarget as Timer).currentCount));
				});
			
			_currentBattleTimer.start();
		}
		
		private function roundFinished():void {
			var command:CommandWrapper;
			
			for each (command in _currentBattle.allCommands) {
				if (command.sourceTerrotiry.owner.playerId.toString() == _me.playerId.toString() && !command.isRolled) {
					rollMyDice(territories[command.sourceTerrotiry.id]);
				}
			}
			
			var isFinished:Boolean = calculateCasualties();
			
			setTimeout(setUpNewRound, TIME_FOR_DISPLAY_RESULTS, isFinished);
		}
		
		private function setUpNewRound(isFinished:Boolean):void {
			dispatchEvent(new BattleEvent(BattleEvent.BATTLE_VIEW_RESULTS_FINISHED, _currentBattle));
			if (isFinished) {
				dispatchEvent(new BattleEvent(BattleEvent.BATTLE_FINISHED, _currentBattle));
			} else {
				setUpTimers();
			}
			
			for each (var command:CommandWrapper in _currentBattle.allCommands) {
				command.clearDices();
			}
			_currentBattle.clearNumberOfRolledDices();
		}
		
		/** Returns whether battle is finished */
		private function calculateCasualties():Boolean {
			var isBattleFinished:Boolean;
			
			if (_subphase == GamePhase.SUBPHASE_BORDER_CLASHES) {
				calculateCasualtiesBorderClash();
			} else if (_subphase == GamePhase.SUBPHASE_SPOILS_OF_WAR) {
				calculateCasualtiesSpoilsOfWar();
			} else {
				calculateCasualtiesTwoSidedBattle();
			}
			
			var died:Array = _currentBattle.killLosingParticipants();
			for each (var command:CommandWrapper in died) {
				dispatchEvent(new DicesEvent(DicesEvent.OPPONENT_DIED_IN_BATTLE, command));
			}
			
			return _currentBattle.isFinished(_subphase);
		}
		
		private function calculateCasualtiesBorderClash():void {
			var numberOfDicesInBattle:int = _currentBattle.minNumberOfDices();
			
			var firstCommand:CommandWrapper = _currentBattle.oneSide[0];
			var secondCommand:CommandWrapper = _currentBattle.otherSide[0];
			
			for (var i:int = 0; i < numberOfDicesInBattle; i++) {
				if (firstCommand.dices()[i] < secondCommand.dices()[i]) {
					firstCommand.removeUnit();
					firstCommand.setDiceResult(i, CommandWrapper.DICE_LOST);
					secondCommand.setDiceResult(i, CommandWrapper.DICE_WON);
				} else if (firstCommand.dices()[i] > secondCommand.dices()[i]) {
					secondCommand.removeUnit();
					firstCommand.setDiceResult(i, CommandWrapper.DICE_WON);
					secondCommand.setDiceResult(i, CommandWrapper.DICE_LOST);
				} else {
					firstCommand.setDiceResult(i, CommandWrapper.DICE_EQUAL);
					secondCommand.setDiceResult(i, CommandWrapper.DICE_EQUAL);
				}
			}
		}
		
		private function calculateCasualtiesSpoilsOfWar():void {
			var numberOfDicesInBattle:int = _currentBattle.minNumberOfDices();
			var command:CommandWrapper;
			
			for (var i:int = 0; i < numberOfDicesInBattle; i++) {
				var commandWithBiggestDice:CommandWrapper = null;
				// find command with biggest dice
				for each (command in _currentBattle.oneSide) {
					if (commandWithBiggestDice == null || command.dices()[i] > commandWithBiggestDice) {
						commandWithBiggestDice = command;
					}
				}
				commandWithBiggestDice.setDiceResult(i, CommandWrapper.DICE_WON);
				
				// remove units to others
				for each (command in _currentBattle.oneSide) {
					if (commandWithBiggestDice.dices()[i] > command.dices()[i] && commandWithBiggestDice.sourceTerrotiry.id != command.sourceTerrotiry.id) {
						command.removeUnit();
						command.setDiceResult(i, CommandWrapper.DICE_LOST);
					}
				}
				
			}
		}
		
		private function calculateCasualtiesTwoSidedBattle():void {
			var sides:Object = determineAttackerDefender();
			var numberOfDicesInBattle:int = _currentBattle.minNumberOfDices();
			
			var attackers:Array = sides.attacker;
			var defender:CommandWrapper = sides.defender[0]; // there can be only one defender
			
			for (var i:int = 0; i < numberOfDicesInBattle; i++) {
				// find attacker biggest dice
				var biggestAttackerDice:int = 0;
				var singleAttacker:CommandWrapper;
				for each (singleAttacker in attackers) {
					if (singleAttacker.dices()[i] > biggestAttackerDice) {
						biggestAttackerDice = singleAttacker.dices()[i];
					}
				}
				
				if (biggestAttackerDice > defender.dices()[i]) {
					defender.removeUnit();
					defender.setDiceResult(i, CommandWrapper.DICE_LOST);
					for each (singleAttacker in attackers) {
						singleAttacker.setDiceResult(i, CommandWrapper.DICE_WON);
					}
				} else {
					for each (singleAttacker in attackers) {
						singleAttacker.removeUnit();
						singleAttacker.setDiceResult(i, CommandWrapper.DICE_LOST);
					}
					
					defender.setDiceResult(i, CommandWrapper.DICE_WON);
				}
			}
		}
		
		private function determineAttackerDefender():Object {
			var result:Object = new Object();
			
			if (_currentBattle.oneSide.length == 1 && (_currentBattle.oneSide[0] as CommandWrapper).sourceTerrotiry.id == (_currentBattle.oneSide[0] as CommandWrapper).destionationTerritory.id) {
				result.defender = _currentBattle.oneSide;
				result.attacker = _currentBattle.otherSide;
			} else if (_currentBattle.otherSide.length == 1 && (_currentBattle.otherSide[0] as CommandWrapper).sourceTerrotiry.id == (_currentBattle.otherSide[0] as CommandWrapper).destionationTerritory.id) {
				result.defender = _currentBattle.otherSide;
				result.attacker = _currentBattle.oneSide;
			} else {
				throw new Error("Unable to find defence command");
			}
			
			var i:int;
			
			for (i = result.attacker.length - 1; i >= 0; i--) {
				if (!(result.attacker[i] as CommandWrapper).isAlive) {
					result.attacker.splice(i, 1);
				}
			}
			
			return result;
		}
		
		public function rollMyDice(attackFrom:TerritoryWrapper):void {
			var rollDicesMessage:RollDiceClicked = new RollDiceClicked();
			rollDicesMessage.gameId = _gameId;
			rollDicesMessage.territoryId = attackFrom.id;
			Communicator.instance.send(HandlerCodes.ROLL_DICE, rollDicesMessage, null);
			rollDice(attackFrom);
		}
		
		public function opponentRolledDice(roll:PlayerRolledDice):void {
			rollDice(_territories[roll.territoryId]);
		}
		
		private function rollDice(territoryFrom:TerritoryWrapper):void {
			for each (var command:CommandWrapper in _currentBattle.allCommands) {
				if (command.sourceTerrotiry.id == territoryFrom.id) {
					command.throwDices();
					_currentBattle.incrementNumberOfRolledDices();
					dispatchEvent(new DicesEvent(DicesEvent.DICES_ROLLED, command));
					break;
				}
			}
			
			if (_currentBattle.isAllDicesRolled) {
				_currentBattleTimer.stop();
				roundFinished();
				dispatchEvent(new BattleEvent(BattleEvent.BATTLE_ROUND_FINISHED, _currentBattle, 0));
			}
		}
		
		public function moveUnits(territoryFrom:TerritoryWrapper, territoryTo:TerritoryWrapper, numberOfUnits:int):void {
			var command:Command = new Command();
			command.commandId = 1973;
			command.sourceTerritory = territoryFrom.id;
			command.destinationTerritory = territoryTo.id;
			command.numberOfUnits = numberOfUnits;
			command.seed = 1973;
			
			var move:MoveUnitsRequest = new MoveUnitsRequest();
			move.gameId = _gameId;
			move.command = command;
			
			Communicator.instance.send(HandlerCodes.MOVE_UNITS, move, function moveResponse(message:ProtocolMessage):void {
					territoryFrom.troopsOnIt -= numberOfUnits;
					territoryTo.troopsOnIt += numberOfUnits;
					dispatchEvent(new RelocationEvent(RelocationEvent.UNITS_RELOCATED, territoryFrom, territoryTo, numberOfUnits));
				});
		}
		
		public function tradeCards(card1:Card, card2:Card, card3:Card, callback:Function):void {
			var request:TradeCardsRequest = new TradeCardsRequest();
			
			request.cardId1 = card1;
			request.cardId2 = card2;
			request.cardId3 = card3;
			
			request.gameId = _gameId;
			
			Communicator.instance.send(HandlerCodes.TRADE_CARDS, request, function tradeCardsResponse(e:ProtocolMessage):void {
					var response:TradeCardsResponse = e.data as TradeCardsResponse;
					var cards:Array = [card1, card2, card3];
					
					if (response.numberOfReinforcements > 0) {
						removeMyCards(cards);
						addUnitsOnTrade(cards);
						_me.numberOdReinforcements += response.numberOfReinforcements;
						
					}
					if (callback != null) {
						callback(response.numberOfReinforcements);
					}
				});
		}
		
		private function addUnitsOnTrade(cards:Array):void {
			for each (var card:Card in cards) {
				var territory:TerritoryWrapper = _territories[card.territoryId] 
				if (territory.owner.playerId == _me.playerId) {
					territory.troopsOnIt += ADDING_UNITS_ON_TRADE;
					dispatchEvent(new ChangedNumberOfUnits(ChangedNumberOfUnits.CHANGED_NUMBER_OF_UNITS, territory.id));
				}
			}
		}
		
		private function removeMyCards(cards:Array):void {
			for (var i:int = _myCards.length - 1; i >= 0; i--) {
				for (var j:int = 0; j < cards.length; j++) {
					if (_myCards[i].territoryId == cards[j].territoryId) {
						_myCards.splice(i, 1);
						_me.cardsNumber--;
						break;
					}
				}
			}
		}
		
		public function newCardAwarded(card:Card):void {
			_myCards.push(card);
			dispatchEvent(new NewCardAwardedEvent(NewCardAwardedEvent.NEW_CARD_RECEIVED, card));
		}
		
		public function cardCountStateChanged(notification:PlayerCardCountNotification):void {
			for each (var player:PlayerWrapper in _allPlayers) {
				if (player.playerId == notification.playerId) {
					player.cardsNumber = notification.cardCount;
					break;
				}
			}
			
			dispatchEvent(new Event(NUMBER_OF_CARDS_UPDATED));
		}
		
		public function reinforcementsReceived(numberOfReinforcements:int):void {
			if (_phase != GamePhase.TROOP_DEPLOYMENT_PHASE) {
				throw new Error("Received reinforcement in phase that is not troop deployment");
			}
			
			_me.numberOdReinforcements += numberOfReinforcements;
			dispatchEvent(new Event(REINFORCEMENTS_RECEIVED));
		}
	
	}
}