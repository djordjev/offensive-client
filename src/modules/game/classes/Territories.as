package modules.game.classes {
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
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
		
		private static var _territoriesPositions:Dictionary;
		
		public static function getTerritoryPosition(id:int):Point {
			if (_territoriesPositions == null) {
				_territoriesPositions = new Dictionary();
				// points for N. America
				_territoriesPositions[ALASKA] = new Point(75, 87);
				_territoriesPositions[EASTERN_US] = new Point(153, 143);
				_territoriesPositions[WESTERN_US] = new Point(117, 146);
				_territoriesPositions[ALBERTA] = new Point(147, 116);
				_territoriesPositions[QUEBEC] = new Point(266, 109);
				_territoriesPositions[ONTARIO] = new Point(213, 116);
				_territoriesPositions[NORTHWEST_TERRITORY] = new Point(153, 82);
				_territoriesPositions[GREENLAND] = new Point(332, 51);
				_territoriesPositions[CENTRAL_AMERICA] = new Point(117, 187);
				
				// points in S.America
				_territoriesPositions[VENEZUELA] = new Point(166, 273);
				_territoriesPositions[PERU] = new Point(151, 312);
				_territoriesPositions[BRAZIL] = new Point(176, 301);
				_territoriesPositions[ARGENTINA] = new Point(165, 388);
				
				// points in Africa
				_territoriesPositions[NORTH_AFRICA] = new Point(408, 234);
				_territoriesPositions[EGYPT] = new Point(500, 249);
				_territoriesPositions[EAST_AFRICA] = new Point(542, 279);
				_territoriesPositions[CONGO] = new Point(495, 320);
				_territoriesPositions[SOUTH_AFRICA] = new Point(501, 383);
				_territoriesPositions[MADAGASCAR] = new Point(631, 386);
				
				// points in Europe
				_territoriesPositions[WESTERN_EUROPE] = new Point(476, 180);
				_territoriesPositions[SOUTHERN_EUROPE] = new Point(524, 187);
				_territoriesPositions[UKRAINE] = new Point(564, 133);
				_territoriesPositions[NORTHERN_EUROPE] = new Point(516, 163);
				_territoriesPositions[SCANDINAVIA] = new Point(526, 128);
				_territoriesPositions[ICELAND] = new Point(459, 126);
				_territoriesPositions[GREAT_BRITAIN] = new Point(483, 149);
				
				// points in Asia
				_territoriesPositions[AFGHANISTAN] = new Point(635, 163);
				_territoriesPositions[CHINA] = new Point(726, 184);
				_territoriesPositions[INDIA] = new Point(690, 217);
				_territoriesPositions[IRKUTSK] = new Point(748, 146);
				_territoriesPositions[JAPAN] = new Point(915, 210);
				_territoriesPositions[KAMCHATKA] = new Point(843, 133);
				_territoriesPositions[MIDDLE_EAST] = new Point(582, 206);
				_territoriesPositions[MONGOLIA] = new Point(754, 175);
				_territoriesPositions[SIAM] = new Point(802, 248);
				_territoriesPositions[SIBERIA] = new Point(715, 117);
				_territoriesPositions[URAL] = new Point(648, 119);
				_territoriesPositions[YAKUTSK] = new Point(746, 125);
				
				// points in Australia
				_territoriesPositions[NEW_GUINEA] = new Point(881, 341);
				_territoriesPositions[EASTERN_AUSTRALIA] = new Point(914, 434);
				_territoriesPositions[WESTERN_AUSTRALIA] = new Point(859, 443);
				_territoriesPositions[INDONESIA] = new Point(759, 344);
			}
			
			return _territoriesPositions[id];
		}
		
		private static var _unitsPositions:Dictionary;
		
		public static function getUnitsPosition(id:int):Point {
			if (_unitsPositions == null) {
				_unitsPositions = new Dictionary();
				// points for N. America
				_unitsPositions[ALASKA] = new Point(52, 0);
				_unitsPositions[EASTERN_US] = new Point(60, 13);
				_unitsPositions[WESTERN_US] = new Point(38, 4);
				_unitsPositions[ALBERTA] = new Point(19, 0);
				_unitsPositions[QUEBEC] = new Point(60, 7);
				_unitsPositions[ONTARIO] = new Point(20, 3);
				_unitsPositions[NORTHWEST_TERRITORY] = new Point(86, 0);
				_unitsPositions[GREENLAND] = new Point(62, 3);
				_unitsPositions[CENTRAL_AMERICA] = new Point(20, 36);
				
				// points in S.America
				_unitsPositions[VENEZUELA] = new Point(51, 2);
				_unitsPositions[PERU] = new Point(30, 55);
				_unitsPositions[BRAZIL] = new Point(80, 60);
				_unitsPositions[ARGENTINA] = new Point(10, 90);
				
				// points in Africa
				_unitsPositions[NORTH_AFRICA] = new Point(60, 60);
				_unitsPositions[EGYPT] = new Point(33, 0);
				_unitsPositions[EAST_AFRICA] = new Point(30, 30);
				_unitsPositions[CONGO] = new Point(30, 30);
				_unitsPositions[SOUTH_AFRICA] = new Point(30, 60);
				_unitsPositions[MADAGASCAR] = new Point(0, 0);
				
				// points in Europe
				_unitsPositions[WESTERN_EUROPE] = new Point(11, 20);
				_unitsPositions[SOUTHERN_EUROPE] = new Point(28, 14);
				_unitsPositions[UKRAINE] = new Point(28, 40);
				_unitsPositions[NORTHERN_EUROPE] = new Point(6, 0);
				_unitsPositions[SCANDINAVIA] = new Point(18, 0);
				_unitsPositions[ICELAND] = new Point(16, -10);
				_unitsPositions[GREAT_BRITAIN] = new Point(-26, 7);
				
				// points in Asia
				_unitsPositions[AFGHANISTAN] = new Point(24, 26);
				_unitsPositions[CHINA] = new Point(109, 55);
				_unitsPositions[INDIA] = new Point(27, 14);
				_unitsPositions[IRKUTSK] = new Point(39, 13);
				_unitsPositions[JAPAN] = new Point(0, 0);
				_unitsPositions[KAMCHATKA] = new Point(45, 0);
				_unitsPositions[MIDDLE_EAST] = new Point(40, 36);
				_unitsPositions[MONGOLIA] = new Point(54, 15);
				_unitsPositions[SIAM] = new Point(21, 28);
				_unitsPositions[SIBERIA] = new Point(7, 19);
				_unitsPositions[URAL] = new Point(38, 25);
				_unitsPositions[YAKUTSK] = new Point(56, 0);
				
				// points in Australia
				_unitsPositions[NEW_GUINEA] = new Point(80, 32);
				_unitsPositions[EASTERN_AUSTRALIA] = new Point(60, 60);
				_unitsPositions[WESTERN_AUSTRALIA] = new Point(25, 35);
				_unitsPositions[INDONESIA] = new Point(60, 55);
			}
			
			return _unitsPositions[id];
		}
	
	}

}