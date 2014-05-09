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
		
		public function PlayerWrapper(player:Player) {
			_player = player;
		}
		
		public function get player():Player {
			return _player;
		}
		
		
	
	}

}