package components.events {
	import communication.protos.GameDescription;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class JoinGameEvent extends Event {
		public static const JOINED_TO_GAME:String = "joined to game";
		
		private var _gameToJoin:GameDescription;
		
		public function JoinGameEvent(type:String, desc:GameDescription, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, data);
			_gameToJoin = desc;
		
		}
		
		public function get gameToJoin():GameDescription {
			return _gameToJoin;
		}
	
	}

}