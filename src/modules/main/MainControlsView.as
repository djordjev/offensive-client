package modules.main 
{
	import components.CurrentUser;
	import components.GameActionsDialog;
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import flash.external.ExternalInterface;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import utils.Assets;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class MainControlsView extends LayoutGroup 
	{
		
		public var currentUserInfoDisplay:CurrentUser = new CurrentUser();
		public var gameActionsDialog:GameActionsDialog = new GameActionsDialog();
		
		public function MainControlsView() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			this.width = 1024;
			this.height = 618;
			
			var texture:Texture = Texture.fromBitmap(new Assets.MainControlsBackground());
			var image:Image = new Image(texture);
			this.addChild(image);
			
			currentUserInfoDisplay.x = 162;
			currentUserInfoDisplay.y = 20;
			this.addChild(currentUserInfoDisplay);
			
			gameActionsDialog.x = 92;
			gameActionsDialog.y = 230;
			this.addChild(gameActionsDialog);
		
			
		}
		
	}

}