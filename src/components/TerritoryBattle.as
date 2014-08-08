package components {
	import components.common.LinkButton;
	import components.common.OLabel;
	import components.events.MouseClickEvent;
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import modules.game.GameModel;
	import starling.display.Quad;
	import starling.events.Event;
	import utils.Assets;
	import utils.Colors;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TerritoryBattle extends LayoutGroup {
		
		public static const ROLL_CLICKED:String = "roll button clicked on component";
		
		public var rollButton:LinkButton = new LinkButton();
		
		public var remainingTime:OLabel = new OLabel();
		
		/** Array of ImageLoader's */
		public var dices:Array = [];
		
		private var _headerGroup:LayoutGroup = new LayoutGroup();
		
		public function TerritoryBattle() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			var background:Quad = new Quad(200, 110, Colors.BLACK);
			this.addChild(background);
			background.alpha = 0.8;
			
			
			var mainGroup:LayoutGroup = new LayoutGroup();
			this.addChild(mainGroup);
			
			mainGroup.layout = new VerticalLayout();
			(mainGroup.layout as VerticalLayout).gap = 5;
			
			_headerGroup.layout = new HorizontalLayout();
			(_headerGroup.layout as HorizontalLayout).gap = 40;
			
			rollButton.label = "Roll";
			rollButton.fontColor = Colors.WHITE;
			rollButton.fontSize = 20;
			rollButton.visible = false;
			rollButton.addEventListener(MouseClickEvent.CLICK, function (e:Event):void {
				dispatchEvent(new Event(ROLL_CLICKED, true));
			});
			
			remainingTime.fontSize = 20;
			remainingTime.fontColor = Colors.WHITE;

			_headerGroup.addChild(rollButton);
			_headerGroup.addChild(remainingTime);
			
			mainGroup.addChild(_headerGroup);
			
			var dicesGroup:LayoutGroup = new LayoutGroup();
			dicesGroup.width = 170;
			dicesGroup.height = 50;
			dicesGroup.layout = new HorizontalLayout();
			(dicesGroup.layout as HorizontalLayout).gap = 10;
			
			mainGroup.addChild(dicesGroup);
			
			for (var i:int = 0; i < 3; i++) {
				var diceImage:ImageLoader = new ImageLoader();
				// set image
				dices.push(diceImage);
			}
			
		}
		
		public function show(showRoll:Boolean = false):void {
			this.visible = true;
			
			_headerGroup.visible = showRoll;
		}
		
		public function hide():void {
			this.visible = false;
		}
		
		public function setRemainingTime(remaining:int):void {
			remainingTime.text = remaining.toString();
		}
		
		public function setDices(values:Array):void {
			
			for (var i:int; i < GameModel.MAX_DICES; i++) {
				if (i < values.length) {
					dices[i].source = Assets.getDice(values[i]);
				} else {
					dices[i].source = null;
				}
				
			}
		}
	
	}

}