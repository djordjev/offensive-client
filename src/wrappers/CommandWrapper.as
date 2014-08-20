package wrappers {
	import communication.protos.Command;
	import modules.game.GameModel;
	import utils.RandomGenerator;
	
	/**
	 * ...
	 * @author Djordje
	 */
	public class CommandWrapper {
		
		private static const MAX_NUMBER_ON_DICE:int = 6;
		public static const MAX_NUMBER_OF_DICES:int = 3;
		
		public static function buildCommandWrapper(command:Command):CommandWrapper {
			var commandWrapper:CommandWrapper = new CommandWrapper();
			
			commandWrapper.commandId = command.commandId;
			commandWrapper.sourceTerrotiry = GameModel.instance.getTerritory(command.sourceTerritory);
			commandWrapper.destionationTerritory = GameModel.instance.getTerritory(command.destinationTerritory);
			commandWrapper.numberOfUnits = command.numberOfUnits;
			commandWrapper.seed = command.seed;
			
			commandWrapper._randomGenerator = new RandomGenerator();
			commandWrapper._randomGenerator.initWithSeed(commandWrapper.seed);
			
			return commandWrapper;
		}
		
		public var commandId:int;
		
		public var sourceTerrotiry:TerritoryWrapper;
		public var destionationTerritory:TerritoryWrapper;
		
		public var numberOfUnits:int;
		public var seed:int;
		
		private var _randomGenerator:RandomGenerator;
		
		private var _dices:Array;
		
		private var _rolled:Boolean = false;
		
		public function CommandWrapper() {
		
		}
		
		public function get isRolled():Boolean {
			return _rolled;
		}
		
		public function dices():Array {
			return _dices;
		}
		
		public function clearDices():void {
			_dices = null;
		}
		
		private function getNextRandomNumber():int {
			return _randomGenerator.getNext(1, MAX_NUMBER_ON_DICE + 1);
		}
		
		public function throwDices():void {
			var numberOfDices:int = Math.min(MAX_NUMBER_OF_DICES, numberOfUnits);
			
			_dices = [];
			
			for (var i:int = 0; i < numberOfDices; i++) {
				_dices.push(getNextRandomNumber());
			}
			
			_dices.sort(Array.NUMERIC);
			_dices.reverse();
			
			_rolled = true;
		}
		
		public function removeUnit():void {
			if (numberOfUnits > 0) {
				numberOfUnits--;
			} else {
				throw new Error("Can't remove units from command where all units are already removed");
			}
		}
	}

}