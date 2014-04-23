package components {
	import components.common.ComponentWithStates;
	import components.common.OLabel;
	import components.common.StatesAdapter;
	import feathers.controls.LayoutGroup;
	import feathers.core.TokenList;
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	import mx.utils.StringUtil;
	import starling.display.Quad;
	import starling.filters.BlurFilter;
	import utils.Colors;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class InvitesButton extends LayoutGroup implements ComponentWithStates {
		
		private static const WIDTH:int = 500;
		private static const HEIGHT:int = 25;
		private static const ALPHA:Number = 0.6;
		
		private static const BUTTON_LABEL:String = "YOU HAVE {0} INVITES TO PRIVATE GAMES";
		
		private var _background:Quad = new Quad(WIDTH, HEIGHT, Colors.WHITE);
		private var _glow:BlurFilter;
		private var _label:OLabel = new OLabel();
		private var _statesAdapter:StatesAdapter;
		
		public function InvitesButton() {
			super();
			_glow = BlurFilter.createGlow(Colors.WHITE);
			_statesAdapter = new StatesAdapter(this);
			useHandCursor = true;
		}
		
		/* INTERFACE components.common.ComponentWithStates */
		
		public function changeToUp():void {
			_background.filter = null;
			_label.fontColor = Colors.BLACK;
		}
		
		public function changeToDown():void {
			_background.filter = null;
			_label.fontColor = Colors.WHITE;
		}
		
		public function changeToHovered():void {
			_background.filter = _glow;
			_label.fontColor = Colors.BLACK;
		}
		
		public function set numberOfInvitations(value:int):void {
			if (value > 0) {
				this.visible = true;
				_label.text = StringUtil.substitute(BUTTON_LABEL, value.toString());
			} else {
				this.visible = false;
			}
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_background.alpha = ALPHA;
			this.addChild(_background);
			
			_label.width = WIDTH;
			_label.font = OLabel.FONT_GEARS_OF_PACE;
			_label.fontColor = Colors.BLACK;
			_label.fontSize = 15;
			_label.textAlign = TextFormatAlign.CENTER;
			_label.y = 2;
			this.addChild(_label);
			
		}
	
	}

}