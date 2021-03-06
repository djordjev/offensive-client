package modules.main {
	import com.netease.protobuf.Int64;
	import communication.Communicator;
	import communication.HandlerCodes;
	import communication.ProtocolMessage;
	import communication.protos.AdvancePhaseNotification;
	import communication.protos.AdvanceToNextBattle;
	import communication.protos.AllCommands;
	import communication.protos.BorderClashes;
	import communication.protos.CardAwardedNotification;
	import communication.protos.Command;
	import communication.protos.CreateGameRequest;
	import communication.protos.CreateGameResponse;
	import communication.protos.GameContext;
	import communication.protos.GameDescription;
	import communication.protos.GetOpenGamesRequest;
	import communication.protos.GetOpenGamesResponse;
	import communication.protos.JoinGameNotification;
	import communication.protos.JoinGameRequest;
	import communication.protos.JoinGameResponse;
	import communication.protos.MultipleAttacks;
	import communication.protos.PlayerCardCountNotification;
	import communication.protos.PlayerRolledDice;
	import communication.protos.ReinforcementsNotification;
	import communication.protos.SingleAttacks;
	import communication.protos.SpoilsOfWar;
	import communication.protos.Territory;
	import communication.protos.UserData;
	import communication.protos.UserStatistics;
	import components.CurrentPlayerImage;
	import flash.sampler.NewObjectSample;
	import flash.utils.Dictionary;
	import modules.base.BaseModel;
	import modules.game.classes.GamePhase;
	import modules.game.events.PlayerEvent;
	import modules.game.GameController;
	import modules.game.GameModel;
	import utils.Alert;
	import wrappers.GameContextWrapper;
	import wrappers.PlayerWrapper;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class MainControlsModel extends BaseModel {
		private static var _instance:MainControlsModel;
		
		public static function get instance():MainControlsModel {
			if (_instance == null) {
				_instance = new MainControlsModel();
			}
			return _instance;
		}
		
		/** Array of GameContextWrapper */
		public var activeGames:Array;
		
		/** Shows to same objects as activeGames. Mappint gameId.toString() -> GameContextWrapper */
		public var activeGamesDictionary:Dictionary;
		
		/** Array of open games that are available for joining. Array of GameDescription */
		public var openGamesAvailableForJoin:Array = [];
		
		private var _stats:UserStatistics;
		
		public function MainControlsModel() {
			super();
		}
		
		public function get stats():UserStatistics {
			return _stats;
		}
		
		public function initialize(myUserInfo:UserData):void {
			activeGames = [];
			activeGamesDictionary = new Dictionary();
			_stats = myUserInfo.statistics;
			for each (var gameContext:GameContext in myUserInfo.joinedGames) {
				var game:GameContextWrapper = GameContextWrapper.buildGameContext(gameContext);
				activeGames.push(game);
				activeGamesDictionary[game.gameId.toString()] = game;
			}
			Communicator.instance.subscribe(HandlerCodes.JOIN_GAME_NOTIFICATION, opponentJoined);
			Communicator.instance.subscribe(HandlerCodes.ADVANCE_TO_NEXT_PHASE, advanceToNextPhase);
			
			// attach listeners
			Communicator.instance.subscribe(HandlerCodes.ALL_COMMANDS_BATTLE_PHASE, allCommandsSubmitted);
			
			Communicator.instance.subscribe(HandlerCodes.BORDER_CLASHES, borderClashes);
			Communicator.instance.subscribe(HandlerCodes.MULTIPLE_ATTACKS, multipleAttacks);
			Communicator.instance.subscribe(HandlerCodes.SINGLE_ATTACKS, singleAttacks);
			Communicator.instance.subscribe(HandlerCodes.SPOILS_OF_WAR, spoilsOfWar);
			
			Communicator.instance.subscribe(HandlerCodes.ADVANCE_TO_NEXT_BATTLE, advanceToNextBattle);
			Communicator.instance.subscribe(HandlerCodes.PLAYER_ROLLED_DICE, playerRolledDice);
			
			Communicator.instance.subscribe(HandlerCodes.NEW_CARD_AWARDED, newCardReceived);
			Communicator.instance.subscribe(HandlerCodes.PLAYER_CARD_COUNT_CHANGED, cardCountStateChanged);
			
			Communicator.instance.subscribe(HandlerCodes.REINFORCEMENTS_GAINED, reinforcementsReceived);
		}
		
		public function createOpenGame(gameName:String, numberOfPlayers:int, gameType:int, callback:Function):void {
			var request:CreateGameRequest = new CreateGameRequest();
			request.gameName = gameName;
			request.numberOfPlayers = numberOfPlayers;
			request.objectiveCode = gameType;
			Communicator.instance.send(HandlerCodes.CREATE_GAME, request, function createOpenGameResponse(message:ProtocolMessage):void {
					var gameCreatedResponse:CreateGameResponse = message.data as CreateGameResponse;
					
					var responseGame:GameContextWrapper = GameContextWrapper.buildGameContext(gameCreatedResponse.gameContext);
					activeGames.push(responseGame);
					activeGamesDictionary[responseGame.gameId.toString()] = responseGame;
					if (callback != null) {
						callback();
					}
				});
		}
		
		public function getListOfOpenGames(callback:Function):void {
			var request:GetOpenGamesRequest = new GetOpenGamesRequest();
			Communicator.instance.send(HandlerCodes.OPEN_GAMES_LIST, request, function receivedListOfOpenGames(message:ProtocolMessage):void {
					var response:GetOpenGamesResponse = message.data as GetOpenGamesResponse;
					openGamesAvailableForJoin = response.gameDescription;
					if (callback != null) {
						callback();
					}
				});
		}
		
		public function joinToGame(gameDescription:GameDescription, callback:Function):void {
			var request:JoinGameRequest = new JoinGameRequest();
			request.gameId = gameDescription.gameId;
			Communicator.instance.send(HandlerCodes.JOIN_GAME, request, function receivedJoinGameResponse(message:ProtocolMessage):void {
					var response:JoinGameResponse = message.data as JoinGameResponse;
					var responseGame:GameContextWrapper = GameContextWrapper.buildGameContext(response.gameContext);
					activeGames.push(responseGame);
					activeGamesDictionary[responseGame.gameId.toString()] = responseGame;
					if (callback != null) {
						callback();
					}
				});
		}
		
		private function opponentJoined(message:ProtocolMessage):void {
			var notification:JoinGameNotification = message.data as JoinGameNotification;
			addPlayerToGame(PlayerWrapper.buildPlayerWrapper(notification.player), notification.gameId);
		}
		
		private function addPlayerToGame(player:PlayerWrapper, gameId:Int64):void {
			var game:GameContextWrapper = activeGamesDictionary[gameId.toString()];
			if (game != null) {
				if (game.numberOfJoinedPlayers < game.numberOfPlayers) {
					// there is still place to put this player
					game.numberOfJoinedPlayers++;
					for (var i:int = 0; i < game.players.length; i++) {
						if (game.players[i].playerId == player.playerId) {
							game.players[i] = player;
						}
					}
					dispatchEvent(new PlayerEvent(PlayerEvent.NEW_PLAYER_JOINED, player, game));
				} else {
					throw new Error("Trying to add player into fully populated game");
				}
			}
		}
		
		private function advanceToNextPhase(message:ProtocolMessage):void {
			var response:AdvancePhaseNotification = message.data as AdvancePhaseNotification;
			var game:GameContextWrapper = activeGamesDictionary[response.gameId.toString()];
			if (game != null) {
				game.phase++;
				if (game.phase > GamePhase.TROOP_RELOCATION_PHASE) {
					game.phase = GamePhase.TROOP_DEPLOYMENT_PHASE;
				}
				if (GameController.instance.currentGameId != null && GameController.instance.currentGameId.toString() == response.gameId.toString()) {
					GameModel.instance.advancedToNextPhase(response);
				} else {
					for each(var territory:Territory in response.territories) {
						var owner:PlayerWrapper;
						
						for each(var player:PlayerWrapper in game.players) {
							if (player.playerId == territory.playerId) {
								owner = player;
								break;
							}
						}
						
						for each(var existingTerritory:TerritoryWrapper in game.terrotiries) {
							if (existingTerritory.id == territory.id) {
								existingTerritory.conquer(owner, territory.troopsOnIt);
							}
						}
					}
				}
			}
		}
		
		private function allCommandsSubmitted(e:ProtocolMessage):void {
			var allCommands:AllCommands = e.data as AllCommands;
			var currentGameId:Int64 = GameModel.instance.gameId;
			
			if (currentGameId != null && allCommands.gameId.toString() == currentGameId.toString()) {
				GameModel.instance.allCommandsReceived(allCommands);
			}
		}
		
		private function borderClashes(e:ProtocolMessage):void {
			var borderClashes:BorderClashes = e.data as BorderClashes;
			if (GameModel.instance.gameId != null && borderClashes.gameId.toString() == GameModel.instance.gameId.toString()) {
				GameModel.instance.borderClashesReceived(borderClashes);
			}
		}
		
		private function multipleAttacks(e:ProtocolMessage):void {
			var multipleAttacks:MultipleAttacks = e.data as MultipleAttacks;
			if (GameModel.instance.gameId != null && multipleAttacks.gameId.toString() == GameModel.instance.gameId.toString()) {
				GameModel.instance.multipleAttacksReceived(multipleAttacks);
			}
		}
		
		private function singleAttacks(e:ProtocolMessage):void {
			var singleAttacks:SingleAttacks = e.data as SingleAttacks;
			if (GameModel.instance.gameId != null && singleAttacks.gameId.toString() == GameModel.instance.gameId.toString()) {
				GameModel.instance.singleAttacksReceived(singleAttacks);
			}
		}
		
		private function spoilsOfWar(e:ProtocolMessage):void {
			var spoilsOfWar:SpoilsOfWar = e.data as SpoilsOfWar;
			if (GameModel.instance.gameId != null && spoilsOfWar.gameId.toString() == GameModel.instance.gameId.toString()) {
				GameModel.instance.spoilsOfWarReceived(spoilsOfWar);
			}
		}
		
		private function advanceToNextBattle(e:ProtocolMessage):void {
			var advanceMessage:AdvanceToNextBattle = e.data as AdvanceToNextBattle;
			if (GameModel.instance.gameId != null && advanceMessage.gameId.toString() == GameModel.instance.gameId.toString()) {
				GameModel.instance.advanceToNextBattle(advanceMessage.battleInfo);
			}
		}
		
		private function playerRolledDice(e:ProtocolMessage):void {
			var rolledDice:PlayerRolledDice = e.data as PlayerRolledDice;
			if (GameModel.instance.gameId != null && rolledDice.gameId.toString() == GameModel.instance.gameId.toString()) {
				GameModel.instance.opponentRolledDice(rolledDice);
			}
		}
		
		private function newCardReceived(e:ProtocolMessage):void {
			var received:CardAwardedNotification = e.data as CardAwardedNotification;
			var gameContext:GameContextWrapper = activeGamesDictionary[received.gameId.toString()];
			if (GameModel.instance.gameId != null && received.gameId.toString() == GameModel.instance.gameId.toString()) {
				// this game is currently opened
				GameModel.instance.newCardAwarded(received.card);
				
			} else {
				gameContext.myCards.push(received.card);
				gameContext.me.cardsNumber++;
			}
		
		}
		
		private function cardCountStateChanged(e:ProtocolMessage):void {
			var received:PlayerCardCountNotification = e.data as PlayerCardCountNotification;
			var gameContext:GameContextWrapper = activeGamesDictionary[received.gameId.toString()];
			
			if (GameModel.instance.gameId != null && received.gameId.toString() == GameModel.instance.gameId.toString()) {
				GameModel.instance.cardCountStateChanged(received);
			} else {
				for each (var player:PlayerWrapper in gameContext.players) {
					if (player.playerId == received.playerId) {
						player.cardsNumber = received.cardCount;
						break;
					}
				}
			}
		
		}
		
		private function reinforcementsReceived(e:ProtocolMessage):void {
			var received:ReinforcementsNotification = e.data as ReinforcementsNotification;
			var gameContext:GameContextWrapper = activeGamesDictionary[received.gameId.toString()];
			
			if (GameModel.instance.gameId != null && GameModel.instance.gameId.toString() == received.gameId.toString()) {
				GameModel.instance.reinforcementsReceived(received.numberOfReinforcements);
			} else {
				gameContext.me.numberOdReinforcements += received.numberOfReinforcements;
			}
		}
		
		
		public function gameOver(gameId:Int64):void {
			for (var i:int = 0; i < activeGames.length; i++) {
				if (activeGames[i].gameId.toString() == gameId.toString()) {
					activeGames.splice(i, 1);
					break;
				}
			}
			
			delete activeGamesDictionary[gameId.toString()];
		}
	}

}