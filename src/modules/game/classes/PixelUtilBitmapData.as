package modules.game.classes {
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class PixelUtilBitmapData {
		
		private static const PIXEL_TRANSPARENT_TRASHOLD:Number = 20;
		private static const MIXTURE_PERCENT:Number = 0.8;
		
		private static const MASK:uint = 0xFF;
		private static const ALPHA_CHANNEL_OFFSET:uint = 24;
		private static const RED_CHANNEL_OFFSET:uint = 16;
		private static const GREEN_CHANNEL_OFFSET:int = 8;
		private static const BLUE_CHANNEL_OFFSET:int = 0;
		
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
		
		public function addColorOverlay(color:uint):void {
			// iterate through all pixels
			for (var x:int = 0; x < bitmapData.width; x++) {
				for (var y:int = 0; y < bitmapData.height; y++) {
					var targetPixel:uint = bitmapData.getPixel32(x, y);
					var alphaChannelImage:uint = targetPixel >> ALPHA_CHANNEL_OFFSET & MASK;
					
					if (alphaChannelImage > 0) {
						var redChannelImage:uint = targetPixel >> RED_CHANNEL_OFFSET & MASK;
						var greenChannelImage:uint = targetPixel >> GREEN_CHANNEL_OFFSET & MASK;
						var blueChannelImage:uint = targetPixel >> BLUE_CHANNEL_OFFSET & MASK;
						
						var redChannelOverlay:uint = color >> RED_CHANNEL_OFFSET & MASK;
						var greenChannelOverlay:uint = color >> GREEN_CHANNEL_OFFSET & MASK;
						var blueChannelOverlay:uint = color >> BLUE_CHANNEL_OFFSET & MASK;
						
						var newAlphaChannel:uint = alphaChannelImage << ALPHA_CHANNEL_OFFSET;
						var newRedChannel:uint = (MIXTURE_PERCENT * redChannelImage + (1 - MIXTURE_PERCENT) * redChannelOverlay) << RED_CHANNEL_OFFSET;
						var newGreenChannel:uint = (MIXTURE_PERCENT * greenChannelImage + (1 - MIXTURE_PERCENT) * greenChannelOverlay) << GREEN_CHANNEL_OFFSET;
						var newBlueChannel:uint = (MIXTURE_PERCENT * blueChannelImage + (1 - MIXTURE_PERCENT) * blueChannelOverlay) << BLUE_CHANNEL_OFFSET;
						
						bitmapData.setPixel32(x, y, newAlphaChannel | newRedChannel | newGreenChannel | newBlueChannel);
					}
					
				}
			}
		}
	
	}

}