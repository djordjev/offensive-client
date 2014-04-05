package modules.friends.classes 
{
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import starling.display.Quad;
	import wrappers.UserWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class FriendsRenderer extends LayoutGroupListItemRenderer 
	{
		private var _label:Label = new Label();
		private var _image:ImageLoader = new ImageLoader();
		private var _background:Quad = new Quad(120, 130, 0xFFFFFF);
		
		public function FriendsRenderer() 
		{
			super();
			this.useHandCursor = true;
		}
		
		private function get dataAsUserWrapper():UserWrapper {
			if (_data is UserWrapper) {
				return _data as UserWrapper;
			} else {
				return null;
			}
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			this.width = 120;
			this.height = 130;
			
			this.addChild(_background);
			
			//_image.source = "http://images.artistdirect.com/Images/artd/amg/music/cover/6106612_imperial_blaze_50.jpg";
			_image.y = 20;
			_image.x = 40;
			this.addChild(_image);
			
			_label.y = 90;
			_label.width = 120;
			_label.textRendererFactory = function ():ITextRenderer {
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat();
				textRenderer.textFormat.align = TextFormatAlign.CENTER;
				return textRenderer;
			}
			this.addChild(_label);
		}
		
		override protected function commitData():void 
		{
			if (this.dataAsUserWrapper != null) {
				_label.text = this.dataAsUserWrapper.name;
			} else {
				_label.text = "DATA IS NULL";
			}
			super.commitData();
		}
		
	}

}