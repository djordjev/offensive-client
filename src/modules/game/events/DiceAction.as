package modules.game.events {
	import starling.events.Event;
	import wrappers.PlayerWrapper;
	
	/**
	 * ...
	 * @author Djordje
	 */
	public class DiceAction extends Event {
		
		public static const OPPONENT_ROLLED_DICE:String = "opponent rolled dice";
		
		private var _player:PlayerWrapper;
		private var _dices:Array;
		
		public function DiceAction(type:String, opponent:PlayerWrapper, dices:Array, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, data);
			_player = opponent;
			_dices = dices;
		}
		
		public function get player():PlayerWrapper {
			return _player;
		}
		
		public function get dices():Array {
			return _dices;
		}
	
	}

}