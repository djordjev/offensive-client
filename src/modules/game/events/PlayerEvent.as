package modules.game.events {
	import starling.events.Event;
	import wrappers.GameContextWrapper;
	import wrappers.PlayerWrapper;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerEvent extends Event {
		
		public static const NEW_PLAYER_JOINED:String = "new player joined";
		
		private var _game:GameContextWrapper;
		
		private var _player:PlayerWrapper;
		
		public function PlayerEvent(type:String, realtedPlayer:PlayerWrapper, relatedGame:GameContextWrapper, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, data);
			_player = realtedPlayer;
			_game = relatedGame;
		}
		
		public function get game():GameContextWrapper {
			return _game;
		}
		
		public function get player():PlayerWrapper {
			return _player;
		}
	
	}

}