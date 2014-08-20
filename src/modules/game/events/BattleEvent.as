package modules.game.events {
	import starling.events.Event;
	import wrappers.BattleInfoWrapper;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleEvent extends Event {
		
		public static const ADVANCE_NO_NEXT_BATTLE:String = "advance to next battle event";
		public static const BATTLE_TIMER_TICK:String = "battle timer tick";
		public static const BATTLE_TIME_UP:String = "battle time up";
		public static const BATTLE_FINISHED:String = "battle finished";
		
		private var _battleInfo:BattleInfoWrapper;
		private var _remainingTime:int;
		
		public function BattleEvent(eventType:String, battleInfo:BattleInfoWrapper, remainingTime:int=0) {
			_battleInfo = battleInfo;
			_remainingTime = remainingTime;
			super(eventType);
		
		}
		
		public function get battleInfo():BattleInfoWrapper {
			return _battleInfo;
		}
		
		public function get remainingTime():int {
			return _remainingTime;
		}
	
	}

}