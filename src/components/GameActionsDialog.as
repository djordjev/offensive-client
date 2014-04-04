package components {
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.layout.VerticalLayout;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameActionsDialog extends LayoutGroup {
		
		public var existingGamesList:List = new List();
		
		public function GameActionsDialog() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			this.width = 840;
			this.height = 416;
			// background
			var background:Quad = new Quad(840, 350, 0x78787A);
			this.addChild(background);
			
			existingGamesList.x = 780;
			existingGamesList.y = 40;
			existingGamesList.width = 240;
			existingGamesList.height = 350;
			
			var listLayout:VerticalLayout = new VerticalLayout();
			listLayout.gap = 10;
			existingGamesList.layout = listLayout;
		
		}
	
	}

}