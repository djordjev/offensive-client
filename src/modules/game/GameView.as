package modules.game {
	import components.classes.PlayerRenderer;
	import components.common.OLabel;
	import components.TerritoryVisual;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.Scroller;
	import feathers.layout.HorizontalLayout;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import modules.game.classes.Territories;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import utils.Assets;
	import utils.Colors;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameView extends LayoutGroup {
		public static const NORMAL_SCALE:Number = 1024 / 2000;
		
		private static const WIDTH:int = 1024;
		private static const HEIGHT:int = 768;
		
		private static const CONTROL_PANEL_HEIGHT:int = 150;
		private static const CONTROL_PANEL_WIDTH:int = 1024;
		private static const CONTROL_PANEL_BACKGROUND_ALPHA:Number = 0.2;
		
		private var _mapSprite:Sprite = new Sprite();
		public var arrowsSprite:Sprite = new Sprite();
		private var _territories:Dictionary = new Dictionary();
		
		public var backButton:Button = new Button();
		public var commitButton:Button = new Button();
		public var playersList:List = new List();
		
		public var gamePhase:OLabel = new OLabel();
		public var unitsCount:OLabel = new OLabel();
		public var numberOfReinforcements:OLabel = new OLabel();
		
		private var _wholeMap:LayoutGroup = new LayoutGroup();
		private var _battleInfoGroup:LayoutGroup = new LayoutGroup();
		
		// game fields
		
		public function GameView() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			// add sea background
			
			var seaBitmap:Class = Assets.SeaBackground;
			var seaTexture:Texture = Texture.fromBitmap(new seaBitmap());
			seaTexture.repeat = true;
			var image:Image = new Image(seaTexture);
			image.setTexCoords(1, new Point(16, 0));
			image.setTexCoords(2, new Point(0, 16));
			image.setTexCoords(3, new Point(16, 16));
			
			image.width = WIDTH;
			image.height = HEIGHT;
			this.addChild(image);
			
			this.addChild(_wholeMap);
			
			this.addChild(_battleInfoGroup);
			
			// add terrotories components
			populateTerritories();
			
			// add control panel
			populateControlPanel();
			
			// add arrows sprite
			arrowsSprite.width = this.width;
			arrowsSprite.height = this.height;
			
			_wholeMap.addChild(_mapSprite);
			_wholeMap.addChild(arrowsSprite);
		}
		
		public function get battleInfoGroup():LayoutGroup {
			return _battleInfoGroup;
		}
		
		private function populateTerritories():void {
			for (var i:int = 0; i < Territories.NUMBER_OF_TERRITORIES; i++) {
				var visualTerritory:TerritoryVisual = new TerritoryVisual();
				_territories[i + 1] = visualTerritory;
				_mapSprite.addChild(visualTerritory);
			}
			
			_mapSprite.name = "Map Sprite";
		}
		
		private function populateControlPanel():void {
			var controlPanel:LayoutGroup = new LayoutGroup();
			controlPanel.y = HEIGHT - CONTROL_PANEL_HEIGHT;
			
			var controlPanelBackground:Quad = new Quad(CONTROL_PANEL_WIDTH, CONTROL_PANEL_HEIGHT, Colors.WHITE);
			controlPanelBackground.alpha = CONTROL_PANEL_BACKGROUND_ALPHA;
			controlPanel.addChild(controlPanelBackground);
			
			backButton.label = "Back";
			backButton.width = 70;
			backButton.height = 30;
			backButton.x = 930;
			backButton.y = 50;
			controlPanel.addChild(backButton);
			
			playersList.x = 10;
			playersList.y = 10;
			playersList.height = 130;
			playersList.width = 720;
			var listLayout:HorizontalLayout = new HorizontalLayout();
			listLayout.gap = 20;
			playersList.layout = listLayout;
			playersList.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			playersList.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			playersList.itemRendererFactory = playersListItemRendererFactoryFunction;
			playersList.addEventListener(Event.ADDED_TO_STAGE, function friendsListAddedToStage(e:Event):void {
				playersList.backgroundSkin.alpha = 0;
			});
			controlPanel.addChild(playersList);
			
			gamePhase.fontSize = 17;
			gamePhase.x = 620;
			gamePhase.y = 20;
			gamePhase.maxWidth = 240;
			controlPanel.addChild(gamePhase);
			
			unitsCount.fontSize = 17;
			unitsCount.x = 620;
			unitsCount.y = 60;
			unitsCount.maxWidth = 240;
			controlPanel.addChild(unitsCount);
			
			numberOfReinforcements.fontSize = 17;
			numberOfReinforcements.x = 620;
			numberOfReinforcements.y = 100;
			numberOfReinforcements.maxWidth = 240;
			controlPanel.addChild(numberOfReinforcements);
			
			commitButton.label = "Commit";
			commitButton.x = 930;
			commitButton.y = 100;
			commitButton.width = 70;
			commitButton.height = 30;
			controlPanel.addChild(commitButton);
			
			this.addChild(controlPanel);
		}
		
		/** Returns TerritoryVisual component for teritory Id */
		public function getTerritoryVisual(id:int):TerritoryVisual {
			return _territories[id];
		}
		
		private function playersListItemRendererFactoryFunction():IListItemRenderer {
			return new PlayerRenderer();
		}
		
		public function set mapScale(value:Number):void {
			_wholeMap.scaleX = _wholeMap.scaleY = value;
		}
		
		public function set mapX(value:Number):void {
			_wholeMap.x = value;
		}
		
		public function set mapY(value:Number):void {
			_wholeMap.y = value;
		}
		
		public function get mapY():Number {
			return _wholeMap.y;
		}
		
		public function get mapX():Number {
			return _wholeMap.x;
		}
		
		public function get mapScale():Number {
			return _wholeMap.scaleX;
		}
	}

}