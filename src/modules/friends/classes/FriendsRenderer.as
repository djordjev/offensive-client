package modules.friends.classes {
	import components.common.OLabel;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import starling.display.Quad;
	import utils.Colors;
	import wrappers.UserWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class FriendsRenderer extends LayoutGroupListItemRenderer {
		
		private static const WIDTH:int = 100;
		private static const HEIGHT:int = 100;
		
		private var _dirty:Boolean = true;
		
		private var _label:OLabel = new OLabel();
		private var _image:ImageLoader = new ImageLoader();
		
		public function FriendsRenderer() {
			super();
		}
		
		private function get dataAsUserWrapper():UserWrapper {
			if (_data is UserWrapper) {
				return _data as UserWrapper;
			} else {
				return null;
			}
		}
		
		override protected function initialize():void {
			super.initialize();
			this.width = WIDTH;
			this.height = HEIGHT;
			
			_image.y = 10;
			_image.x = 25;
			this.addChild(_image);
			
			_label.y = 80;
			_label.width = WIDTH;
			_label.maxWidth = WIDTH;
			_label.textAlign = TextFormatAlign.CENTER;
			_label.font = OLabel.FONT_GEARS_OF_PACE;
			_label.fontSize = 12;
			_label.fontColor = Colors.BLACK;
			this.addChild(_label);
		}
		
		override protected function commitData():void {
			if (_dirty && this.dataAsUserWrapper != null) {
				if (this.dataAsUserWrapper.facebookUser != null) {
					_label.text = this.dataAsUserWrapper.facebookUser.name.toLowerCase();
					_image.source = this.dataAsUserWrapper.facebookUser.smallImageURL;
				}
			}
			super.commitData();
		}
	
	}

}