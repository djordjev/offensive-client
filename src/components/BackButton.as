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
	public class BackButton extends LayoutGroup implements ComponentWithStates {
		
		private var _statesAdapter:StatesAdapter;
		private var _image:ImageLoader = new ImageLoader();
		private var _glow:BlurFilter;
		
		public function BackButton() {
			super();
			_statesAdapter = new StatesAdapter(this);
			_glow = BlurFilter.createGlow(Colors.BLACK);
			useHandCursor = true;
		}
		
		/* INTERFACE components.common.ComponentWithStates */
		
		public function changeToUp():void {
			_image.source = Assets.getBackNormal();
			_image.filter = null;
		}
		
		public function changeToDown():void {
			_image.source = Assets.getBackOver();
			_image.filter = null;
		}
		
		public function changeToHovered():void {
			_image.source = Assets.getBackOver();
			_image.filter = _glow;
		}
		
		override protected function initialize():void {
			super.initialize();
			_image.source = Assets.getBackNormal();
			this.addChild(_image);
		}
		
		public function changeToDisabled():void {
		}
	
	}

}