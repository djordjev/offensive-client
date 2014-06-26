package modules.game {
	import com.netease.protobuf.Int64;
	import communication.Communicator;
	import communication.HandlerCodes;
	import communication.Me;
	import communication.ProtocolMessage;
	import communication.protos.AddUnitRequest;
	import communication.protos.AdvancePhaseNotification;
	import communication.protos.AttackRequest;
	import communication.protos.Command;
	import communication.protos.CommandsSubmittedRequest;
	import communication.protos.Territory;
	import flash.utils.Dictionary;
	import modules.base.BaseModel;
	import modules.game.classes.GamePhase;
	import modules.game.events.AttackEvent;
	import modules.game.events.ChangedNumberOfUnits;
	import starling.events.Event;
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
		
		public function get me():PlayerWrapper {
			return _me;
		}
		
		public function get numberOfMyUnits():int {
			return _numberOfMyUnits;
		}
		
		public function get pendingCommands():Array {
			return _pendingCommands;
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
			switch(_phase) {
				case GamePhase.TROOP_DEPLOYMENT_PHASE:
					advanceToTroopDeploymentPhase(response);
					break;
				case GamePhase.ATTACK_PHASE:
					advanceToAttackPhase(response);
					break;
				case GamePhase.BATTLE_PHASE:
					break;
				case GamePhase.TROOP_RELOCATION_PHASE:
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
			for each(var territory:Territory in response.territories) {
				var playerOnIt:PlayerWrapper = getPlayerByPlayerId(territory.playerId);
				(_territories[territory.id] as TerritoryWrapper).conquer(playerOnIt, territory.troopsOnIt);
				dispatchEvent(new ChangedNumberOfUnits(ChangedNumberOfUnits.CHANGED_NUMBER_OF_UNITS, territory.id));
			}
		}
		
		public function getTerritory(id:int):TerritoryWrapper {
			return _territories[id] as TerritoryWrapper;
		}
	}

}