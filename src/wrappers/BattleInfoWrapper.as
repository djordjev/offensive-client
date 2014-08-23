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
			
			wrapper.oneSide = [];
			wrapper.otherSide = [];
			
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
		
		public function get isAllDicesRolled():Boolean {
			return _numberOfRolledDices >= oneSide.length + otherSide.length;
		}
		
		public function killLosingParticipants():Array {
			var i:int;
			var command:CommandWrapper;
			var deadParticipants:Array = [];
			
			for (i = oneSide.length - 1; i >= 0; i--) {
				command = oneSide[i];
				if (command.numberOfUnits == 0) {
					deadParticipants.push(command);
					command.die();
				}
			}
			
			for (i = otherSide.length - 1; i >= 0; i--) {
				command = otherSide[i];
				if (command.numberOfUnits == 0) { 
					deadParticipants.push(command);
					command.die();
				}
			}
			
			for (i = _allCommands.length - 1; i >= 0; i--) {
				command = _allCommands[i];
				if (command.numberOfUnits == 0) {
					_allCommands.splice(i, 1);
				}
			}
			
			return deadParticipants;
		}
		
		public function minNumberOfDices():int {
			var min:int = CommandWrapper.MAX_NUMBER_OF_DICES;
			for each(var command:CommandWrapper in _allCommands) {
				var numberOfDices:int = Math.min(CommandWrapper.MAX_NUMBER_OF_DICES, command.numberOfUnits);
				if (numberOfDices < min) {
					min = numberOfDices;
				}
			}
			
			return min;
		}
	}

}