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
	import communication.protos.Command;
	import communication.protos.CommandsSubmittedRequest;
	import communication.protos.MultipleAttacks;
	import communication.protos.PlayerRolledDice;
	import communication.protos.RollDiceClicked;
	import communication.protos.SingleAttacks;
	import communication.protos.SpoilsOfWar;
	import communication.protos.Territory;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import modules.base.BaseModel;
	import modules.game.classes.GamePhase;
	import modules.game.events.AttackEvent;
	import modules.game.events.BattleEvent;
	import modules.game.events.ChangedNumberOfUnits;
	import modules.game.events.DicesEvent;
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
		
		public static const MAX_DICES:int = 3;
		
		private static const TIME_FOR_ROLL:int = 8; // seconds
		
		private var _gameName:String;
		private var _gameId:Int64;
		private var _me:PlayerWrapper;
		private var _opponents:Array; // array of PlayerWrappers
		private var _objective:int;
		private var _round:int;
		private var _phase:int;
		private var _allPlayers:Dictionary; // Dictionary playerId -> PlayerWrapper
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
		
		public function initForGame(gameContext:GameContextWrapper):void {
			_gameName = gameContext.gameName;
			_gameId = gameContext.gameId;
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
			// should add effects of troop relocation phase
		}
		
		private function advanceToAttackPhase(response:AdvancePhaseNotification):void {
			// update number of units on territories
			for each (var territory:Territory in response.territories) {
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
			if (_currentBattleTimer != null) {
				_currentBattleTimer.stop();
				_currentBattleTimer = null;
			}
			// reset other fields
		}
		
		public function allCommandsReceived(allCommands:AllCommands):void {
			if (_phase == GamePhase.BATTLE_PHASE) {
				_allCommands = allCommands.commands;

				for each(var command:Command in allCommands.commands) {
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
			_currentBattleTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function rollTimeUp(e:TimerEvent):void {
					roundFinished();
					dispatchEvent(new BattleEvent(BattleEvent.BATTLE_TIME_UP, _currentBattle, 0));
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
			
			var isFinished = calculateCasualties();
			
			if (isFinished) {
				dispatchEvent(new BattleEvent(BattleEvent.BATTLE_FINISHED, _currentBattle));
			} else {
				setUpTimers();
			}
			
			for each (command in _currentBattle.allCommands) {
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
			for each(var command:CommandWrapper in died) {
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
				} else if (firstCommand.dices()[i] > secondCommand.dices()[i]) {
					secondCommand.removeUnit();
				}
			}
		}
		
		private function calculateCasualtiesSpoilsOfWar():void {
			var numberOfDicesInBattle:int = _currentBattle.minNumberOfDices();
			var command:CommandWrapper;
			
			for (var i:int = 0; i < numberOfDicesInBattle; i++) {
				var commandWithBiggestDice:CommandWrapper = null;
				// find command with biggest dice
				for each(command in _currentBattle.oneSide) {
					if (commandWithBiggestDice == null || command.dices()[i] > commandWithBiggestDice) {
						commandWithBiggestDice = command;
					}
				}
				
				// remove units to others
				for each(command in _currentBattle.oneSide) {
					if (commandWithBiggestDice.dices()[i] > command.dices()[i] && 
						commandWithBiggestDice.sourceTerrotiry.id != command.sourceTerrotiry.id) {
						command.removeUnit();
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
				for each(singleAttacker in attackers) {
					if (singleAttacker.dices()[i] > biggestAttackerDice) {
						biggestAttackerDice = singleAttacker.dices()[i];
					}
				}
				
				if (biggestAttackerDice > defender.dices()[i]) {
					defender.removeUnit();
				} else {
					for each(singleAttacker in attackers) {
						singleAttacker.removeUnit();
					}
				}
			}
		}
		
		private function determineAttackerDefender():Object {
			var result:Object = new Object();
			
			if (_currentBattle.oneSide.length == 1 && 
				(_currentBattle.oneSide[0] as CommandWrapper).sourceTerrotiry.id == (_currentBattle.oneSide[0] as CommandWrapper).destionationTerritory.id) {
				result.defender = _currentBattle.oneSide;
				result.attacker = _currentBattle.otherSide;
			} else if (_currentBattle.otherSide.length == 1 && 
				(_currentBattle.otherSide[0] as CommandWrapper).sourceTerrotiry.id == (_currentBattle.otherSide[0] as CommandWrapper).destionationTerritory.id) {
				result.defender = _currentBattle.otherSide;
				result.attacker = _currentBattle.oneSide;
			} else {
				throw new Error("Unable to find defence command");
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
				_currentBattleTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
			}
		}
	}
}