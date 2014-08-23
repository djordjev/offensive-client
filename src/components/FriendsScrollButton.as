package components {
	import components.common.ComponentWithStates;
	import components.common.StatesAdapter;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.core.TokenList;
	import flash.geom.Rectangle;
	import starling.filters.BlurFilter;
	import utils.Assets;
	import utils.Colors;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class FriendsScrollButton extends LayoutGroup implements ComponentWithStates {
		
		public static const DIRECTION_LEFT:int = -1;
		public static const DIRECTION_RIGHT:int = 1;
		
		private var _image:ImageLoader;
		private var _statesAdapter:StatesAdapter;
		private var _glow:BlurFilter;
		
		public function FriendsScrollButton() {
			super();
			_statesAdapter = new StatesAdapter(this);
			_glow = BlurFilter.createGlow(Colors.WHITE);
		}
		
		/* INTERFACE components.common.ComponentWithStates */
		
		public function changeToUp():void {
			_image.source = Assets.getScrollFriendsNormalImage();
			_image.filter = null;
		}
		
		public function changeToDown():void {
			_image.source = Assets.getScrollFriendsOverImage();
			_image.filter = null;
		}
		
		public function changeToHovered():void {
			_image.source = Assets.getScrollFriendsOverImage();
			_image.filter = _glow;
		}
		
		public function changeToDisabled():void {
		}
		
		public function set direction(value:int):void {
			this.scaleX = value;
		}
		
		override protected function initialize():void {
			super.initialize();
			
			_image = new ImageLoader();
			_image.source = Assets.getScrollFriendsNormalImage();
			this.addChild(_image);
		
		}
	
	}

}