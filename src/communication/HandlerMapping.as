package communication {
	import communication.protos.CreateGameResponse;
	import communication.protos.FilterFriendsResponse;
	import communication.protos.GetOpenGamesResponse;
	import communication.protos.GetUserDataResponse;
	import communication.protos.JoinGameResponse;

	import flash.utils.Dictionary;

	public class HandlerMapping {
		public static var mapping:Dictionary = new Dictionary();

		public function HandlerMapping() {
			mapping[HandlerCodes.GET_USER_DATA] = GetUserDataResponse;
			mapping[HandlerCodes.CREATE_GAME] = CreateGameResponse;
			mapping[HandlerCodes.OPEN_GAMES_LIST] = GetOpenGamesResponse;
			mapping[HandlerCodes.FILTER_FRIENDS] = FilterFriendsResponse;
			mapping[HandlerCodes.JOIN_GAME] = JoinGameResponse;
		}
	}
}
