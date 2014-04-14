package utils 
{
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	import flash.external.ExternalInterface;
	import starling.events.Event;
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class Alert 
	{
		
		private static var brokenConnectionGroup:LayoutGroup;
		
		public static function showConnectionBrokenAlert():void {
			if (brokenConnectionGroup == null) {
				brokenConnectionGroup = new LayoutGroup();
				brokenConnectionGroup.layout = new VerticalLayout();
				
				var message:Label = new Label();
				message.text = "Connection with server is lost. Please refresh and try again";
				brokenConnectionGroup.addChild(message);
				
				var refreshButton:Button = new Button();
				refreshButton.label = "Refresh page";
				refreshButton.addEventListener(Event.TRIGGERED, function refreshPage(e:Event):void {
					ExternalInterface.call("document.location.reload", true);
				});
				brokenConnectionGroup.addChild(refreshButton);
			}
			
			Callout.show(brokenConnectionGroup, Globals.instance.game);
		}
		
	}

}