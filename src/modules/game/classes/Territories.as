package modules.game.classes {
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class Territories {
		public static const NUMBER_OF_TERRITORIES:int = 42;
		
		
		public static const ALASKA:int = 1;
		public static const ALBERTA:int = 2;
		public static const CENTRAL_AMERICA:int = 3;
		public static const EASTERN_US:int = 4;
		public static const GREENLAND:int = 5;
		public static const NORTHWEST_TERRITORY:int = 6;
		public static const ONTARIO:int = 7;
		public static const QUEBEC:int = 8;
		public static const WESTERN_US:int = 9;
		public static const ARGENTINA:int = 10;
		public static const BRAZIL:int = 11;
		public static const PERU:int = 12;
		public static const VENEZUELA:int = 13;
		public static const GREAT_BRITAIN:int = 14;
		public static const ICELAND:int = 15;
		public static const NORTHERN_EUROPE:int = 16;
		public static const SCANDINAVIA:int = 17;
		public static const SOUTHERN_EUROPE:int = 18;
		public static const UKRAINE:int = 19;
		public static const WESTERN_EUROPE:int = 20;
		public static const CONGO:int = 21;
		public static const EAST_AFRICA:int = 22;
		public static const EGYPT:int = 23;
		public static const MADAGASCAR:int = 24;
		public static const NORTH_AFRICA:int = 25;
		public static const SOUTH_AFRICA:int = 26;
		public static const AFGHANISTAN:int = 27;
		public static const CHINA:int = 28;
		public static const INDIA:int = 29;
		public static const IRKUTSK:int = 30;
		public static const JAPAN:int = 31;
		public static const KAMCHATKA:int = 32;
		public static const MIDDLE_EAST:int = 33;
		public static const MONGOLIA:int = 34;
		public static const SIAM:int = 35;
		public static const SIBERIA:int = 36; // image missing
		public static const URAL:int = 37;
		public static const YAKUTSK:int = 38;
		public static const EASTERN_AUSTRALIA:int = 39;
		public static const INDONESIA:int = 40;
		public static const NEW_GUINEA:int = 41;
		public static const WESTERN_AUSTRALIA:int = 42;
		
		public function Territories() {
		}
		
		public static function getTerritoryName(id:int):String {
			switch (id) {
				case ALASKA: 
					return "Alaska";
				case ALBERTA: 
					return "Alberta";
				case CENTRAL_AMERICA: 
					return "Central America";
				case EASTERN_US: 
					return "Eastern United States";
				case GREENLAND: 
					return "Greenland";
				case NORTHWEST_TERRITORY: 
					return "Northwest Territory";
				case ONTARIO: 
					return "Ontario";
				case QUEBEC: 
					return "Quebec";
				case WESTERN_US: 
					return "Western United States";
				case ARGENTINA: 
					return "Argentina";
				case BRAZIL: 
					return "Brazil";
				case PERU: 
					return "Peru";
				case VENEZUELA: 
					return "Venezuela";;
				case GREAT_BRITAIN: 
					return "Great Britain";
				case NORTHERN_EUROPE: 
					return "Northern Europe";
				case SCANDINAVIA: 
					return "Scandinavia";
				case SOUTHERN_EUROPE: 
					return "Southern Europe";
				case UKRAINE: 
					return "Ukraine";
				case WESTERN_EUROPE: 
					return "Western Europe";
				case CONGO: 
					return "Congo";
				case EAST_AFRICA: 
					return "East Africa";
				case EGYPT: 
					return "Egypt";
				case MADAGASCAR: 
					return "Madagascar";
				case NORTH_AFRICA: 
					return "North Africa";
				case SOUTH_AFRICA: 
					return "South Africa";
				case AFGHANISTAN: 
					return "Afghanistan";
				case CHINA: 
					return "China";
				case INDIA: 
					return "India";
				case IRKUTSK: 
					return "Irkutsk";
				case JAPAN: 
					return "Japan";
				case KAMCHATKA: 
					return "Kamchatka";
				case MIDDLE_EAST: 
					return "Middle East";
				case MONGOLIA: 
					return "Mongolia";
				case SIAM: 
					return "Siam";
				case SIBERIA: 
					return "Siberia";
				case URAL: 
					return "Ural";
				case YAKUTSK: 
					return "Yakutsk";
				case EASTERN_AUSTRALIA: 
					return "Eastern Australia";
				case INDONESIA: 
					return "Indonesia";
				case NEW_GUINEA: 
					return "New Guinea";
				case WESTERN_AUSTRALIA: 
					return "Western Australia";
				default: 
					return "";
			}
		}
	
	}

}