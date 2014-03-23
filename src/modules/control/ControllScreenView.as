package modules.control {
	import feathers.controls.LayoutGroup;
	import modules.friends.FriendsView;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ControllScreenView extends LayoutGroup {
				
		public var friendsView:FriendsView;
		
		public function ControllScreenView() {
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			// add MainControlls
			// add friends view
			friendsView = new FriendsView();
			friendsView.y = 618;
			
			this.addChild(friendsView);
		}
	
	}

}