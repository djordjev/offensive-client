package wrappers {
	import com.netease.protobuf.Int64;
	import communication.protos.Alliance;
	import communication.protos.Command;
	import communication.protos.GameContext;
	import communication.protos.Player;
	import communication.protos.Territory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameContextWrapper {
		
		public static function buildGameContext(gameContext:GameContext):GameContextWrapper {
			var wrapper:GameContextWrapper = new GameContextWrapper();
			// initialize non wrapper types
			
			wrapper.alliances = gameContext.alliances;
			wrapper.pendingCommands = gameContext.pendingComands;
			// add fields from lightGameContext
			wrapper.round = gameContext.lightGameContext.round;
			wrapper.phase = gameContext.lightGameContext.phase;
			// add fileds from GameDescription
			wrapper.gameId = gameContext.lightGameContext.gameDescription.gameId;
			wrapper.gameName = gameContext.lightGameContext.gameDescription.gameName;
			wrapper.numberOfJoinedPlayers = gameContext.lightGameContext.gameDescription.numberOfJoinedPlayers;
			wrapper.numberOfPlayers = gameContext.lightGameContext.gameDescription.numberOfPlayers;
			wrapper.objective = gameContext.lightGameContext.gameDescription.objective;
			wrapper.myCards = gameContext.myCards;
			
			// initialize wrapper types
			wrapper.terrotiries = [];
			for each(var territory:Territory in gameContext.territories) {
				var terrotoryWrapper:TerritoryWrapper = TerritoryWrapper.buildTerritoryWrapper(territory);
				wrapper.terrotiries.push(terrotoryWrapper);
			}
			
			wrapper.players = [];
			for each(var player:Player in gameContext.lightGameContext.playersInGame) {
				var playerWrapper:PlayerWrapper = PlayerWrapper.buildPlayerWrapper(player);
				wrapper.players.push(playerWrapper);
				if (playerWrapper.isMe) {
					wrapper.me = playerWrapper;
					wrapper.isPlayedMove = player.isPlayedMove;
				}
			}
			
			return wrapper;
		}
		
		public function GameContextWrapper() {
		}
		
		/** Array of TerritoryWrapper */
		public var terrotiries:Array;
		
		public var alliances:Array;
		
		public var pendingCommands:Array;
		
		public var round:int;
		
		public var phase:int;
		
		/** Array of PlayerWrapper */
		public var players:Array;
		
		public var gameId:Int64;
		
		public var gameName:String;
		
		public var numberOfPlayers:int;
		
		public var numberOfJoinedPlayers:int;
		
		public var objective:int;
		
		public var myCards:Array;
		
		public var me:PlayerWrapper;
		
		public var isPlayedMove:Boolean = false;
	
	}

}