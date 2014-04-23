package modules.friends {
	import components.FriendsScrollButton;
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
	import starling.events.Event;
	import utils.Colors;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class FriendsView extends LayoutGroup {
		
		private static const BACKGROUND_ALPHA:Number = 0.3;
		
		public var friendsList:List = new List();
		public var rightScrollButton:FriendsScrollButton = new FriendsScrollButton();
		public var leftScrollButton:FriendsScrollButton = new FriendsScrollButton();
		
		public function FriendsView() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			// background color
			var background:Quad = new Quad(940, 100, Colors.WHITE);
			background.x = 41;
			background.alpha = BACKGROUND_ALPHA;
			this.addChild(background);
			// list
			friendsList.width = 630;
			friendsList.height = 100;
			friendsList.x = 185;
			var listLayout:HorizontalLayout = new HorizontalLayout();
			listLayout.gap = 16;
			friendsList.layout = listLayout;
			friendsList.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			friendsList.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			friendsList.itemRendererFactory = friendsListItemRendererFactoryFunction;
			
			// left scroll button
			leftScrollButton.x = 0;
			leftScrollButton.y = 60;
			leftScrollButton.direction = FriendsScrollButton.DIRECTION_LEFT;
			this.addChild(leftScrollButton);
			
			// right scroll button
			rightScrollButton.direction = FriendsScrollButton.DIRECTION_RIGHT;
			rightScrollButton.x = 934;
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