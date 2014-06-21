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
		private static const FONT_SIZE:int = 30;
		
		private var _labelForDisplay:OLabel = new OLabel();
		private var _blurFilter:BlurFilter; 
		private var _statesAdapter:StatesAdapter;
		
		private var _fontSize:int = FONT_SIZE;
		private var _fontColor:uint = Colors.BLACK;
		
		public function LinkButton() {
			super();
			_statesAdapter = new StatesAdapter(this);
			this.useHandCursor = true;
			_blurFilter = BlurFilter.createGlow(Colors.WHITE);
		}
		
		/* INTERFACE components.common.ComponentWithStates */
		
		public function changeToUp():void {
			_labelForDisplay.fontColor = _fontColor;
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
			_fontSize = value;
			_labelForDisplay.fontSize = value;
			this.invalidate();
		}
		
		public function set fontColor(value:uint):void {
			_fontColor = value;
			_labelForDisplay.fontColor = value;
			this.invalidate();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			_labelForDisplay.font = OLabel.FONT_GEARS_OF_PACE;
			_labelForDisplay.fontColor = _fontColor;
			_labelForDisplay.fontSize = _fontSize;
			this.addChild(_labelForDisplay);
		}
		
	}

}