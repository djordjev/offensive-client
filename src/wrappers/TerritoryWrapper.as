package wrappers {
	import communication.protos.Territory;
	import modules.game.classes.Territories;
	import modules.game.events.ChangedNumberOfUnits;
	import starling.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class TerritoryWrapper extends EventDispatcher {
	
		public static function buildTerritoryWrapper(territory:Territory):TerritoryWrapper {
			var wrapper:TerritoryWrapper = new TerritoryWrapper();
			wrapper.id = territory.id;
			wrapper.troopsOnIt = territory.troopsOnIt;
			wrapper.playerId = territory.playerId;
			return wrapper;
		}
		
		public var id:int;
		
		public var troopsOnIt:int;
		
		public var playerId:int;
		
		private var _owner:PlayerWrapper;
		
		public function TerritoryWrapper() {
		}
		
		public function get name():String {
			return Territories.getTerritoryName(id);
		}
		
		public function get owner():PlayerWrapper {
			return _owner;
		}
		
		public function conquer(conqueror:PlayerWrapper, newTroops:int):void {
			_owner = conqueror;
			troopsOnIt = newTroops;
			playerId = conqueror.playerId;
			dispatchEvent(new ChangedNumberOfUnits(ChangedNumberOfUnits.CHANGED_NUMBER_OF_UNITS, id, true));
		}
	}

}