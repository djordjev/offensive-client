package modules.game.events {
	import starling.events.Event;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ClickOnTerritory extends Event {
		public static const CLICKED_ON_TERRITORY:String = "clicked on terrotory";
		
		private var _territory:TerritoryWrapper;
		
		public function ClickOnTerritory(type:String, territoryWrapper:TerritoryWrapper, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, data);
			_territory = territoryWrapper;
		}
		
		public function get territory():TerritoryWrapper {
			return _territory;
		}
	
	}

}