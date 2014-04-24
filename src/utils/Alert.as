package utils 
{
	import components.common.OLabel;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.core.PopUpManager;
	import feathers.layout.VerticalLayout;
	import flash.external.ExternalInterface;
	import starling.display.Quad;
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
				
				var background:Quad = new Quad(450, 100,0x000000 );
				brokenConnectionGroup.addChild(background);
				
				var componentsGroup:LayoutGroup = new LayoutGroup();
				componentsGroup.layout = new VerticalLayout();
				(componentsGroup.layout as VerticalLayout).horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
				(componentsGroup.layout as VerticalLayout).gap = 30;
				componentsGroup.x = 33;
				componentsGroup.y = 10;
				
				var message:OLabel = new OLabel();
				message.fontColor = 0x0080FF;
				message.fontSize = 15;
				message.text = "Connection with server is lost. Please refresh and try again";
				componentsGroup.addChild(message);
				
				var refreshButton:Button = new Button();
				refreshButton.label = "Refresh page";
				refreshButton.addEventListener(Event.TRIGGERED, function refreshPage(e:Event):void {
					ExternalInterface.call("document.location.reload", true);
				});
				componentsGroup.addChild(refreshButton);
				brokenConnectionGroup.addChild(componentsGroup);
			}
			
			PopUpManager.addPopUp(brokenConnectionGroup);
		}
		
	}

}