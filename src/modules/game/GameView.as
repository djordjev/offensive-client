package modules.game 
{
	import components.common.OLabel;
	import components.common.OLabel;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import starling.display.Quad;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameView extends LayoutGroup 
	{
		public static const GO_BACK:String = "go back";
		
		private var backgroundSprite:Quad;
		
		public function GameView() 
		{
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			backgroundSprite = new Quad(1024, 768, 0xC0C0C0);
			this.addChild(backgroundSprite);
			
			var label:OLabel = new OLabel();
			label.fontColor = 0x3344DC;
			label.text = "Ovde dodje mapa";
			label.x = 400;
			label.y = 400;
			this.addChild(label);
			
			var button:Button = new Button();
			button.label = "Go Back";
			button.x = 500;
			button.y = 500;
			button.addEventListener(Event.TRIGGERED, goBack);
			
			this.addChild(button);
			
		}
		
		private function goBack(e:Event):void {
			dispatchEvent(new Event(GO_BACK, true));
		}
		
	}

}