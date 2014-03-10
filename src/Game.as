package
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.themes.MetalWorksMobileTheme;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.Globals;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private var label:Label = new Label();
		
		private function addedToStage(e:Event):void {
			trace("LOADED");
			// initialize theme
			new MetalWorksMobileTheme();
			
			var paramList:Object = Globals.instance.parameters;
			var userId:String = paramList.userId;
			var facebookId:String = paramList.facebookId;
			
			var message:String;
			if (userId != null && userId != "") {
				message = "Welcome player with user id = " + userId;
				if (facebookId != null && facebookId != "") {
					message += " and facebook id = " + facebookId;
				}
			} else {
				message = "No user id";
			}
			
			label.visible = false;
			label.text = message;
			
			label.x = 300;
			label.y = 300;
			
			this.addChild(label);
			
			var button:Button = new Button();
			button.addEventListener(Event.TRIGGERED, buttonClickHandler);
			button.x = 600;
			button.y = 600;
			button.label = "Show Label";
			
			this.addChild(button);
		}
		
		private function buttonClickHandler(e:Event):void {
			label.visible = !label.visible;
		}
	}
}