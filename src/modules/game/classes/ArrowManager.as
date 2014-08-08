package modules.game.classes {
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import modules.game.GameView;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import utils.Assets;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ArrowManager {
		
		private static const ARROW_TWEEK:int = 25;
		private static const ARROW_ALPHA:Number = 0.5;
		
		private var _arrowSprite:Sprite;
		
		public function ArrowManager(view:GameView) {
			_arrowSprite = view.arrowsSprite;
		}
		
		public function drawArrow(source:TerritoryWrapper, dest:TerritoryWrapper, color:uint, zoom:Number):void {
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
			var texture3grid:Scale3Textures = new Scale3Textures(texture, 38, 1);
			
			var image:Scale3Image = new Scale3Image(texture3grid);
			image.alpha = ARROW_ALPHA;
			
			var sourcePosition:Point = calculateTargetPosition(source);
			var destinationPosition:Point = calculateTargetPosition(dest);
			
			var arrowLength:int = Math.sqrt(Math.pow(destinationPosition.x - sourcePosition.x, 2) + 
											Math.pow(destinationPosition.y - sourcePosition.y, 2)) - ARROW_TWEEK;
			
			image.width = arrowLength;
			
			image.x = sourcePosition.x;
			image.y = sourcePosition.y;
			
			var angle:Number = Math.atan2(destinationPosition.y - sourcePosition.y, destinationPosition.x - sourcePosition.x);
			
			image.alignPivot(HAlign.LEFT, VAlign.CENTER);
			
			image.rotation = angle;
			
			_arrowSprite.addChild(image);
		}
		
		public function drawDoubleArrow(territory1:TerritoryWrapper, territory2:TerritoryWrapper, zoom:Number):void {
			var arrow:Bitmap = new Assets.DoubleArrow();
			
			var texture:Texture = Texture.fromBitmapData(arrow.bitmapData);
			var texture3grid:Scale3Textures = new Scale3Textures(texture, 80, 1);
			
			var image:Scale3Image = new Scale3Image(texture3grid);
			image.alpha = ARROW_ALPHA;
			
			var sourcePosition:Point = calculateTargetPosition(territory1);
			var destPosition:Point = calculateTargetPosition(territory2);
			
			var arrowLength:int = Math.sqrt(Math.pow(destPosition.x - sourcePosition.x, 2) + 
											Math.pow(destPosition.y - sourcePosition.y, 2)) - ARROW_TWEEK;
			
			image.width = arrowLength;
			
			image.x = sourcePosition.x;
			image.y = sourcePosition.y;
			
			var angle:Number = Math.atan2(destPosition.y - sourcePosition.y, destPosition.x - sourcePosition.x);
			
			image.alignPivot(HAlign.LEFT, VAlign.CENTER);
			
			image.rotation = angle;
			
			
			_arrowSprite.addChild(image);
		}
		
		private function calculateTargetPosition(territory:TerritoryWrapper):Point {
			var position:Point = Territories.getTerritoryPosition(territory.id).clone();
			var unitsOffset:Point = Territories.getUnitsPosition(territory.id);
			position.x += unitsOffset.x + ARROW_TWEEK;
			position.y += unitsOffset.y + ARROW_TWEEK;
			return position;
		}
		
		public function clearAllArrows():void {
			_arrowSprite.removeChildren();
		}
	
	}

}