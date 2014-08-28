package wrappers {
	import communication.protos.Command;
	import modules.game.GameModel;
	import utils.RandomGenerator;
	
	/**
	 * ...
	 * @author Djordje
	 */
	public class CommandWrapper {
		
		public static const DICE_WON:int = 0;
		public static const DICE_LOST:int = 1;
		public static const DICE_EQUAL:int = 3;
		
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
			
			commandWrapper._isAlive = true;
			
			return commandWrapper;
		}
		
		public var commandId:int;
		
		public var sourceTerrotiry:TerritoryWrapper;
		public var destionationTerritory:TerritoryWrapper;
		
		public var numberOfUnits:int;
		public var seed:int;
		
		private var _isAlive:Boolean = true;
		
		private var _randomGenerator:RandomGenerator;
		
		private var _dices:Array;
		
		private var _dicesResults:Array;
		
		private var _rolled:Boolean = false;
		
		public function CommandWrapper() {
		
		}
		
		public function get isRolled():Boolean {
			return _rolled;
		}
		
		public function get isAlive():Boolean {
			return _isAlive;
		}
		
		public function dices():Array {
			return _dices;
		}
		
		public function get dicesResults():Array {
			return _dicesResults;
		}
		
		public function clearDices():void {
			_dices = null;
			_dicesResults = null;
		}
		
		public function get isDefending():Boolean {
			return sourceTerrotiry.id == destionationTerritory.id;
		}
		
		public function get isAttacking():Boolean {
			return !isDefending;
		}
		
		private function getNextRandomNumber():int {
			return _randomGenerator.getNext(1, MAX_NUMBER_ON_DICE + 1);
		}
		
		public function throwDices():void {
			var numberOfDices:int = Math.min(MAX_NUMBER_OF_DICES, numberOfUnits);
			
			_dices = [];
			_dicesResults = [];
			
			for (var i:int = 0; i < numberOfDices; i++) {
				_dices.push(getNextRandomNumber());
				_dicesResults.push(DICE_EQUAL);
			}
			
			_dices.sort(Array.NUMERIC);
			_dices.reverse();
			
			_rolled = true;
		}
		
		public function removeUnit():void {
			if (numberOfUnits > 0) {
				numberOfUnits--;
				
				sourceTerrotiry.troopsOnIt--;
			} else {
				throw new Error("Can't remove units from command where all units are already removed");
			}
		}
		
		public function die():void {
			_isAlive = false;
		}
		
		public function setDiceResult(diceIndex:int, diceResult:int):void {
			_dicesResults[diceIndex] = diceResult;
		}
		
	}

}