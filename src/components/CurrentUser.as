package components {
	import components.common.OLabel;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	import utils.Colors;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class CurrentUser extends LayoutGroup {
		
		private static const USER_INFO_FONT_SIZE:int = 15;
		
		private static const HEIGHT:int = 200;
		private static const WIDTH:int = 700;
		
		public var playerName:OLabel = new OLabel();
		public var playerLocation:OLabel = new OLabel();
		public var playerJoined:OLabel = new OLabel();
		
		public var userImage:CurrentPlayerImage = new CurrentPlayerImage();
		public var stats:OLabel = new OLabel();
		public var inviteToPrivateGame:InvitesButton = new InvitesButton();
		
		public function CurrentUser() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			// create left group
			var userInfoGroup:LayoutGroup = new LayoutGroup();
			userInfoGroup.layout = new VerticalLayout();
			userInfoGroup.x = 15;
			userInfoGroup.y = 85;
			userInfoGroup.width = 245;
			userInfoGroup.height = 140;
			this.addChild(userInfoGroup);
			// populate left group
			
			// add player name label
			playerName.font = OLabel.FONT_GEARS_OF_PACE;
			playerName.fontColor = Colors.WHITE;
			playerName.fontSize = USER_INFO_FONT_SIZE;
			userInfoGroup.addChild(playerName);
			
			// add player location label
			playerLocation.font = OLabel.FONT_GEARS_OF_PACE;
			playerLocation.fontColor = Colors.WHITE;
			playerLocation.fontSize = USER_INFO_FONT_SIZE;
			userInfoGroup.addChild(playerLocation);
			
			// add player joined label
			playerJoined.font = OLabel.FONT_GEARS_OF_PACE;
			playerJoined.fontColor = Colors.WHITE;
			playerJoined.fontSize = USER_INFO_FONT_SIZE;
			userInfoGroup.addChild(playerJoined);
			
			
			// create user image in the middle
			userImage.x = 275;
			this.addChild(userImage);
			
			// create right group
			var statsGroup:LayoutGroup = new LayoutGroup();
			statsGroup.layout = new VerticalLayout();
			statsGroup.x = 450;
			statsGroup.y = 85;
			statsGroup.width = 246;
			statsGroup.height = 140;
			this.addChild(statsGroup);
			// populate right group
			
			// populate stats label
			stats.font = OLabel.FONT_GEARS_OF_PACE;
			stats.fontSize = USER_INFO_FONT_SIZE;
			stats.fontColor = Colors.WHITE;
			statsGroup.addChild(stats);
			
			// add invite button
			inviteToPrivateGame.x = 120;
			inviteToPrivateGame.width = 670;
			inviteToPrivateGame.y = 170;
			inviteToPrivateGame.height = 25;
			this.addChild(inviteToPrivateGame);
		}
	
	}

}