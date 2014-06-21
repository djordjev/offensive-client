package utils {
	import components.common.OLabel;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.core.FeathersControl;
	import feathers.core.PopUpManager;
	import feathers.layout.VerticalLayout;
	import flash.external.ExternalInterface;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class Alert {
		
		private static const NOTIFICATION_WIDTH:uint = 300;
		
		private static var brokenConnectionGroup:LayoutGroup;
		
		public static function showConnectionBrokenAlert():void {
			if (brokenConnectionGroup == null) {
				brokenConnectionGroup = new LayoutGroup();
				
				var background:Quad = new Quad(450, 100, 0x000000);
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
		
		private static var _notificationGroup:LayoutGroup;
		
		public static function showMessage(title:String, note:String):void {
			var background:Quad;
			var titleLabel:OLabel;
			var noteLabel:OLabel;
			var okButton:Button;
			if (_notificationGroup == null) {
				_notificationGroup = new LayoutGroup();
				background = new Quad(NOTIFICATION_WIDTH, 10, Colors.RED);
				background.color = Colors.BLACK;
				background.alpha = 0.4;
				_notificationGroup.addChild(background);
				
				titleLabel = new OLabel();
				titleLabel.fontSize = 14;
				titleLabel.x = 3;
				titleLabel.y = 3;
				_notificationGroup.addChild(titleLabel);
				
				noteLabel= new OLabel();
				noteLabel.fontSize = 14;
				noteLabel.y = 20;
				noteLabel.x = 20;
				noteLabel.maxWidth = 280;
				noteLabel.textRendererProperties.wordWrap = true;
				_notificationGroup.addChild(noteLabel);
				
				okButton = new Button();
				okButton.addEventListener(Event.TRIGGERED, function closePopup(e:Event):void {
					PopUpManager.removePopUp(_notificationGroup);
				});
				okButton.label = "OK";
				_notificationGroup.addChild(okButton);
			} else {
				background = _notificationGroup.getChildAt(0) as Quad;
				titleLabel = _notificationGroup.getChildAt(1) as OLabel;
				noteLabel = _notificationGroup.getChildAt(2) as OLabel;
				okButton = _notificationGroup.getChildAt(3) as Button;
			}
			titleLabel.text = title;
			noteLabel.text = note;
			
			PopUpManager.addPopUp(_notificationGroup);
			_notificationGroup.validate();
			background.height = noteLabel.y + noteLabel.height + 30;
			okButton.y = background.height - 30;
			okButton.x = _notificationGroup.width / 2 - okButton.width / 2;
		}
	
	}

}