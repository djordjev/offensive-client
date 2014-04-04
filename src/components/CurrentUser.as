package components {
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	import starling.display.Quad;
	import utils.FacebookCommunicator;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class CurrentUser extends LayoutGroup {
		
		private static const HEIGHT:int = 200;
		private static const WIDTH:int = 700;
		
		public var playerName:Label = new Label();
		public var userImage:ImageLoader = new ImageLoader();
		public var stats:Label = new Label();
		public var inviteToPrivateGame:Button = new Button();
		
		public function CurrentUser() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			var background:Quad = new Quad(WIDTH, HEIGHT, 0xFFFFFF);
			this.addChild(background);
			
			// create left group
			var userInfoGroup:LayoutGroup = new LayoutGroup();
			userInfoGroup.layout = new VerticalLayout();
			userInfoGroup.x = 15;
			userInfoGroup.y = 20;
			userInfoGroup.width = 245;
			userInfoGroup.height = 140;
			this.addChild(userInfoGroup);
			// populate left group
			userInfoGroup.addChild(playerName);
			
			// create user image in the middle
			userImage.x = 275;
			userImage.y = 10;
			this.addChild(userImage);
			
			// create right group
			var statsGroup:LayoutGroup = new LayoutGroup();
			statsGroup.layout = new VerticalLayout();
			statsGroup.x = 440;
			statsGroup.y = 20;
			statsGroup.width = 246;
			statsGroup.height = 140;
			this.addChild(statsGroup);
			// populate right group
			statsGroup.addChild(stats);
			
			// add invite button
			inviteToPrivateGame.x = 15;
			inviteToPrivateGame.width = 670;
			inviteToPrivateGame.y = 170;
			inviteToPrivateGame.height = 25;
			this.addChild(inviteToPrivateGame);
		}
	
	}

}