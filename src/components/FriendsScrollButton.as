package components {
	import components.common.ComponentWithStates;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.core.TokenList;
	import flash.geom.Rectangle;
	import utils.Assets;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class FriendsScrollButton extends LayoutGroup implements ComponentWithStates {
		
		public static const DIRECTION_LEFT:int = -1;
		public static const DIRECTION_RIGHT:int = 1;
		
		private var _image:ImageLoader;
		
		public function FriendsScrollButton() {
			super();
		}
		
		/* INTERFACE components.common.ComponentWithStates */
		
		public function changeToUp():void {
			_image.source = Assets.getScrollFriendsNormalImage();
		}
		
		public function changeToDown():void {
			_image.source = Assets.getScrollFriendsDownImage();
		}
		
		public function changeToHovered():void {
			_image.source = Assets.getScrollFriendsOverImage();
		}
		
		public function set direction(value:int):void {
			this.scaleX = value;
		}
		
		override protected function initialize():void {
			super.initialize();
			
			_image = new ImageLoader();
			_image.source = Assets.getScrollFriendsNormalImage();
		
		}
	
	}

}