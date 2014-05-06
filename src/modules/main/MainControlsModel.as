package modules.main 
{
	import communication.Communicator;
	import communication.HandlerCodes;
	import communication.ProtocolMessage;
	import communication.protos.CreateGameRequest;
	import communication.protos.CreateGameResponse;
	import communication.protos.GameDescription;
	import communication.protos.GetOpenGamesRequest;
	import communication.protos.GetOpenGamesResponse;
	import communication.protos.JoinGameRequest;
	import communication.protos.JoinGameResponse;
	import communication.protos.UserData;
	import flash.sampler.NewObjectSample;
	import modules.base.BaseModel;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class MainControlsModel extends BaseModel 
	{
		private static var _instance:MainControlsModel;
		
		public static function get instance():MainControlsModel {
			if (_instance == null) {
				_instance = new MainControlsModel();
			}
			return _instance;
		}
		
		/** Array of GameContext */
		public var activeGames:Array = [];
		
		/** Array of open games that are available for joining. Array of GameDescription */
		public var openGamesAvailableForJoin:Array = [];
		
		public function MainControlsModel() 
		{
			super();
		}
		
		public function initialize(myUserInfo:UserData):void {
			activeGames = myUserInfo.joinedGames;
		}
		
		public function requestJoinableGames(callback:Function):void {
			if (callback != null) {
				callback();
			}
		}
		
		public function createOpenGame(gameName:String, numberOfPlayers:int, gameType:int, callback:Function):void {
			var request:CreateGameRequest = new CreateGameRequest();
			request.gameName = gameName;
			request.numberOfPlayers = numberOfPlayers;
			request.objectiveCode = gameType;
			Communicator.instance.send(HandlerCodes.CREATE_GAME, request, function createOpenGameResponse(message:ProtocolMessage):void {
				var gameCreatedResponse:CreateGameResponse = message.data as CreateGameResponse;
				
				activeGames.push(gameCreatedResponse.gameContext);
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
				activeGames.push(response.gameContext);
				if (callback != null) {
					callback();
				}
			});
		}
		
	}

}