package modules.game {
	import com.netease.protobuf.Int64;
	import communication.Communicator;
	import communication.HandlerCodes;
	import communication.Me;
	import communication.protos.AddUnitRequest;
	import communication.protos.GameContext;
	import communication.protos.Player;
	import communication.protos.Territory;
	import flash.text.TextRenderer;
	import flash.utils.Dictionary;
	import modules.base.BaseModel;
	import modules.game.classes.GamePhase;
	import modules.game.classes.Territories;
	import modules.game.events.ChangedNumberOfUnits;
	import wrappers.FacebookUser;
	import wrappers.PlayerWrapper;
	import wrappers.TerritoryWrapper;
	import wrappers.UserWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameModel extends BaseModel {
		
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
		
		public function initForGame(gameContext:GameContext):void {
			_gameName = gameContext.lightGameContext.gameDescription.gameName;
			_gameId = gameContext.lightGameContext.gameDescription.gameId;
			_opponents = [];
			_allPlayers = new Dictionary();
			for each (var player:Player in gameContext.lightGameContext.playersInGame) {
				var playerWrapper:PlayerWrapper = PlayerWrapper.buildPlayerWrapper(player);
				if (!playerWrapper.isDummy && playerWrapper.userWrapper.user.userId.toString() == Me.instance.userIdAsString) {
					_me = playerWrapper;
				} else {
					_opponents.push(playerWrapper);
				}
				
				_allPlayers[playerWrapper.player.playerId.toString()] = playerWrapper;
			}
			_objective = gameContext.lightGameContext.gameDescription.objective;
			_round = gameContext.lightGameContext.round;
			_phase = gameContext.lightGameContext.phase;
			
			_territories = new Dictionary();
			for each (var territory:Territory in gameContext.territories) {
				_territories[territory.id] = new TerritoryWrapper(territory);
				var owner:PlayerWrapper = getPlayerByPlayerId(territory.playerId);
				_territories[territory.id].conquer(owner, territory.troopsOnIt);
				if (!owner.isDummy) {
					owner.numberOfTerritories++;
				}
			}
		}
		
		public function getPlayerByPlayerId(playerId:int):PlayerWrapper {
			return _allPlayers[playerId.toString()];
		}
		
		public function get numberOfReinforcements():int {
			if (_phase == GamePhase.TROOP_DEPLOYMENT_PHASE || phase == GamePhase.WAITING_FOR_OPPONENTS_PHASE) {
				return _me.player.numberOfReinforcments;
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
				_me.player.numberOfReinforcments--;
				var territory:TerritoryWrapper = _territories[territoryId];
				territory.territory.troopsOnIt++;
				dispatchEvent(new ChangedNumberOfUnits(ChangedNumberOfUnits.CHANGED_NUMBER_OF_UNITS, territoryId));
			}
		}
		
		public function getAllPlayers():Array {
			var onlyMe:Array = [_me];
			return onlyMe.concat(_opponents);
		}
	}

}