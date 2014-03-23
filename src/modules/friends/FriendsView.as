package modules.friends {
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.Scroller;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	import modules.friends.classes.FriendsRenderer;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class FriendsView extends LayoutGroup {
		
		public var friendsList:List = new List();
		public var rightScrollButton:Button = new Button();
		public var leftScrollButton:Button = new Button();
		
		public function FriendsView() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			// background color
			var background:Quad = new Quad(1024, 150, 0x000000);
			this.addChild(background);
			// list
			friendsList.width = 924;
			friendsList.height = 130;
			friendsList.x = 50;
			friendsList.y = 10;
			var listLayout:HorizontalLayout = new HorizontalLayout();
			listLayout.gap = 10;
			friendsList.layout = listLayout;
			friendsList.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			friendsList.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			friendsList.itemRendererFactory = friendsListItemRendererFactoryFunction;
			
			// left scroll button
			leftScrollButton.width = 30;
			leftScrollButton.height = 30;
			leftScrollButton.label = "<";
			leftScrollButton.x = 10;
			leftScrollButton.y = 60;
			this.addChild(leftScrollButton);
			
			// right scroll button
			rightScrollButton.width = 30;
			rightScrollButton.height = 30;
			rightScrollButton.label = ">";
			rightScrollButton.x = 984;
			rightScrollButton.y = 60;
			this.addChild(rightScrollButton);
			
			this.addChild(friendsList);
		}
		
		private function friendsListItemRendererFactoryFunction():IListItemRenderer {
			var renderer:FriendsRenderer = new FriendsRenderer();
			return renderer;
		}
	}

}