package utils {
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class PlayerColors {
		public static function getColor(serverColor:int):uint {
			switch (serverColor) {
				case 1: 
					return Colors.RED;
				case 2: 
					return Colors.BROWN;
				case 3: 
					return Colors.BLUE;
				case 4: 
					return Colors.YELLOW;
				case 5: 
					return Colors.GREEN;
				case 6: 
					return Colors.PURPLE;
				default: 
					return Colors.BLACK;
			}
		}
		
		public function PlayerColors() {
		
		}
	
	}

}