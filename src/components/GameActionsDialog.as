package components {
	import communication.protos.GameDescription;
	import components.classes.ExistingGamesRenderer;
	import components.classes.JoinableGamesRenderer;
	import components.classes.SelectableList;
	import components.common.LinkButton;
	import components.common.OLabel;
	import components.events.CreateGameEvent;
	import components.events.GameManipulationEvent;
	import components.events.JoinGameEvent;
	import components.events.MouseClickEvent;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.NumericStepper;
	import feathers.controls.Radio;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.TextInput;
	import feathers.core.ToggleGroup;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import starling.events.Event;
	import utils.Colors;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameActionsDialog extends LayoutGroup {
		
		public static const STATE_MENU:String = "state menu";
		public static const STATE_OPEN_GAME:String = "open game";
		public static const STATE_PRIVATE_GAME:String = "private game";
		public static const STATE_JOIN_GAME:String = "join game";
		
		public static const CREATED_PRIVATE_GAME:String = "created private game";
		public static const JOINED_GAME:String = "joined game";
		
		public static const REQUEST_LIST_OF_GAMES:String = "request list of open games";
		
		public var existingGamesList:List = new List();
		
		private var _gamesAvailableForJoining:SelectableList = new SelectableList();
		
		private var _gameName:TextInput;
		private var _numberOfPlayers:NumericStepper;
		private var _gameType:ToggleGroup;
		
		private var _gamesManipulationGroup:LayoutGroup = new LayoutGroup();
		
		public function GameActionsDialog() {
			super();
		}
		
		public function get gamesAvailableForJoining():SelectableList {
			return _gamesAvailableForJoining;
		}
		
		override protected function initialize():void {
			super.initialize();
			this.width = 840;
			this.height = 416;
			
			existingGamesList.x = 480;
			existingGamesList.y = 8;
			existingGamesList.width = 235;
			existingGamesList.height = 320;
			
			existingGamesList.addEventListener(Event.ADDED_TO_STAGE, function listIsAddedToStage(e:Event):void {
				existingGamesList.backgroundSkin.alpha = 0;
			});
			
			var listLayout:VerticalLayout = new VerticalLayout();
			listLayout.gap = 10;
			existingGamesList.layout = listLayout;
			
			existingGamesList.itemRendererFactory = existingGamesRendererFactory;
			this.addChild(existingGamesList);
		}
		
		private function populateForMenu():void {
			initializeLeftGroup();
			
			var createOpenGameButton:LinkButton = new LinkButton();
			createOpenGameButton.width = 300;
			createOpenGameButton.height = 80;
			createOpenGameButton.label = "Create open game";
			createOpenGameButton.addEventListener(MouseClickEvent.CLICK, createOpenGame);
			_gamesManipulationGroup.addChild(createOpenGameButton);
			
			var createPrivateGameButton:LinkButton = new LinkButton();
			createPrivateGameButton.width = 300;
			createPrivateGameButton.height = 80;
			createPrivateGameButton.label = "Create private game";
			createPrivateGameButton.addEventListener(MouseClickEvent.CLICK, createPrivateGame);
			//_gamesManipulationGroup.addChild(createPrivateGameButton);
			
			var joinGameButton:LinkButton = new LinkButton();
			joinGameButton.width = 300;
			joinGameButton.height = 80;
			joinGameButton.label = "Join game";
			joinGameButton.addEventListener(MouseClickEvent.CLICK, joinGame);
			_gamesManipulationGroup.addChild(joinGameButton);
		}
		
		private function populateForOpenGame():void {
			initializeLeftGroup();
			addHeader("Add open game");
			
			addComponentsForNewGame();
			var createOpenGameButton:LinkButton = new LinkButton();
			createOpenGameButton.label = "CREATE NEW OPEN GAME";
			createOpenGameButton.fontSize = 20;
			createOpenGameButton.height = 50;
			createOpenGameButton.width = 200;
			createOpenGameButton.addEventListener(MouseClickEvent.CLICK, function createdOpenGame():void {
					var newOpenGameEvent:CreateGameEvent = new CreateGameEvent(CreateGameEvent.CREATED_OPEN_GAME, true);
					populateCreateGameEvent(newOpenGameEvent);
					dispatchEvent(newOpenGameEvent);
				});
			_gamesManipulationGroup.addChild(createOpenGameButton);
		}
		
		private function populateForPrivateGame():void {
			initializeLeftGroup();
			addHeader("Create private game");
			
			addComponentsForNewGame();
			
			var inviteButton:LinkButton = new LinkButton();
			inviteButton.label = "INVITE FRIENDS";
			inviteButton.height = 50;
			inviteButton.width = 200;
			inviteButton.fontSize = 20;
			//_gamesManipulationGroup.addChild(inviteButton);
			
			var createPrivateGameButton:LinkButton = new LinkButton();
			createPrivateGameButton.label = "CREATE NEW PRIVATE GAME";
			createPrivateGameButton.height = 50;
			createPrivateGameButton.width = 200;
			createPrivateGameButton.fontSize = 20;
			createPrivateGameButton.addEventListener(MouseClickEvent.CLICK, function createdOpenGame():void {
					dispatchEvent(new Event(CREATED_PRIVATE_GAME, true));
				});
			_gamesManipulationGroup.addChild(createPrivateGameButton);
		}
		
		private function populateForJoinGame():void {
			initializeLeftGroup();
			addHeader("Join game");
			
			_gamesAvailableForJoining = new SelectableList();
			_gamesAvailableForJoining.itemRendererFactory = joinableGamesRenderersFactory;
			_gamesAvailableForJoining.height = 200;
			_gamesAvailableForJoining.width = 400;
			_gamesManipulationGroup.addChild(_gamesAvailableForJoining);
			
			var joinButton:LinkButton = new LinkButton();
			joinButton.x = 350;
			joinButton.fontSize = 20;
			joinButton.label = "JOIN";
			joinButton.addEventListener(MouseClickEvent.CLICK, function joiedButtonClicked(e:Event):void {
					var selectedGameContext:GameDescription = _gamesAvailableForJoining.selectedItem as GameDescription;
					dispatchEvent(new JoinGameEvent(JoinGameEvent.JOINED_TO_GAME, selectedGameContext, true));
				});
			_gamesManipulationGroup.addChild(joinButton);
			
			this.dispatchEvent(new Event(REQUEST_LIST_OF_GAMES, true));
		
		}
		
		private function addHeader(actionName:String):void {
			var actionsNameGroup:LayoutGroup = new LayoutGroup();
			actionsNameGroup.layout = new HorizontalLayout();
			(actionsNameGroup.layout as HorizontalLayout).gap = 20;
			
			var nameForActions:OLabel = new OLabel();
			nameForActions.text = actionName.toUpperCase();
			nameForActions.font = OLabel.FONT_GEARS_OF_PACE;
			nameForActions.fontSize = 15;
			nameForActions.fontColor = Colors.BLACK;
			
			var back:BackButton = new BackButton();
			back.addEventListener(MouseClickEvent.CLICK, function goBack(e:Event):void {
					state = STATE_MENU;
				});
			actionsNameGroup.addChild(back);
			actionsNameGroup.addChild(nameForActions);
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
			
			_gameName = null;
			_gameType = null;
			_numberOfPlayers = null;
		}
		
		private function addComponentsForNewGame():void {
			var gameNameGroup:LayoutGroup = new LayoutGroup();
			gameNameGroup.layout = new HorizontalLayout();
			(gameNameGroup.layout as HorizontalLayout).gap = 20;
			
			var gameNameLabel:OLabel = new OLabel();
			gameNameLabel.font = OLabel.FONT_GEARS_OF_PACE;
			gameNameLabel.fontColor = Colors.BLACK;
			gameNameLabel.fontSize = 23;
			gameNameLabel.text = "Game Name";
			gameNameGroup.addChild(gameNameLabel);
			
			_gameName = new TextInput();
			_gameName.width = 250;
			_gameName.clearFocus();
			_gameName.setFocus();
			_gameName.showFocus();
			gameNameGroup.addChild(_gameName);
			
			_gamesManipulationGroup.addChild(gameNameGroup);
			
			var numberOfPlayersGroup:LayoutGroup = new LayoutGroup();
			numberOfPlayersGroup.layout = new HorizontalLayout();
			(numberOfPlayersGroup.layout as HorizontalLayout).gap = 20;
			
			var numberOfPlayersLabel:OLabel = new OLabel();
			numberOfPlayersLabel.font = OLabel.FONT_GEARS_OF_PACE;
			numberOfPlayersLabel.fontColor = Colors.BLACK;
			numberOfPlayersLabel.fontSize = 23;
			numberOfPlayersLabel.text = "Number of players";
			numberOfPlayersGroup.addChild(numberOfPlayersLabel);
			
			_numberOfPlayers = new NumericStepper();
			_numberOfPlayers.minimum = 2;
			_numberOfPlayers.maximum = 5;
			_numberOfPlayers.value = 5;
			_numberOfPlayers.step = 1;
			numberOfPlayersGroup.addChild(_numberOfPlayers);
			
			_gamesManipulationGroup.addChild(numberOfPlayersGroup);
			
			var gameTypeGroup:LayoutGroup = new LayoutGroup();
			gameTypeGroup.layout = new HorizontalLayout();
			(gameTypeGroup.layout as HorizontalLayout).gap = 20;
			
			_gameType = new ToggleGroup();
			_gameType.isSelectionRequired = true;
			
			var worldDomination:Radio = new Radio();
			worldDomination.label = "World domination";
			worldDomination.toggleGroup = _gameType;
			gameTypeGroup.addChild(worldDomination);
			
			var mission:Radio = new Radio();
			mission.label = "Mission";
			mission.toggleGroup = _gameType;
			gameTypeGroup.addChild(mission);
			
			_gamesManipulationGroup.addChild(gameTypeGroup);
		
		}
		
		public function set state(value:String):void {
			switch (value) {
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
			
			this.dispatchEvent(new GameManipulationEvent(GameManipulationEvent.SELECTED_GAME_ACTION, value, true));
		}
		
		private function createOpenGame(event:Event):void {
			event.currentTarget.removeEventListener(MouseClickEvent.CLICK, createOpenGame);
			state = STATE_OPEN_GAME;
		}
		
		private function createPrivateGame(event:Event):void {
			event.currentTarget.removeEventListener(MouseClickEvent.CLICK, createPrivateGame);
			state = STATE_PRIVATE_GAME;
		}
		
		private function joinGame(event:Event):void {
			event.currentTarget.removeEventListener(MouseClickEvent.CLICK, joinGame);
			state = STATE_JOIN_GAME;
		}
		
		private function populateCreateGameEvent(e:CreateGameEvent):void {
			e.gameName = _gameName.text;
			e.numberOfPlayers = _numberOfPlayers.value;
			if ((_gameType.selectedItem as Radio).label == "Mission") {
				e.objective = 1;
			} else {
				e.objective = 0;
			}
		}
		
		private function existingGamesRendererFactory():IListItemRenderer {
			var renderer:ExistingGamesRenderer = new ExistingGamesRenderer();
			return renderer;
		}
		
		private function joinableGamesRenderersFactory():IListItemRenderer {
			return new JoinableGamesRenderer;
		}
		
	}

}