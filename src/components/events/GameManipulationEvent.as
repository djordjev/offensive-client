package components.events {
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameManipulationEvent extends Event {
		public static const SELECTED_GAME_ACTION:String = "selected game action";
		
		private var _gameAction:String;
		
		public function GameManipulationEvent(type:String, gameAction:String, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, data);
			_gameAction = gameAction;
		}
		
		public function get gameAction():String {
			return _gameAction;
		}
	
	}

}