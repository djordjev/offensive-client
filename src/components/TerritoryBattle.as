package components {
	import communication.protos.RollDiceClicked;
	import components.common.LinkButton;
	import components.common.OLabel;
	import components.events.MouseClickEvent;
	import components.events.RollDicesClickEvent;
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import flash.geom.Point;
	import modules.game.classes.Territories;
	import modules.game.GameController;
	import modules.game.GameModel;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import utils.Assets;
	import utils.Colors;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TerritoryBattle extends LayoutGroup {
		
		public var rollButton:LinkButton = new LinkButton();
		
		public var remainingTime:OLabel = new OLabel();
		
		/** Array of ImageLoader's */
		public var dices:Array = [];
		
		private var _headerGroup:LayoutGroup = new LayoutGroup();
		
		private var _territoryComponent:TerritoryVisual;
		
		public function TerritoryBattle(territoryComponent:TerritoryVisual) {
			_territoryComponent = territoryComponent;
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			var background:Quad = new Quad(200, 110, Colors.BLACK);
			this.addChild(background);
			background.alpha = 0.8;
			
			
			var mainGroup:LayoutGroup = new LayoutGroup();
			mainGroup.x = 15;
			mainGroup.y = 14;
			this.addChild(mainGroup);
			
			mainGroup.layout = new VerticalLayout();
			(mainGroup.layout as VerticalLayout).gap = 5;
			(mainGroup.layout as VerticalLayout).horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			
			_headerGroup.layout = new HorizontalLayout();
			(_headerGroup.layout as HorizontalLayout).gap = 40;
			
			rollButton.label = "Roll";
			rollButton.fontColor = Colors.WHITE;
			rollButton.fontSize = 20;
			rollButton.addEventListener(MouseClickEvent.CLICK, function (e:Event):void {
				rollButton.isEnabled = false;
				dispatchEvent(new RollDicesClickEvent(RollDicesClickEvent.ROLL_CLICKED, 
								_territoryComponent.territory, true));
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
				dicesGroup.addChild(diceImage);
				
			}
			
		}
		
		public function enableRollButton():void {
			rollButton.isEnabled = true;
		}
		
		public function show(showRoll:Boolean = false):void {
			addBattleInfoComponent();
			_headerGroup.visible = showRoll;
		}
		
		public function hide():void {
			GameController.instance.view.battleInfoGroup.removeChild(this);
		}
		
		private function addBattleInfoComponent():void {
			var targetPoint:Point = new Point(_territoryComponent.x, _territoryComponent.y);
			
			var unitsPosition:Point = Territories.getUnitsPosition(_territoryComponent.territory.id);
			
			targetPoint.x += unitsPosition.x;
			targetPoint.y += unitsPosition.y;
			
			targetPoint.x += 50;
			
			targetPoint.x *= 1 / GameController.instance.view.mapScale;
			targetPoint.y *= 1 / GameController.instance.view.mapScale;
			
			targetPoint.x -= Math.abs(GameController.instance.view.mapX);
			targetPoint.y -= Math.abs(GameController.instance.view.mapY);
			
			x = targetPoint.x;
			y = targetPoint.y;
			
			GameController.instance.view.battleInfoGroup.addChild(this);
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