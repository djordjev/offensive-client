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
	import modules.game.events.ClickOnTerritory;
	import modules.game.GameModel;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.textures.Texture;
	import utils.Assets;
	import utils.Colors;
	import utils.PlayerColors;
	import wrappers.PlayerWrapper;
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
		
		private var _units:Units = new Units();
		private var _battleDisplay:TerritoryBattle = new TerritoryBattle();
		
		private var _statesAdapter:StatesAdapter;
		
		public function TerritoryVisual() {
			super();
			_statesAdapter = new StatesAdapter(this);
			addEventListener(MouseClickEvent.CLICK, mouseClicked);
		}
		
		public function get glow():BlurFilter {
			if (_glow == null) {
				_glow = BlurFilter.createGlow(Colors.WHITE, 1, 4);
			}
			return _glow;
		}
		
		public function get battleDisplay():TerritoryBattle {
			return _battleDisplay;
		}
		
		override protected function initialize():void {
			super.initialize();
			
			this.addChild(_image);
			_nameLabel.x = 15;
			_nameLabel.y = 20;
			this.addChild(_nameLabel);
			
			this.addChild(_units);
			this.addChild(_battleDisplay);
			_battleDisplay.hide();
		}
		
		public function set territory(value:TerritoryWrapper):void {
			if (value != null) {
				
				_territory = value;
				
				var territoryClass:Class = Assets.getTerritory(value.id);
				var bitmap:Bitmap = new territoryClass();
				_bitmapData = new PixelUtilBitmapData(bitmap.bitmapData);
				//_nameLabel.text = _territory.name;
				
				var position:Point = Territories.getTerritoryPosition(_territory.id);
				this.x = position.x;
				this.y = position.y;
				
				refreshWholeComponent();
			}
		}
		
		public function refreshWholeComponent():void {
			var ownerOfTerritory:PlayerWrapper = GameModel.instance.getPlayerByPlayerId(_territory.playerId);
			if (ownerOfTerritory != null) {
				var playerColor:uint = PlayerColors.getColor(ownerOfTerritory.color);
				var coloredBitmapData:BitmapData = _bitmapData.addColorOverlay(playerColor);
				_image.source = Texture.fromBitmapData(coloredBitmapData);
				_units.visible = true;
				_units.setColorAndUnits(playerColor, _territory.troopsOnIt);
				
				_units.x = Territories.getUnitsPosition(_territory.id).x;
				_units.y = Territories.getUnitsPosition(_territory.id).y;
				
				_battleDisplay.x = _units.x + _units.width + 10;
				_battleDisplay.y = _units.y;
			} else {
				_image.source = Texture.fromBitmapData(_bitmapData.bitmapData);
				_units.visible = false;
				_battleDisplay.hide();
			}
		}
		
		public function refreshNumberOfUnits():void {
			if (_territory.owner != null) {
				_units.setUnits(_territory.troopsOnIt);
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
			dispatchEvent(new ClickOnTerritory(ClickOnTerritory.CLICKED_ON_TERRITORY, _territory, true));
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