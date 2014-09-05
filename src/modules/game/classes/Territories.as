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
				_territoriesPositions[ALASKA] = new Point(97, 156);
				_territoriesPositions[EASTERN_US] = new Point(299, 299);
				_territoriesPositions[WESTERN_US] = new Point(209, 300);
				_territoriesPositions[ALBERTA] = new Point(260, 224);
				_territoriesPositions[QUEBEC] = new Point(531, 211);
				_territoriesPositions[ONTARIO] = new Point(404, 228);
				_territoriesPositions[NORTHWEST_TERRITORY] = new Point(253, 136);
				_territoriesPositions[GREENLAND] = new Point(644, 38);
				_territoriesPositions[CENTRAL_AMERICA] = new Point(222, 418);
				
				// points in S.America
				_territoriesPositions[VENEZUELA] = new Point(375, 621);
				_territoriesPositions[PERU] = new Point(355, 707);
				_territoriesPositions[BRAZIL] = new Point(412, 681);
				_territoriesPositions[ARGENTINA] = new Point(437, 865);
				
				// points in Africa
				_territoriesPositions[NORTH_AFRICA] = new Point(740, 480);
				_territoriesPositions[EGYPT] = new Point(916, 502);
				_territoriesPositions[EAST_AFRICA] = new Point(1011, 585);
				_territoriesPositions[CONGO] = new Point(921, 740);
				_territoriesPositions[SOUTH_AFRICA] = new Point(933, 865);
				_territoriesPositions[MADAGASCAR] = new Point(1220, 753);
				
				// points in Europe
				_territoriesPositions[WESTERN_EUROPE] = new Point(718, 341);
				_territoriesPositions[SOUTHERN_EUROPE] = new Point(880, 361);
				_territoriesPositions[UKRAINE] = new Point(980, 211);
				_territoriesPositions[NORTHERN_EUROPE] = new Point(859, 291);
				_territoriesPositions[SCANDINAVIA] = new Point(892, 207);
				_territoriesPositions[ICELAND] = new Point(879, 136);
				_territoriesPositions[GREAT_BRITAIN] = new Point(738, 203);
				
				// points in Asia
				_territoriesPositions[AFGHANISTAN] = new Point(1140, 304);
				_territoriesPositions[CHINA] = new Point(1324, 345);
				_territoriesPositions[INDIA] = new Point(1259, 425);
				_territoriesPositions[IRKUTSK] = new Point(1380, 248);
				_territoriesPositions[JAPAN] = new Point(1787, 410);
				_territoriesPositions[KAMCHATKA] = new Point(1597, 210);
				_territoriesPositions[MIDDLE_EAST] = new Point(1025, 402);
				_territoriesPositions[MONGOLIA] = new Point(1390, 320);
				_territoriesPositions[SIAM] = new Point(1478, 505);
				_territoriesPositions[SIBERIA] = new Point(1310, 170);
				_territoriesPositions[URAL] = new Point(1162, 179);
				_territoriesPositions[YAKUTSK] = new Point(1384, 189);
				
				// points in Australia
				_territoriesPositions[NEW_GUINEA] = new Point(1720, 666);
				_territoriesPositions[EASTERN_AUSTRALIA] = new Point(1785, 847);
				_territoriesPositions[WESTERN_AUSTRALIA] = new Point(1677, 865);
				_territoriesPositions[INDONESIA] = new Point(1482, 671);
			}
			
			return _territoriesPositions[id];
		}
		
		private static var _unitsPositions:Dictionary;
		
		public static function getUnitsPosition(id:int):Point {
			if (_unitsPositions == null) {
				_unitsPositions = new Dictionary();
				// points for N. America
				_unitsPositions[ALASKA] = new Point(52, 0);
				_unitsPositions[EASTERN_US] = new Point(201, 60);
				_unitsPositions[WESTERN_US] = new Point(38, 4);
				_unitsPositions[ALBERTA] = new Point(25, 5);
				_unitsPositions[QUEBEC] = new Point(60, 7);
				_unitsPositions[ONTARIO] = new Point(30, 13);
				_unitsPositions[NORTHWEST_TERRITORY] = new Point(106, 10);
				_unitsPositions[GREENLAND] = new Point(62, 3);
				_unitsPositions[CENTRAL_AMERICA] = new Point(20, 36);
				
				// points in S.America
				_unitsPositions[VENEZUELA] = new Point(51, 2);
				_unitsPositions[PERU] = new Point(10, 55);
				_unitsPositions[BRAZIL] = new Point(80, 60);
				_unitsPositions[ARGENTINA] = new Point(10, 90);
				
				// points in Africa
				_unitsPositions[NORTH_AFRICA] = new Point(60, 60);
				_unitsPositions[EGYPT] = new Point(33, 10);
				_unitsPositions[EAST_AFRICA] = new Point(30, 60);
				_unitsPositions[CONGO] = new Point(73, 73);
				_unitsPositions[SOUTH_AFRICA] = new Point(30, 60);
				_unitsPositions[MADAGASCAR] = new Point(0, 0);
				
				// points in Europe
				_unitsPositions[WESTERN_EUROPE] = new Point(11, 20);
				_unitsPositions[SOUTHERN_EUROPE] = new Point(28, 14);
				_unitsPositions[UKRAINE] = new Point(93, 115);
				_unitsPositions[NORTHERN_EUROPE] = new Point(6, 0);
				_unitsPositions[SCANDINAVIA] = new Point(18, 0);
				_unitsPositions[ICELAND] = new Point(16, -10);
				_unitsPositions[GREAT_BRITAIN] = new Point(35, -10);
				
				// points in Asia
				_unitsPositions[AFGHANISTAN] = new Point(50, 26);
				_unitsPositions[CHINA] = new Point(109, 55);
				_unitsPositions[INDIA] = new Point(27, 14);
				_unitsPositions[IRKUTSK] = new Point(74, 35);
				_unitsPositions[JAPAN] = new Point(0, 0);
				_unitsPositions[KAMCHATKA] = new Point(80, 0);
				_unitsPositions[MIDDLE_EAST] = new Point(40, 36);
				_unitsPositions[MONGOLIA] = new Point(113, 35);
				_unitsPositions[SIAM] = new Point(38, 45);
				_unitsPositions[SIBERIA] = new Point(7, 19);
				_unitsPositions[URAL] = new Point(38, 25);
				_unitsPositions[YAKUTSK] = new Point(56, 0);
				
				// points in Australia
				_unitsPositions[NEW_GUINEA] = new Point(80, 32);
				_unitsPositions[EASTERN_AUSTRALIA] = new Point(60, 70);
				_unitsPositions[WESTERN_AUSTRALIA] = new Point(30, 60);
				_unitsPositions[INDONESIA] = new Point(80, 75);
			}
			
			return _unitsPositions[id];
		}
		
		private static var _connectionMatrix:Array = null;
		
		public static function isConnected(territoryId1:int, territoryId2:int):Boolean {
			// create matrix
			if (_connectionMatrix == null) {
				_connectionMatrix = new Array(NUMBER_OF_TERRITORIES + 1);
				for (var i:int = 0; i < NUMBER_OF_TERRITORIES + 1; i++) {
					_connectionMatrix[i] = new Array(NUMBER_OF_TERRITORIES + 1);
					for (var j:int = 0; j < NUMBER_OF_TERRITORIES + 1; j++) {
						_connectionMatrix[i][j] = false;
					}
				}
				
				// AMERICAS
				_connectionMatrix[ALASKA][NORTHWEST_TERRITORY] = true;
				_connectionMatrix[ALASKA][ALBERTA] = true;
				_connectionMatrix[ALASKA][KAMCHATKA] = true;
				_connectionMatrix[NORTHWEST_TERRITORY][ALASKA] = true;
				_connectionMatrix[NORTHWEST_TERRITORY][ALBERTA] = true;
				_connectionMatrix[NORTHWEST_TERRITORY][ONTARIO] = true;
				_connectionMatrix[NORTHWEST_TERRITORY][GREENLAND] = true;
				_connectionMatrix[GREENLAND][ICELAND] = true;
				_connectionMatrix[GREENLAND][NORTHWEST_TERRITORY] = true;
				_connectionMatrix[GREENLAND][ONTARIO] = true;
				_connectionMatrix[GREENLAND][QUEBEC] = true;
				_connectionMatrix[ALBERTA][ALASKA] = true;
				_connectionMatrix[ALBERTA][NORTHWEST_TERRITORY] = true;
				_connectionMatrix[ALBERTA][ONTARIO] = true;
				_connectionMatrix[ALBERTA][WESTERN_US] = true;
				_connectionMatrix[ONTARIO][ALBERTA] = true;
				_connectionMatrix[ONTARIO][NORTHWEST_TERRITORY] = true;
				_connectionMatrix[ONTARIO][GREENLAND] = true;
				_connectionMatrix[ONTARIO][QUEBEC] = true;
				_connectionMatrix[ONTARIO][EASTERN_US] = true;
				_connectionMatrix[ONTARIO][WESTERN_US];
				_connectionMatrix[QUEBEC][ONTARIO] = true;
				_connectionMatrix[QUEBEC][GREENLAND] = true;
				_connectionMatrix[QUEBEC][EASTERN_US] = true;
				_connectionMatrix[WESTERN_US][ALBERTA] = true;
				_connectionMatrix[WESTERN_US][ONTARIO] = true;
				_connectionMatrix[WESTERN_US][EASTERN_US] = true;
				_connectionMatrix[WESTERN_US][CENTRAL_AMERICA] = true;
				_connectionMatrix[EASTERN_US][ONTARIO] = true;
				_connectionMatrix[EASTERN_US][QUEBEC] = true;
				_connectionMatrix[EASTERN_US][WESTERN_US] = true;
				_connectionMatrix[EASTERN_US][CENTRAL_AMERICA] = true;
				_connectionMatrix[CENTRAL_AMERICA][WESTERN_US] = true;
				_connectionMatrix[CENTRAL_AMERICA][EASTERN_US] = true;
				_connectionMatrix[CENTRAL_AMERICA][VENEZUELA] = true;
				_connectionMatrix[VENEZUELA][CENTRAL_AMERICA] = true;
				_connectionMatrix[VENEZUELA][BRAZIL] = true;
				_connectionMatrix[VENEZUELA][PERU] = true;
				_connectionMatrix[PERU][VENEZUELA] = true;
				_connectionMatrix[PERU][BRAZIL] = true;
				_connectionMatrix[PERU][ARGENTINA] = true;
				_connectionMatrix[BRAZIL][VENEZUELA] = true;
				_connectionMatrix[BRAZIL][PERU] = true;
				_connectionMatrix[BRAZIL][ARGENTINA] = true;
				_connectionMatrix[BRAZIL][NORTH_AFRICA] = true;
				_connectionMatrix[ARGENTINA][PERU] = true;
				_connectionMatrix[ARGENTINA][BRAZIL] = true;
				
				// AFRICA
				_connectionMatrix[NORTH_AFRICA][BRAZIL] = true;
				_connectionMatrix[NORTH_AFRICA][WESTERN_EUROPE] = true;
				_connectionMatrix[NORTH_AFRICA][SOUTHERN_EUROPE] = true;
				_connectionMatrix[NORTH_AFRICA][EGYPT] = true;
				_connectionMatrix[NORTH_AFRICA][EAST_AFRICA] = true;
				_connectionMatrix[EGYPT][NORTH_AFRICA] = true;
				_connectionMatrix[EGYPT][SOUTHERN_EUROPE] = true;
				_connectionMatrix[EGYPT][MIDDLE_EAST] = true;
				_connectionMatrix[EGYPT][EAST_AFRICA] = true;
				_connectionMatrix[EAST_AFRICA][NORTH_AFRICA] = true;
				_connectionMatrix[EAST_AFRICA][EGYPT] = true;
				_connectionMatrix[EAST_AFRICA][MIDDLE_EAST] = true;
				_connectionMatrix[EAST_AFRICA][CONGO] = true;
				_connectionMatrix[EAST_AFRICA][SOUTH_AFRICA] = true;
				_connectionMatrix[EAST_AFRICA][MADAGASCAR] = true;
				_connectionMatrix[CONGO][NORTH_AFRICA] = true;
				_connectionMatrix[CONGO][EAST_AFRICA] = true;
				_connectionMatrix[CONGO][SOUTH_AFRICA] = true;
				_connectionMatrix[MADAGASCAR][EAST_AFRICA] = true;
				_connectionMatrix[MADAGASCAR][SOUTH_AFRICA] = true;
				_connectionMatrix[SOUTH_AFRICA][CONGO] = true;
				_connectionMatrix[SOUTH_AFRICA][EAST_AFRICA] = true;
				_connectionMatrix[SOUTH_AFRICA][MADAGASCAR] = true;
				
				// AUSTRALIA
				_connectionMatrix[INDONESIA][NEW_GUINEA] = true;
				_connectionMatrix[INDONESIA][SIAM] = true;
				_connectionMatrix[INDONESIA][WESTERN_AUSTRALIA] = true;
				_connectionMatrix[NEW_GUINEA][INDONESIA] = true;
				_connectionMatrix[NEW_GUINEA][EASTERN_AUSTRALIA] = true;
				_connectionMatrix[NEW_GUINEA][WESTERN_AUSTRALIA] = true;
				_connectionMatrix[EASTERN_AUSTRALIA][INDONESIA] = true;
				_connectionMatrix[EASTERN_AUSTRALIA][NEW_GUINEA] = true;
				_connectionMatrix[EASTERN_AUSTRALIA][WESTERN_AUSTRALIA] = true;
				_connectionMatrix[WESTERN_AUSTRALIA][EASTERN_AUSTRALIA] = true;
				_connectionMatrix[WESTERN_AUSTRALIA][NEW_GUINEA] = true;
				_connectionMatrix[WESTERN_AUSTRALIA][INDONESIA] = true;
				
				// EUROPE
				_connectionMatrix[ICELAND][GREAT_BRITAIN] = true;
				_connectionMatrix[ICELAND][SCANDINAVIA] = true;
				_connectionMatrix[GREAT_BRITAIN][ICELAND] = true;
				_connectionMatrix[GREAT_BRITAIN][SCANDINAVIA] = true;
				_connectionMatrix[GREAT_BRITAIN][WESTERN_EUROPE] = true;
				_connectionMatrix[GREAT_BRITAIN][NORTHERN_EUROPE] = true;
				_connectionMatrix[SCANDINAVIA][ICELAND] = true;
				_connectionMatrix[SCANDINAVIA][GREAT_BRITAIN] = true;
				_connectionMatrix[SCANDINAVIA][NORTHERN_EUROPE] = true;
				_connectionMatrix[SCANDINAVIA][UKRAINE] = true;
				_connectionMatrix[WESTERN_EUROPE][GREAT_BRITAIN] = true;
				_connectionMatrix[WESTERN_EUROPE][NORTHERN_EUROPE] = true;
				_connectionMatrix[WESTERN_EUROPE][SOUTHERN_EUROPE] = true;
				_connectionMatrix[WESTERN_EUROPE][NORTH_AFRICA] = true;
				_connectionMatrix[NORTHERN_EUROPE][GREAT_BRITAIN] = true;
				_connectionMatrix[NORTHERN_EUROPE][WESTERN_EUROPE] = true;
				_connectionMatrix[NORTHERN_EUROPE][SCANDINAVIA] = true;
				_connectionMatrix[NORTHERN_EUROPE][UKRAINE] = true;
				_connectionMatrix[NORTHERN_EUROPE][SOUTHERN_EUROPE] = true;
				_connectionMatrix[UKRAINE][NORTHERN_EUROPE] = true;
				_connectionMatrix[UKRAINE][SCANDINAVIA] = true;
				_connectionMatrix[UKRAINE][SOUTHERN_EUROPE] = true;
				_connectionMatrix[UKRAINE][URAL] = true;
				_connectionMatrix[UKRAINE][AFGHANISTAN] = true;
				_connectionMatrix[UKRAINE][MIDDLE_EAST] = true;
				_connectionMatrix[SOUTHERN_EUROPE][WESTERN_EUROPE] = true;
				_connectionMatrix[SOUTHERN_EUROPE][NORTHERN_EUROPE] = true;
				_connectionMatrix[SOUTHERN_EUROPE][UKRAINE] = true;
				_connectionMatrix[SOUTHERN_EUROPE][NORTH_AFRICA] = true;
				_connectionMatrix[SOUTHERN_EUROPE][EGYPT] = true;
				
				// ASIA
				_connectionMatrix[URAL][UKRAINE] = true;
				_connectionMatrix[URAL][AFGHANISTAN] = true;
				_connectionMatrix[URAL][SIBERIA] = true;
				_connectionMatrix[URAL][CHINA] = true;
				_connectionMatrix[SIBERIA][URAL] = true;
				_connectionMatrix[SIBERIA][CHINA] = true;
				_connectionMatrix[SIBERIA][MONGOLIA] = true;
				_connectionMatrix[SIBERIA][IRKUTSK] = true;
				_connectionMatrix[SIBERIA][YAKUTSK] = true;
				_connectionMatrix[YAKUTSK][SIBERIA] = true;
				_connectionMatrix[YAKUTSK][IRKUTSK] = true;
				_connectionMatrix[YAKUTSK][KAMCHATKA] = true;
				_connectionMatrix[IRKUTSK][SIBERIA] = true;
				_connectionMatrix[IRKUTSK][YAKUTSK] = true;
				_connectionMatrix[IRKUTSK][KAMCHATKA] = true;
				_connectionMatrix[IRKUTSK][MONGOLIA] = true;
				_connectionMatrix[KAMCHATKA][ALASKA] = true;
				_connectionMatrix[KAMCHATKA][YAKUTSK] = true;
				_connectionMatrix[KAMCHATKA][IRKUTSK] = true;
				_connectionMatrix[KAMCHATKA][JAPAN] = true;
				_connectionMatrix[KAMCHATKA][MONGOLIA] = true;
				_connectionMatrix[MONGOLIA][IRKUTSK] = true;
				_connectionMatrix[MONGOLIA][KAMCHATKA] = true;
				_connectionMatrix[MONGOLIA][JAPAN] = true;
				_connectionMatrix[MONGOLIA][SIBERIA] = true;
				_connectionMatrix[MONGOLIA][CHINA] = true;
				_connectionMatrix[JAPAN][KAMCHATKA] = true;
				_connectionMatrix[JAPAN][MONGOLIA] = true;
				_connectionMatrix[AFGHANISTAN][URAL] = true;
				_connectionMatrix[AFGHANISTAN][CHINA] = true;
				_connectionMatrix[AFGHANISTAN][INDIA] = true;
				_connectionMatrix[AFGHANISTAN][MIDDLE_EAST] = true;
				_connectionMatrix[MIDDLE_EAST][AFGHANISTAN] = true;
				_connectionMatrix[MIDDLE_EAST][UKRAINE] = true;
				_connectionMatrix[MIDDLE_EAST][SOUTHERN_EUROPE] = true;
				_connectionMatrix[MIDDLE_EAST][EGYPT] = true;
				_connectionMatrix[MIDDLE_EAST][EAST_AFRICA] = true;
				_connectionMatrix[MIDDLE_EAST][INDIA] = true;
				_connectionMatrix[INDIA][AFGHANISTAN] = true;
				_connectionMatrix[INDIA][MIDDLE_EAST] = true;
				_connectionMatrix[INDIA][CHINA] = true;
				_connectionMatrix[INDIA][SIAM] = true;
				_connectionMatrix[CHINA][MONGOLIA] = true;
				_connectionMatrix[CHINA][SIBERIA] = true;
				_connectionMatrix[CHINA][URAL] = true;
				_connectionMatrix[CHINA][AFGHANISTAN] = true;
				_connectionMatrix[CHINA][INDIA] = true;
				_connectionMatrix[CHINA][SIAM] = true;
				_connectionMatrix[SIAM][CHINA] = true;
				_connectionMatrix[SIAM][INDIA] = true;
				_connectionMatrix[SIAM][INDONESIA] = true;
			}
			
			return _connectionMatrix[territoryId1][territoryId2];
		}
	
	}

}