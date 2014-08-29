package modules.game.events {
	import starling.events.Event;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RelocationEvent extends Event {
		
		public static const UNITS_RELOCATED:String = "unit relocated";
		
		private var _fromTerritory:TerritoryWrapper;
		private var _toTerritory:TerritoryWrapper;
		private var _numberOfUnits:int;
		
		public function RelocationEvent(type:String, fromTerritory:TerritoryWrapper, toTerritory:TerritoryWrapper, numberOfUnits:int, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, data);
			_fromTerritory = fromTerritory;
			_toTerritory = toTerritory;
			_numberOfUnits = numberOfUnits;
		}
		
		public function get fromTerritory():TerritoryWrapper {
			return _fromTerritory;
		}
		
		public function get toTerritory():TerritoryWrapper {
			return _toTerritory;
		}
		
		public function get numberOfUnits():int {
			return _numberOfUnits;
		}
		
	}

}