package communication {
	import communication.protos.AddUnitResponse;
	import communication.protos.AdvancePhaseNotification;
	import communication.protos.AdvanceToNextBattle;
	import communication.protos.AllCommands;
	import communication.protos.AttackResponse;
	import communication.protos.BorderClashes;
	import communication.protos.CommandsSubmittedResponse;
	import communication.protos.CreateGameResponse;
	import communication.protos.FilterFriendsResponse;
	import communication.protos.GetOpenGamesResponse;
	import communication.protos.GetUserDataResponse;
	import communication.protos.JoinGameNotification;
	import communication.protos.JoinGameResponse;
	import communication.protos.MultipleAttacks;
	import communication.protos.PlayerRolledDice;
	import communication.protos.RollDiceClickedResponse;
	import communication.protos.SingleAttacks;
	import communication.protos.SpoilsOfWar;

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
			mapping[HandlerCodes.ALL_COMMANDS_BATTLE_PHASE] = AllCommands;
			mapping[HandlerCodes.BORDER_CLASHES] = BorderClashes;
			mapping[HandlerCodes.ADVANCE_TO_NEXT_BATTLE] = AdvanceToNextBattle;
			mapping[HandlerCodes.ROLL_DICE] = RollDiceClickedResponse;
			mapping[HandlerCodes.PLAYER_ROLLED_DICE] = PlayerRolledDice;
			mapping[HandlerCodes.JOIN_GAME_NOTIFICATION] = JoinGameNotification;
			mapping[HandlerCodes.ADVANCE_TO_NEXT_PHASE] = AdvancePhaseNotification;
			mapping[HandlerCodes.MULTIPLE_ATTACKS] = MultipleAttacks;
			mapping[HandlerCodes.SINGLE_ATTACKS] = SingleAttacks;
			mapping[HandlerCodes.SPOILS_OF_WAR] = SpoilsOfWar;
		}
	}
}
