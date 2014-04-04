package modules.control {
	import feathers.controls.LayoutGroup;
	import modules.friends.FriendsView;
	import modules.main.MainControlsView;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ControllScreenView extends LayoutGroup {
				
		public var friendsView:FriendsView;
		public var mainControlsView:MainControlsView;
		
		public function ControllScreenView() {
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			// add MainControlls
			mainControlsView = new MainControlsView();
			this.addChild(mainControlsView);
			
			// add friends view
			friendsView = new FriendsView();
			friendsView.y = 618;
			
			this.addChild(friendsView);
		}
	
	}

}