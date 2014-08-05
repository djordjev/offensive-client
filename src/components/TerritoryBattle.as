package components {
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import starling.display.Quad;
	import starling.events.Event;
	import utils.Colors;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TerritoryBattle extends LayoutGroup {
		
		public static const ROLL_CLICKED:String = "roll button clicked on component";
		
		public var rollButton:Button = new Button();
		public var dices:Array = [];
		
		public function TerritoryBattle() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			var background:Quad = new Quad(250, 100, Colors.BLACK);
			this.addChild(background);
			
			
			var mainGroup:LayoutGroup = new LayoutGroup();
			this.addChild(mainGroup);
			
			mainGroup.layout = new VerticalLayout();
			(mainGroup.layout as VerticalLayout).gap = 5;
			
			rollButton.label = "ROLL";
			rollButton.visible = false;
			rollButton.addEventListener(Event.TRIGGERED, function (e:Event):void {
				dispatchEvent(new Event(ROLL_CLICKED));
			});
			
			mainGroup.addChild(rollButton);
			
			var dicesGroup:LayoutGroup = new LayoutGroup();
			dicesGroup.layout = new HorizontalLayout();
			(dicesGroup.layout as HorizontalLayout).gap = 5;
			
			mainGroup.addChild(dicesGroup);
			
			for (var i:int = 0; i < 3; i++) {
				var diceImage:ImageLoader = new ImageLoader();
				// set image
				dices.push(diceImage);
			}
			
		}
		
		public function show(showRoll:Boolean = false):void {
			this.visible = true;
			
			rollButton.visible = showRoll;
		}
		
		public function hide():void {
			this.visible = false;
		}
	
	}

}