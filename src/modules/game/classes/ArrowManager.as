package modules.game.classes {
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import modules.game.GameView;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import utils.Assets;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ArrowManager {
		
		private static const ARROW_TWEEK:int = 6;
		private static const ARROW_ALPHA:Number = 0.5;
		
		private var _arrowSprite:Sprite;
		
		public function ArrowManager(view:GameView) {
			_arrowSprite = view.arrowsSprite;
		}
		
		public function drawArrow(source:TerritoryWrapper, dest:TerritoryWrapper, color:uint):void {
			var arrow:Bitmap = new Assets.Arrow();
			// color bitmap
			for (var x:int = 0; x < arrow.bitmapData.width; x++) {
				for (var y:int = 0; y < arrow.bitmapData.height; y++) {
					var pixel:uint = arrow.bitmapData.getPixel32(x, y);
					var alpha:uint = (pixel >> 24) & 0xFF;
					if (alpha > 0) {
						arrow.bitmapData.setPixel(x, y, color);
					} 
				}
			}
			
			// create arrow texture
			var texture:Texture = Texture.fromBitmapData(arrow.bitmapData);
			var texture3grid:Scale3Textures = new Scale3Textures(texture, 1, 1);
			
			var image:Scale3Image = new Scale3Image(texture3grid);
			image.alpha = ARROW_ALPHA;
			
			var sourcePosition:Point = Territories.getTerritoryPosition(source.id);
			var sourceUnitPosition:Point = Territories.getUnitsPosition(source.id);
			sourcePosition.x += sourceUnitPosition.x;
			sourcePosition.y += sourceUnitPosition.y;
			
			var destinationPosition:Point = Territories.getTerritoryPosition(dest.id);
			var destionationUnitPosition:Point = Territories.getUnitsPosition(dest.id);
			destinationPosition.x += destionationUnitPosition.x + ARROW_TWEEK;
			destinationPosition.y += destionationUnitPosition.y + ARROW_TWEEK;
			
			var arrowLength:int = Math.sqrt(Math.pow(destinationPosition.x - sourcePosition.x, 2) + 
											Math.pow(destinationPosition.y - sourcePosition.y, 2));
			
			image.width = arrowLength;
			
			image.x = sourcePosition.x;
			image.y = sourcePosition.y;
			
			var angle:Number = Math.atan2(destinationPosition.y - sourcePosition.y, destinationPosition.x - sourcePosition.x);
			
			image.pivotX = 0;
			//image.pivotY = 12;
			
			image.rotation = angle;
			
			
			_arrowSprite.addChild(image);
		}
		
		public function removeAllArrows():void {
			_arrowSprite.removeChildren();
		}
	
	}

}