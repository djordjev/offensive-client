package modules.game {
	import com.netease.protobuf.Int64;
	import communication.protos.GameContext;
	import communication.protos.Player;
	import components.common.OLabel;
	import components.common.OLabel;
	import components.TerritoryVisual;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import flash.geom.Point;
	import flash.sampler.NewObjectSample;
	import modules.game.classes.Territories;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import utils.Assets;
	import utils.Colors;
	import wrappers.UserWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameView extends LayoutGroup {
		private static const WIDTH:int = 1024;
		private static const HEIGHT:int = 768;
		
		private static const CONTROL_PANEL_HEIGHT:int = 150;
		private static const CONTROL_PANEL_WIDTH:int = 1024;
		private static const CONTROL_PANEL_BACKGROUND_ALPHA:Number = 0.2;
		
		private var _mapSprite:Sprite = new Sprite();
		
		public var backButton:Button = new Button();
		
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
			image.setTexCoords(2, new Point(0, 24));
			image.setTexCoords(3, new Point(16, 24));
			
			image.width = WIDTH;
			image.height = HEIGHT;
			this.addChild(image);
			
			// add terrotories components
			populateTerritories();
			
			// add control panel
			populateControlPanel();
		}
		
		private function populateTerritories():void {
			for (var i:int = 0; i < Territories.NUMBER_OF_TERRITORIES; i++) {
				_mapSprite.addChild(new TerritoryVisual());
			}
			
			this.addChild(_mapSprite);
		}
		
		private function populateControlPanel():void {
			var controlPanel:LayoutGroup = new LayoutGroup();
			controlPanel.y = HEIGHT - CONTROL_PANEL_HEIGHT;
			
			var controlPanelBackground:Quad = new Quad(CONTROL_PANEL_WIDTH, CONTROL_PANEL_HEIGHT, Colors.WHITE);
			controlPanelBackground.alpha = CONTROL_PANEL_BACKGROUND_ALPHA;
			controlPanel.addChild(controlPanelBackground);
			
			backButton.label = "Back";
			backButton.width = 50;
			backButton.height = 30;
			backButton.x = 950;
			backButton.y = 100;
			controlPanel.addChild(backButton);
			
			this.addChild(controlPanel);
		}
		
		public function getTerritoryVisual(id:int):TerritoryVisual {
			if (_mapSprite.numChildren == Territories.NUMBER_OF_TERRITORIES) {
				return _mapSprite.getChildAt(id - 1) as TerritoryVisual;
			} else {
				return null;
			}
		}
	}

}