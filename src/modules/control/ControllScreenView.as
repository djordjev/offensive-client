package modules.control {
	import feathers.controls.LayoutGroup;
	import modules.friends.FriendsView;
	import modules.main.MainControlsView;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ControllScreenView extends LayoutGroup {
				
		public var friendsView:FriendsView = new FriendsView();
		public var mainControlsView:MainControlsView = new MainControlsView();
		
		public function ControllScreenView() {
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			// add MainControlls
			this.addChild(mainControlsView);
			
			// add friends view
			friendsView.y = 605;
			
			this.addChild(friendsView);
		}
	
	}

}