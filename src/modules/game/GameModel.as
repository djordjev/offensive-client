package modules.game {
	import com.netease.protobuf.Int64;
	import communication.Me;
	import communication.protos.GameContext;
	import communication.protos.Player;
	import communication.protos.Territory;
	import flash.utils.Dictionary;
	import modules.base.BaseModel;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameModel extends BaseModel {
		
		private var _gameName:String;
		private var _gameId:Int64;
		private var _me:Player;
		private var _opponents:Array; // array of Player
		private var _objective:int;
		private var _round:int;
		private var _phase:int;
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
		
		public function initForGame(gameContext:GameContext):void {
			_gameName = gameContext.lightGameContext.gameDescription.gameName;
			_gameId = gameContext.lightGameContext.gameDescription.gameId;
			_opponents = [];
			for each (var player:Player in gameContext.lightGameContext.playersInGame) {
				if (player.user.userId.toString() == Me.instance.userIdAsString) {
					_me = player;
				} else {
					_opponents.push(player);
				}
			}
			_objective = gameContext.lightGameContext.gameDescription.objective;
			_round = gameContext.lightGameContext.round;
			_phase = gameContext.lightGameContext.phase;
			
			_territories = new Dictionary();
			for each(var territory:Territory in gameContext.territories) {
				_territories[territory.id] = new TerritoryWrapper(territory);
			}
		}
	
	}

}