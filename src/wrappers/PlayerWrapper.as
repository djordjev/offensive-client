package wrappers {
	import communication.protos.Player;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class PlayerWrapper {
		
		public var playerId:int;
		public var color:int;
		public var isPlayedMove:Boolean;
		public var cards:Array;
		public var numberOdReinforcements:int;
		
		public var numberOfTerritories:int;
		public var isAlive:Boolean = true;
		public var userWrapper:UserWrapper;
		
		private var _isDummy:Boolean = false;
		
		public static function buildPlayerWrapper(player:Player):PlayerWrapper {
			var playerWrapper:PlayerWrapper = new PlayerWrapper();
			playerWrapper.playerId = player.playerId;
			playerWrapper.color = player.color;
			playerWrapper.isPlayedMove = player.isPlayedMove;
			playerWrapper.cards = player.cards;
			playerWrapper.numberOdReinforcements = player.numberOfReinforcments;
			
			if (player.hasUser) {
				var facebookUser:FacebookUser = null;
				if (player.user.hasFacebookId) {
					facebookUser = new FacebookUser();
					facebookUser.setFacebookId(player.user.facebookId.toString());
				}
				playerWrapper.userWrapper = UserWrapper.buildUserWrapper(player.user, facebookUser);
				playerWrapper._isDummy = false;
			} else {
				playerWrapper._isDummy = true;
			}
			return playerWrapper;
		}
		
		public function PlayerWrapper() {
		}
		
		public function get isDummy():Boolean {
			return _isDummy;
		}
		
		public function get userIdAsString():String {
			if (!_isDummy && userWrapper != null) {
				return userWrapper.userId.toString();
			} else {
				return null;
			}
		}
	
	}

}