package components {
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.layout.VerticalLayout;
	import starling.display.Quad;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameActionsDialog extends LayoutGroup {
		
		public static const CREATE_OPEN_GAME:String = "create open game";
		public static const CREATE_PRIVATE_GAME:String = "create private game";
		public static const JOIN_GAME:String = "join game";
		
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
			
			// create games group
			var gamesManipulationGroup:LayoutGroup = new LayoutGroup();
			var gamesManipulationLayout:VerticalLayout = new VerticalLayout();
			gamesManipulationLayout.gap = 20;
			gamesManipulationGroup.layout = gamesManipulationLayout;
			gamesManipulationGroup.x = 30;
			gamesManipulationGroup.y = 30;
			this.addChild(gamesManipulationGroup);
			
			var createOpenGameButton:Button = new Button();
			createOpenGameButton.width = 300;
			createOpenGameButton.height = 80;
			createOpenGameButton.label = "Create open game";
			createOpenGameButton.addEventListener(Event.TRIGGERED, createOpenGame);
			gamesManipulationGroup.addChild(createOpenGameButton);
			
			var createPrivateGameButton:Button = new Button();
			createPrivateGameButton.width = 300;
			createPrivateGameButton.height = 80;
			createPrivateGameButton.label = "Create private game";
			createPrivateGameButton.addEventListener(Event.TRIGGERED, createPrivateGame);
			gamesManipulationGroup.addChild(createPrivateGameButton);
			
			var joinGameButton:Button = new Button();
			joinGameButton.width = 300;
			joinGameButton.height = 80;
			joinGameButton.label = "Join game";
			joinGameButton.addEventListener(Event.TRIGGERED, joinGame);
			gamesManipulationGroup.addChild(joinGameButton);
		}
		
		private function createOpenGame(event:Event):void {
			trace("CREATE OPEN GAME");
			dispatchEvent(new Event(CREATE_OPEN_GAME));
		}
		
		private function createPrivateGame(event:Event):void {
			trace("CREATE PRIVATE GAME");
			dispatchEvent(new Event(CREATE_PRIVATE_GAME));
		}
		
		private function joinGame(event:Event):void {
			trace("JOIN GAME");
			dispatchEvent(new Event(JOIN_GAME));
		}
	
	}

}