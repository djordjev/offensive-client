package utils {
	
	/**
	 * ...
	 * @author ...
	 */
	public class RandomGenerator {
		
		private var _seed:int;
		
		public function RandomGenerator() { }
		
		public function initWithSeed(newSeed:uint):void {
			_seed = newSeed;
		}
		
		/** Returns between 0 and 1 */
		public function random():Number {
			return (_seed = (_seed * 16807) % 2147483647) / 0x7FFFFFFF + 0.000000000233;
		}
		
		/** Returns next integer in range */
		public function getNext(min:uint, max:uint):int {
			return Math.floor(random() * (max - min) + min);
		}
	}
}