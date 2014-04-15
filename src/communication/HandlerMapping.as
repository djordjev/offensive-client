package communication {
	import communication.protos.CreateGameResponse;
	import communication.protos.GetOpenGamesResponse;
	import communication.protos.GetUserDataResponse;

	import flash.utils.Dictionary;

	public class HandlerMapping {
		public static var mapping:Dictionary = new Dictionary();

		public function HandlerMapping() {
			mapping[HandlerCodes.GET_USER_DATA] = GetUserDataResponse;
			mapping[HandlerCodes.CREATE_GAME] = CreateGameResponse;
			mapping[HandlerCodes.OPEN_GAMES_LIST] = GetOpenGamesResponse;
		}
	}
}
