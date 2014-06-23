package communication {
	import communication.protos.AddUnitResponse;
	import communication.protos.AdvancePhaseNotification;
	import communication.protos.AttackResponse;
	import communication.protos.CommandsSubmittedResponse;
	import communication.protos.CreateGameResponse;
	import communication.protos.FilterFriendsResponse;
	import communication.protos.GetOpenGamesResponse;
	import communication.protos.GetUserDataResponse;
	import communication.protos.JoinGameNotification;
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
			mapping[HandlerCodes.ADD_UNIT] = AddUnitResponse;
			mapping[HandlerCodes.ATTACK] = AttackResponse;
			mapping[HandlerCodes.COMMANDS_SUBMIT] = CommandsSubmittedResponse;
			mapping[HandlerCodes.JOIN_GAME_NOTIFICATION] = JoinGameNotification;
			mapping[HandlerCodes.ADVANCE_TO_NEXT_PHASE] = AdvancePhaseNotification;
		}
	}
}
