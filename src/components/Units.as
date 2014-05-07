package components {
	import components.common.OLabel;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.text.TextFormatAlign;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import utils.Colors;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class Units extends LayoutGroup {
		
		private static const CIRCLE_RADIUS:uint = 12;
		
		private var _background:ImageLoader = new ImageLoader();
		private var _unitsLabel:OLabel = new OLabel();
		
		private var _color:uint;
		
		public function Units() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			this.addChild(_background);
			
			
			_unitsLabel.width = 2 * CIRCLE_RADIUS;
			_unitsLabel.height = 2 * CIRCLE_RADIUS;
			_unitsLabel.textAlign = TextFormatAlign.CENTER;
			this.addChild(_unitsLabel);
		}
		
		public function setColorAndUnits(color:uint, numberOfUnits:uint):void {
			if (color != _color) {
				var circle:Shape = new Shape();
				circle.graphics.lineStyle(3, Colors.BLACK);
				circle.graphics.beginFill(color);
				circle.graphics.drawCircle(CIRCLE_RADIUS, CIRCLE_RADIUS, CIRCLE_RADIUS);
				circle.graphics.endFill();
				var bitmapData:BitmapData = new BitmapData(2 * CIRCLE_RADIUS, 2 * CIRCLE_RADIUS, true, 0x000000);
				bitmapData.draw(circle);
				
				_background.source = Texture.fromBitmapData(bitmapData);
				_color = color;
			}
		
			if (_unitsLabel.text != numberOfUnits.toString()) {
				_unitsLabel.text = numberOfUnits.toString();
			}
		}
	
	}

}