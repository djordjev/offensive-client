package wrappers {
	import communication.protos.Player;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class PlayerWrapper {
		
		private var _player:Player;
		
		public var numberOfTerritories:int;
		public var isAlive:Boolean = true;
		public var userWrapper:UserWrapper;
		
		private var _isDummy:Boolean = false;
		
		public static function buildPlayerWrapper(player:Player):PlayerWrapper {
			var playerWrapper:PlayerWrapper = new PlayerWrapper(player);
			if (player.hasUser) {
				playerWrapper.userWrapper = new UserWrapper();
				if (player.user.hasFacebookId) {
					playerWrapper.userWrapper.facebookUser = new FacebookUser();
					playerWrapper.userWrapper.facebookUser.setFacebookId(player.user.facebookId.toString());
				}
				playerWrapper.userWrapper.user = player.user;
				playerWrapper.player.user = null;
				playerWrapper._isDummy = false;
			} else {
				playerWrapper._isDummy = true;
			}
			return playerWrapper;
		}
		
		public function PlayerWrapper(player:Player) {
			_player = player;
		}
		
		public function get player():Player {
			return _player;
		}
		
		public function get isDummy():Boolean {
			return _isDummy;
		}
		
		public function get userIdAsString():String {
			if (!_isDummy && userWrapper.user != null) {
				return userWrapper.user.userId.toString();
			} else {
				return null;
			}
		}
	
	}

}