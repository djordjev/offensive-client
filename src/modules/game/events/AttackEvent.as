package modules.game.events {
	import starling.events.Event;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AttackEvent extends Event {
		
		public static const TERRITORY_ATTACK:String = "territory attack";
		
		private var _territoryFrom:TerritoryWrapper;
		private var _territoryTo:TerritoryWrapper;
		private var _unitsInAttack:int;
		
		public function AttackEvent(type:String, from:TerritoryWrapper, to:TerritoryWrapper, units:int, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, data);
			_territoryFrom = from;
			_territoryTo = to;
			_unitsInAttack = units;
		}
		
		public function get territoryFrom():TerritoryWrapper {
			return _territoryFrom;
		}
		
		public function get territoryTo():TerritoryWrapper {
			return _territoryTo;
		}
		
		public function get unitsInAttack():int {
			return _unitsInAttack;
		}
	
	}

}