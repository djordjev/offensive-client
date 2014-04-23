package components.common {
	import components.events.MouseClickEvent;
	import feathers.controls.LayoutGroup;
	import feathers.core.TokenList;
	import flash.geom.Rectangle;
	import starling.filters.BlurFilter;
	import utils.Colors;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class LinkButton extends LayoutGroup implements ComponentWithStates {
		
		private static const NORMAL_FONT_COLOR:uint = 0x191919;
		private static const OVER_DOWN_FONT_COLOR:uint = 0xFFFFFF;
		private static const FONT_SIZE:int = 40;
		
		private var _labelForDisplay:OLabel = new OLabel();
		private var _blurFilter:BlurFilter; 
		private var _statesAdapter:StatesAdapter;
		
		public function LinkButton() {
			super();
			_statesAdapter = new StatesAdapter(this);
			this.useHandCursor = true;
			_blurFilter = BlurFilter.createGlow(Colors.WHITE);
		}
		
		/* INTERFACE components.common.ComponentWithStates */
		
		public function changeToUp():void {
			_labelForDisplay.fontColor = NORMAL_FONT_COLOR;
			_labelForDisplay.filter = null;
		}
		
		public function changeToDown():void {
			_labelForDisplay.fontColor = OVER_DOWN_FONT_COLOR;
			_labelForDisplay.filter = null;
		}
		
		public function changeToHovered():void {
			_labelForDisplay.fontColor = OVER_DOWN_FONT_COLOR;
			_labelForDisplay.filter = _blurFilter;
		}
		
		public function set label(text:String):void {
			_labelForDisplay.text = text;
		}
		
		public function set fontSize(value:int):void {
			_labelForDisplay.fontSize = value;
		}
		
		override protected function initialize():void {
			super.initialize();
			
			_labelForDisplay.font = OLabel.FONT_GEARS_OF_PACE;
			_labelForDisplay.fontColor = NORMAL_FONT_COLOR;
			_labelForDisplay.fontSize = FONT_SIZE;
			this.addChild(_labelForDisplay);
		}
		
	}

}