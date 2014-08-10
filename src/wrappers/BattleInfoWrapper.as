package wrappers {
	import communication.protos.BattleInfo;
	
	/**
	 * ...
	 * @author Djordje
	 */
	public class BattleInfoWrapper {
		
		public static function buildBattleInfoWrapper(battleInfo:BattleInfo):BattleInfoWrapper {
			var wrapper:BattleInfoWrapper = new BattleInfoWrapper();
			
			wrapper.oneSide = CommandWrapper.buildCommandWrapper(battleInfo.oneSide);
			wrapper.otherSide = CommandWrapper.buildCommandWrapper(battleInfo.otherSide);
			
			return wrapper;
		}
		
		public var oneSide:CommandWrapper;
		public var otherSide:CommandWrapper;
		
		public function BattleInfoWrapper() {
		
		}
	
	}

}