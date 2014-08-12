package components.events {
	import starling.events.Event;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje
	 */
	public class RollDicesClickEvent extends Event {
		
		public static const ROLL_CLICKED:String = "roll clicked";
		
		private var _territoryClicked:TerritoryWrapper;
		
		public function RollDicesClickEvent(type:String, territory:TerritoryWrapper, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, data);
			_territoryClicked = territory
		}
		
		public function get territoryClicked():TerritoryWrapper {
			return _territoryClicked;
		}
	
	}

}