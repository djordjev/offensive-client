package modules.game 
{
	import components.common.OLabel;
	import components.common.OLabel;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import flash.geom.Point;
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
	public class GameView extends LayoutGroup 
	{
		private static const WIDTH:int = 1024;
		private static const HEIGHT:int = 768;
		
		private static const CONTROL_PANEL_HEIGHT:int = 150;
		private static const CONTROL_PANEL_WIDTH:int = 1024;
		private static const CONTROL_PANEL_BACKGROUND_ALPHA:Number = 0.2;
		
		private var _mapSprite:Sprite = new Sprite();
		
		public function GameView() 
		{
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
			
			// add control panel
			populateControlPanel();
			
		}
		
		private function populateControlPanel():void {
			var controlPanel:LayoutGroup = new LayoutGroup();
			controlPanel.y = HEIGHT - CONTROL_PANEL_HEIGHT;
			
			var controlPanelBackground:Quad = new Quad(CONTROL_PANEL_WIDTH, CONTROL_PANEL_HEIGHT, Colors.WHITE);
			controlPanelBackground.alpha = CONTROL_PANEL_BACKGROUND_ALPHA;
			controlPanel.addChild(controlPanelBackground);
			
			var backButton:Button = new Button();
			backButton.label = "Back";
			backButton.width = 50;
			backButton.height = 30;
			backButton.x = 950;
			backButton.y = 100;
			backButton.addEventListener(Event.TRIGGERED, goBack);
			controlPanel.addChild(backButton);
			
			this.addChild(controlPanel);
		}
		
		private function goBack(e:Event):void {
			dispatchEvent(new Event(GameController.LEAVE_GAME, true));
		}
		
	}

}