package modules.game.events {
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ChangedNumberOfUnits extends Event {
		public static const CHANGED_NUMBER_OF_UNITS:String = "changed number of units";
		
		private var _territory:int;
		
		public function ChangedNumberOfUnits(type:String, territoryId:int, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, data);
			_territory = territoryId;
		}
		
		public function get territory():int {
			return _territory;
		}
	
	}

}