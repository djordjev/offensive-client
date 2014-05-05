package components {
	import communication.protos.Territory;
	import components.common.ComponentWithStates;
	import components.common.OLabel;
	import components.common.StatesAdapter;
	import components.events.MouseClickEvent;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import modules.game.classes.PixelUtilBitmapData;
	import modules.game.classes.Territories;
	import starling.display.DisplayObject;
	import starling.textures.Texture;
	import utils.Assets;
	import utils.Colors;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class TerritoryVisual extends LayoutGroup implements ComponentWithStates {
		
		private static const CLICK_TRANSPARENCY_TRASHOLD:Number = 0.1;
		
		private var _territory:TerritoryWrapper;
		
		private var _bitmapData:PixelUtilBitmapData;
		
		private var _image:ImageLoader = new ImageLoader();
		private var _nameLabel:OLabel = new OLabel();
		
		var _statesAdapter:StatesAdapter;
		
		public function TerritoryVisual() {
			super();
			_statesAdapter = new StatesAdapter(this);
			addEventListener(MouseClickEvent.CLICK, mouseClicked);
		}
		
		override protected function initialize():void {
			super.initialize();
			
			this.addChild(_image);
			
			_nameLabel.x = 15;
			_nameLabel.y = 20;
			this.addChild(_nameLabel);
		}
		
		public function set territory(value:TerritoryWrapper):void {
			if (value != null && value.territory.id != 36) {
				_territory = value;
				
				var territoryClass:Class = Assets.getTerritory(value.territory.id);
				var bitmap:Bitmap = new territoryClass();
				_bitmapData = new PixelUtilBitmapData(bitmap.bitmapData);
				// add background image
				var texture:Texture = Texture.fromBitmapData(_bitmapData.bitmapData);
				_image.source = texture;
				
				//_nameLabel.text = _territory.name;
				
				var position:Point = Territories.getTerritoryPosition(_territory.territory.id);
				if(position) {
					this.x = position.x;
					this.y = position.y;
				} else {
					this.x = 700;
					this.y = 700;
				}
			}
		}
		
		public function get territory():TerritoryWrapper {
			return _territory;
		}
		
		public function changeToUp():void {
		}
		
		public function changeToDown():void {
		}
		
		public function changeToHovered():void {
		}
		
		private function mouseClicked(e:MouseClickEvent):void {
			trace("Clicked ON " + _territory.name);
		}
		
		override public function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject {
			if (_bitmapData != null) {
				if (_bitmapData.isTransparent(localPoint)) {
					return null;
				} else {
					return super.hitTest(localPoint, forTouch);
				}
			} else {
				return super.hitTest(localPoint, forTouch);
			}
		}
	
	}

}