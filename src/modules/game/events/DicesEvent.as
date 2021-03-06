package modules.game.events {
	import starling.events.Event;
	import wrappers.CommandWrapper;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DicesEvent extends Event {
		
		public static const DICES_ROLLED:String = "dices rolled";
		public static const OPPONENT_DIED_IN_BATTLE:String = "opponent died in battle";
		
		private var _command:CommandWrapper;
		
		public function DicesEvent(type:String, command:CommandWrapper, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, data);
			_command = command;
		}
		
		public function get command():CommandWrapper {
			return _command;
		}
	
	}

}