package modules.game.events {
	import communication.protos.BattleInfo;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AdvanceToNextBattleEvent extends Event {
		
		public static const ADVANCE_NO_NEXT_BATTLE:String = "advance to next battle event";
		
		private var _battleInfo:BattleInfo;
		
		public function AdvanceToNextBattleEvent(battleInfo:BattleInfo) {
			_battleInfo = battleInfo;
			super(ADVANCE_NO_NEXT_BATTLE);
		
		}
		
		public function get battleInfo():BattleInfo {
			return _battleInfo;
		}
	
	}

}