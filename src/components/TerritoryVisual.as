package components {
	import communication.protos.Territory;
	import components.common.ComponentWithStates;
	import components.common.OLabel;
	import components.common.StatesAdapter;
	import components.events.MouseClickEvent;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.core.FeathersControl;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import modules.game.classes.PixelUtilBitmapData;
	import modules.game.classes.Territories;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.filters.BlurFilter;
	import starling.textures.Texture;
	import utils.Assets;
	import utils.Colors;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class TerritoryVisual extends LayoutGroup implements ComponentWithStates {
		
		
		private var _territory:TerritoryWrapper;
		
		private var _bitmapData:PixelUtilBitmapData;
		private var _glow:BlurFilter;
		
		private var _image:ImageLoader = new ImageLoader();
		private var _nameLabel:OLabel = new OLabel();
		
		var _statesAdapter:StatesAdapter;
		
		public function TerritoryVisual() {
			super();
			_statesAdapter = new StatesAdapter(this);
			addEventListener(MouseClickEvent.CLICK, mouseClicked);
		}
		
		public function get glow():BlurFilter {
			if (_glow == null) {
				_glow = BlurFilter.createGlow(Colors.RED, 1, 4);
			}
			return _glow;
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
				_image.source = Texture.fromBitmapData(_bitmapData.bitmapData);
				
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
			this.filter = null;
		}
		
		public function changeToDown():void {
		}
		
		public function changeToHovered():void {
			this.filter = glow;
			// move up front
			this.parent.setChildIndex(this, this.parent.numChildren - 1);
		}
		
		private function mouseClicked(e:MouseClickEvent):void {
			trace("Clicked ON " + _territory.name);
			_bitmapData.addColorOverlay(0x00FF00);
			_image.source = Texture.fromBitmapData(_bitmapData.bitmapData);
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