package modules.main {
	import com.netease.protobuf.Int64;
	import communication.Communicator;
	import communication.HandlerCodes;
	import communication.ProtocolMessage;
	import communication.protos.AdvancePhaseNotification;
	import communication.protos.AllCommands;
	import communication.protos.BorderClashes;
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
	import communication.protos.UserData;
	import components.CurrentPlayerImage;
	import flash.sampler.NewObjectSample;
	import modules.base.BaseModel;
	import modules.game.classes.GamePhase;
	import modules.game.events.PlayerEvent;
	import modules.game.GameController;
	import modules.game.GameModel;
	import utils.Alert;
	import wrappers.GameContextWrapper;
	import wrappers.PlayerWrapper;
	
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
		
		/** Array of open games that are available for joining. Array of GameDescription */
		public var openGamesAvailableForJoin:Array = [];
		
		public function MainControlsModel() {
			super();
		}
		
		public function initialize(myUserInfo:UserData):void {
			activeGames = [];
			for each (var gameContext:GameContext in myUserInfo.joinedGames) {
				var game:GameContextWrapper = GameContextWrapper.buildGameContext(gameContext);
				activeGames.push(game);
			}
			Communicator.instance.subscribe(HandlerCodes.JOIN_GAME_NOTIFICATION, opponentJoined);
			Communicator.instance.subscribe(HandlerCodes.ADVANCE_TO_NEXT_PHASE, advanceToNextPhase);
			
			// attach listeners
			Communicator.instance.subscribe(HandlerCodes.ALL_COMMANDS_BATTLE_PHASE, allCommandsSubmitted);
			Communicator.instance.subscribe(HandlerCodes.BORDER_CLASHES, borderClashes);
			Communicator.instance.subscribe(HandlerCodes.PLAYER_ROLLED_DICE, playerRolledDice);
			Communicator.instance.subscribe(HandlerCodes.ADVANCE_TO_NEXT_BATTLE, advanceToNextBattle);
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
			for each (var game:GameContextWrapper in activeGames) {
				if (game.gameId.toString() == gameId.toString()) {
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
		}
		
		private function advanceToNextPhase(message:ProtocolMessage):void {
			var response:AdvancePhaseNotification = message.data as AdvancePhaseNotification;
			for each (var game:GameContextWrapper in activeGames) {
				if (game.gameId.toString() == response.gameId.toString()) {
					game.phase++;
					if (game.phase > GamePhase.TROOP_RELOCATION_PHASE) {
						game.phase = GamePhase.TROOP_DEPLOYMENT_PHASE;
					}
					if (GameController.instance.currentGameId != null && GameController.instance.currentGameId.toString() == response.gameId.toString()) {
						Alert.showMessage("", "Advance to new phase");
						GameModel.instance.advancedToNextPhase(response);
					}
					break;
				}
			}
		}
		
		private function allCommandsSubmitted(e:ProtocolMessage):void {
			var allCommands:AllCommands = e.data as AllCommands;
			if (GameModel.instance.gameId != null &&
				allCommands.gameId.toString() == GameModel.instance.gameId.toString()) {
				GameModel.instance.allCommandsReceived(allCommands);
			}
		}
		
		private function borderClashes(e:ProtocolMessage):void {
			var borderClashes:BorderClashes = e.data as BorderClashes;
			if (GameModel.instance.gameId != null &&
				borderClashes.gameId.toString() == GameModel.instance.gameId.toString()) {
				GameModel.instance.borderClashesReceived(borderClashes);
			}
		}
		
		private function playerRolledDice(e:ProtocolMessage):void {
			trace("player rolled dice");
		}
		
		private function advanceToNextBattle(e:ProtocolMessage):void {
			trace("advance to next battle");
		}
	}

}