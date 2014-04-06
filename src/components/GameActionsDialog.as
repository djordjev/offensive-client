package components {
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.NumericStepper;
	import feathers.controls.Radio;
	import feathers.controls.TextInput;
	import feathers.core.ToggleGroup;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import modules.main.MainControlsModel;
	import starling.display.Quad;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameActionsDialog extends LayoutGroup {
		
		public static const STATE_MENU:String = "state menu";
		public static const STATE_OPEN_GAME:String = "open game";
		public static const STATE_PRIVATE_GAME:String = "private game";
		public static const STATE_JOIN_GAME:String = "join game";
		
	/*	public static const CREATE_OPEN_GAME:String = "create open game";
		public static const CREATE_PRIVATE_GAME:String = "create private game";
		public static const JOIN_GAME:String = "join game";*/
		
		public static const CREATED_OPEN_GAME:String = "created open game";
		public static const CREATED_PRIVATE_GAME:String = "created private game";
		public static const JOINED_GAME:String = "joined game";
		
		public var existingGamesList:List = new List();
		
		private var _gamesManipulationGroup:LayoutGroup = new LayoutGroup();
		
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
		
		private function populateForMenu():void {
			initializeLeftGroup();
			
			var createOpenGameButton:Button = new Button();
			createOpenGameButton.width = 300;
			createOpenGameButton.height = 80;
			createOpenGameButton.label = "Create open game";
			createOpenGameButton.addEventListener(Event.TRIGGERED, createOpenGame);
			_gamesManipulationGroup.addChild(createOpenGameButton);
			
			var createPrivateGameButton:Button = new Button();
			createPrivateGameButton.width = 300;
			createPrivateGameButton.height = 80;
			createPrivateGameButton.label = "Create private game";
			createPrivateGameButton.addEventListener(Event.TRIGGERED, createPrivateGame);
			_gamesManipulationGroup.addChild(createPrivateGameButton);
			
			var joinGameButton:Button = new Button();
			joinGameButton.width = 300;
			joinGameButton.height = 80;
			joinGameButton.label = "Join game";
			joinGameButton.addEventListener(Event.TRIGGERED, joinGame);
			_gamesManipulationGroup.addChild(joinGameButton);
		}
		
		private function populateForOpenGame():void {
			initializeLeftGroup();
			addHeader("Add open game");
			
			addComponentsForNewGame();
			var createOpenGameButton:Button = new Button();
			createOpenGameButton.label = "Create New Open Game";
			createOpenGameButton.height = 50;
			createOpenGameButton.width = 200;
			createOpenGameButton.addEventListener(Event.TRIGGERED, function createdOpenGame():void {
				dispatchEvent(new Event(CREATED_OPEN_GAME, true));
			});
			_gamesManipulationGroup.addChild(createOpenGameButton);
		}
		
		private function populateForPrivateGame():void {
			initializeLeftGroup();
			addHeader("Create private game");
			
			addComponentsForNewGame();
			
			var inviteButton:Button = new Button();
			inviteButton.label = "Invite friends";
			inviteButton.height = 50;
			inviteButton.width = 200;
			_gamesManipulationGroup.addChild(inviteButton);
			
			var createPrivateGameButton:Button = new Button();
			createPrivateGameButton.label = "Create New Private Game";
			createPrivateGameButton.height = 50;
			createPrivateGameButton.width = 200;
			createPrivateGameButton.addEventListener(Event.TRIGGERED, function createdOpenGame():void {
				dispatchEvent(new Event(CREATED_PRIVATE_GAME, true));
			});
			_gamesManipulationGroup.addChild(createPrivateGameButton);
		}
		
		private function populateForJoinGame():void {
			initializeLeftGroup();
			addHeader("Join game");
			
			var gamesList:List = new List();
			gamesList.height = 220;
			gamesList.width = 200;
			gamesList.itemRendererProperties.labelField = "gameInfo";
			_gamesManipulationGroup.addChild(gamesList);
			
			var joinButton:Button = new Button();
			joinButton.label = "Join";
			joinButton.addEventListener(Event.TRIGGERED, function joiedButtonClicked(Event):void {
				dispatchEvent(new Event(JOINED_GAME, true));
			});
			_gamesManipulationGroup.addChild(joinButton);
			
			// populate list
			MainControlsModel.instance.requestJoinableGames(function joinableGamesLoadingFInished():void {
				gamesList.dataProvider = new ListCollection([{gameInfo:"First game info / 1"}, {gameInfo: "Second game info / 2"}, {gameInfo: "Third game info / 3"}]);
			});
			
		}
		
		private function addHeader(actionName:String):void {
			var actionsNameGroup:LayoutGroup = new LayoutGroup();
			actionsNameGroup.layout = new HorizontalLayout();
			
			var nameForActions:Label = new Label();
			nameForActions.text  = actionName;
			var back:Button = new Button();
			back.label = "Back";
			back.addEventListener(Event.TRIGGERED, function goBack(e:Event):void {
				state = STATE_MENU;
			});
			actionsNameGroup.addChild(nameForActions);
			actionsNameGroup.addChild(back);
			_gamesManipulationGroup.addChild(actionsNameGroup);
		}
		
		private function initializeLeftGroup():void {
			_gamesManipulationGroup.removeChildren();
			var gamesManipulationLayout:VerticalLayout = new VerticalLayout();
			gamesManipulationLayout.gap = 20;
			_gamesManipulationGroup.layout = gamesManipulationLayout;
			_gamesManipulationGroup.x = 30;
			_gamesManipulationGroup.y = 30;
			this.addChild(_gamesManipulationGroup);
		}
		
		private function addComponentsForNewGame():void {
			var gameNameGroup:LayoutGroup = new LayoutGroup();
			gameNameGroup.layout = new HorizontalLayout();
			(gameNameGroup.layout as HorizontalLayout).gap = 20;
			
			var gameNameLabel:Label = new Label();
			gameNameLabel.text = "Game Name";
			gameNameGroup.addChild(gameNameLabel);
			
			var gameNameInput:TextInput = new TextInput();
			gameNameInput.width = 250;
			gameNameInput.clearFocus();
			gameNameInput.setFocus();
			gameNameInput.showFocus();
			gameNameGroup.addChild(gameNameInput);
			
			_gamesManipulationGroup.addChild(gameNameGroup);
			
			var numberOfPlayersGroup:LayoutGroup = new LayoutGroup();
			numberOfPlayersGroup.layout = new HorizontalLayout();
			(numberOfPlayersGroup.layout as HorizontalLayout).gap = 20;
			
			var numberOfPlayersLabel:Label = new Label();
			numberOfPlayersLabel.text = "Number of players";
			numberOfPlayersGroup.addChild(numberOfPlayersLabel);
			
			var numberOfPlayersInput:NumericStepper = new NumericStepper();
			numberOfPlayersInput.minimum = 3;
			numberOfPlayersInput.maximum = 6;
			numberOfPlayersInput.value = 5;
			numberOfPlayersInput.step = 1;
			numberOfPlayersGroup.addChild(numberOfPlayersInput);
			
			_gamesManipulationGroup.addChild(numberOfPlayersGroup);
			
			var gameTypeGroup:LayoutGroup = new LayoutGroup();
			gameTypeGroup.layout = new HorizontalLayout();
			(gameTypeGroup.layout as HorizontalLayout).gap = 20;
			
			var gameTypeToggleGroup:ToggleGroup = new ToggleGroup();
			gameTypeToggleGroup.isSelectionRequired = true;
			
			var worldDomination:Radio = new Radio();
			worldDomination.label = "World domination";
			worldDomination.toggleGroup = gameTypeToggleGroup;
			gameTypeGroup.addChild(worldDomination);
			
			var mission:Radio = new Radio();
			mission.label = "Mission";
			mission.toggleGroup = gameTypeToggleGroup;
			gameTypeGroup.addChild(mission);
			
			_gamesManipulationGroup.addChild(gameTypeGroup);
			
		}
		
		public function set state(value:String):void {
			switch(value) {
				case STATE_MENU:
					populateForMenu();
					break;
				case STATE_OPEN_GAME:
					populateForOpenGame();
					break;
				case STATE_PRIVATE_GAME:
					populateForPrivateGame();
					break;
				case STATE_JOIN_GAME:
					populateForJoinGame();
					break;
				default:
					trace("Selected invalid value for state in GameActionsDialog " + value);
					break;
			}
		}
		
		private function createOpenGame(event:Event):void {
			event.currentTarget.removeEventListener(Event.TRIGGERED, createOpenGame);
			state = STATE_OPEN_GAME;
		}
		
		private function createPrivateGame(event:Event):void {
			event.currentTarget.removeEventListener(Event.TRIGGERED, createPrivateGame);
			state = STATE_PRIVATE_GAME;
		}
		
		private function joinGame(event:Event):void {
			event.currentTarget.removeEventListener(Event.TRIGGERED, joinGame);
			state = STATE_JOIN_GAME;
		}
	
	}

}