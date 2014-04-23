package components {
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import starling.display.Image;
	import utils.Assets;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class CurrentPlayerImage extends LayoutGroup {
		
		public var pictureFrame:Image;
		public var userImage:ImageLoader = new ImageLoader();
		
		public function CurrentPlayerImage() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			userImage.x = 5;
			userImage.y = 5;
			this.addChild(userImage);
			
			pictureFrame = new Image(Assets.getProfileImageFrame());
			this.addChild(pictureFrame);
		
		}
		
		public function set userImageSource(url:String):void {
			userImage.source = url;
		}
	
	}

}