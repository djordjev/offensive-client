package wrappers {
	import communication.protos.BattleInfo;
	import communication.protos.Command;
	
	/**
	 * ...
	 * @author Djordje
	 */
	public class BattleInfoWrapper {
		
		public static function buildBattleInfoWrapper(battleInfo:BattleInfo):BattleInfoWrapper {
			var wrapper:BattleInfoWrapper = new BattleInfoWrapper();
			
			var command:Command;
			var commandWrapper:CommandWrapper;
			
			for each(command in battleInfo.oneSide) {
				commandWrapper = CommandWrapper.buildCommandWrapper(command);
				wrapper.oneSide.push(commandWrapper);
				wrapper._allCommands.push(commandWrapper);
			}
			
			for each(command in battleInfo.otherSide) {
				commandWrapper = CommandWrapper.buildCommandWrapper(command);
				wrapper.otherSide.push(commandWrapper);
				wrapper._allCommands.push(commandWrapper);
			}
			
			return wrapper;
		}
		
		/**Array of CommandWrappers */
		public var oneSide:Array;
		
		/** Array of CommandWrappers */
		public var otherSide:Array;
		
		private var _allCommands:Array = [];
		
		private var _numberOfRolledDices:int;
		
		public function BattleInfoWrapper() {
		}
		
		public function get allCommands():Array {
			return _allCommands;
		}
		
		public function incrementNumberOfRolledDices():void {
			_numberOfRolledDices++;
		}
		
		public function isAllDicesRolled():Boolean {
			return _numberOfRolledDices >= oneSide.length + otherSide.length;
		}
	
	}

}