package components.classes {
	import communication.protos.GameDescription;
	import components.common.ComponentWithStates;
	import components.common.OLabel;
	import components.common.StatesAdapter;
	import components.events.MouseClickEvent;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import utils.Colors;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class JoinableGamesRenderer extends LayoutGroupListItemRenderer implements ComponentWithStates {
		
		private static const WIDTH:int = 400;
		private static const HEIGHT:int = 30;
		
		private var _dirty:Boolean = true;
		private var _statesAdapter:StatesAdapter;
		private var _glow:BlurFilter;
		private var _background:Quad = new Quad(WIDTH, HEIGHT, Colors.WHITE);
		private var _label:OLabel = new OLabel();
		
		public function JoinableGamesRenderer() {
			_statesAdapter = new StatesAdapter(this);
			_glow = BlurFilter.createGlow(Colors.WHITE);
			this.addEventListener(MouseClickEvent.CLICK, clickHandler);
			this.useHandCursor = true;
		}
		
		public function changeToUp():void {
			if (isSelected) {
				_background.visible = true;
			} else {
				_background.visible = false;
			}
			_label.fontColor = Colors.BLACK;
			this.filter = null;
		}
		
		public function changeToDown():void {
			if (isSelected) {
				_background.visible = true;
				_label.fontColor = Colors.BLACK;
			} else {
				_background.visible = false;
				_label.fontColor = Colors.WHITE;
				
			}
			this.filter = null;
		}
		
		public function changeToHovered():void {
			if (isSelected) {
				_background.visible = true;
				_label.fontColor = Colors.BLACK;
			} else {
				_background.visible = false;
				_label.fontColor = Colors.WHITE;
			}
			this.filter = _glow;
		}
		
		override protected function initialize():void {
			super.initialize();
			
			_background.visible = false;
			this.addChild(_background);
			
			_label.font = OLabel.FONT_GEARS_OF_PACE;
			_label.fontSize = 17;
			_label.fontColor = Colors.BLACK;
			this.addChild(_label);
		}
		
		private function get dataAsGameDescription():GameDescription {
			return _data as GameDescription;
		}
		
		override public function set data(value:Object):void {
			super.data = value;
			_dirty = true;
		}
		
		override protected function commitData():void {
			if (_dirty) {
				_label.text = dataAsGameDescription.gameName + " " + dataAsGameDescription.numberOfJoinedPlayers + "/" + dataAsGameDescription.numberOfPlayers;
				_dirty = false;
			}
			super.commitData();
		}
		
		override protected function draw():void {
			super.draw();
			_background.visible = isSelected;
		}
		
		private function clickHandler(e:MouseClickEvent):void {
			this.isSelected = true;
		}
	
	}

}