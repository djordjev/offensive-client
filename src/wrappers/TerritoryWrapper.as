package wrappers {
	import communication.protos.Territory;
	import modules.game.classes.Territories;
	import modules.game.events.ChangedNumberOfUnits;
	import starling.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class TerritoryWrapper extends EventDispatcher{
		
		private var _territory:Territory;
		
		private var _owner:PlayerWrapper;
		
		public function TerritoryWrapper(territory:Territory) {
			_territory = territory;
		}
		
		public function get territory():Territory {
			return _territory;
		}
		
		public function get name():String {
			return Territories.getTerritoryName(_territory.id);
		}
		
		public function get owner():PlayerWrapper {
			return _owner;
		}
		
		public function conquer(conqueror:PlayerWrapper, newTroops:int):void {
			_owner = conqueror;
			_territory.troopsOnIt = newTroops;
			dispatchEvent(new ChangedNumberOfUnits(ChangedNumberOfUnits.CHANGED_NUMBER_OF_UNITS, _territory.id, true));
		}
	
	}

}