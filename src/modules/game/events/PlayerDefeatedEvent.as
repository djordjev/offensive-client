package modules.game.events {
	import starling.events.Event;
	import wrappers.PlayerWrapper;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerDefeatedEvent extends Event {
		
		public static const OPPONEND_DEFEATED:String = "oponent defeated";
		
		private var _opponent:PlayerWrapper;
		
		public function PlayerDefeatedEvent(type:String, opponent:PlayerWrapper, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, data);
			_opponent = opponent;
		}
		
		public function get opponent():PlayerWrapper 
		{
			return _opponent;
		}
	
	}

}