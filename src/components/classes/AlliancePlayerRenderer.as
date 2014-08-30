package components.classes {
	import feathers.controls.ImageLoader;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import starling.display.Quad;
	import wrappers.PlayerWrapper;
	
	/**
	 * ...
	 * @author Djordje
	 */
	public class AlliancePlayerRenderer extends LayoutGroupListItemRenderer implements ComponentWithStates {
		
		private var _background:Quad;
		private var _image:ImageLoader = new ImageLoader();
		private var _dirty:Boolean = true;
		
		public function AlliancePlayerRenderer() {
			super();
		}
		
		override public function set data(value:Object):void {
			super.data = value;
			_dirty = true;
		}
		
		public function get dataAsPlayerWrapper():PlayerWrapper {
			return _data as PlayerWrapper;
		}
	
	}

}