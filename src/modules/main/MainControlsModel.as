package modules.main 
{
	import communication.Communicator;
	import communication.HandlerCodes;
	import communication.ProtocolMessage;
	import communication.protos.CreateGameRequest;
	import communication.protos.CreateGameResponse;
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
		
		public function MainControlsModel() 
		{
			super();
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
		
	}

}