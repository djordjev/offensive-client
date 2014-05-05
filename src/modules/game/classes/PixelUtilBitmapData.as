package modules.game.classes {
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class PixelUtilBitmapData {
		
		private static const PIXEL_TRANSPARENT_TRASHOLD:Number = 20;
		
		private static const MASK:uint = 0xFF;
		private static const ALPHA_CHANNEL_OFFSET:uint = 24;
		
		public var bitmapData:BitmapData;
		
		public function PixelUtilBitmapData(initBitmapData:BitmapData) {
			bitmapData = initBitmapData;
		}
		
		public function isTransparent(localPoint:Point):Boolean {
			var targetPixel:uint = bitmapData.getPixel32(localPoint.x, localPoint.y);
			if ((targetPixel >> ALPHA_CHANNEL_OFFSET & MASK) <= PIXEL_TRANSPARENT_TRASHOLD) {
				return true;
			} else {
				return false;
			}
			
		}
	
	}

}