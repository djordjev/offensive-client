package wrappers {
	import communication.protos.Territory;
	import modules.game.classes.Territories;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class TerritoryWrapper {
		
		private var _territory:Territory;
		
		public function TerritoryWrapper(territory:Territory) {
			_territory = territory;
		}
		
		public function get territory():Territory {
			return _territory;
		}
		
		public function get name():String {
			return Territories.getTerritoryName(_territory.id);
		}
	
	}

}