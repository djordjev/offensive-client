package components {
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import starling.display.Quad;
	import utils.Colors;
	
	/**
	 * ...
	 * @author Djordje
	 */
	public class AlliancesPopup extends LayoutGroup {
		
		private static const WIDTH:int = 440;
		private static const HEIGHT:int = 460;
		
		private static var _instance:AlliancesPopup = null;
		
		public static function get instance():AlliancesPopup {
			if (_instance == null) {
				new AlliancesPopup();
			}
			return _instance;
		}
		
		private var _horizontalList:List = new List();
		private var _verticalList:List = new List();
		private var _alliancesGroup:LayoutGroup = new LayoutGroup();
		
		public function AlliancesPopup() {
			super();
			if (_instance == null) {
				_instance = this;
			} else {
				throw new Error("This should be singleton");
			}
		}
		
		override protected function initialize():void {
			super.initialize();
			
			var background:Quad = new Quad(WIDTH, HEIGHT, Colors.BLACK);
			background.alpha = 0.8;
			this.addChild(background);
			
			
		}
	
	}

}