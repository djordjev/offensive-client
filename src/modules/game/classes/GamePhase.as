package modules.game.classes {
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GamePhase {
		public static const TROOP_DEPLOYMENT_PHASE:int = 0;
		public static const ATTACK_PHASE:int = 1;
		public static const BATTLE_PHASE:int = 2;
		public static const TROOP_RELOCATION_PHASE:int = 3;
		
		
		public static const SUBPHASE_NO_SUBPHASE:int = 1000;
		public static const SUBPHASE_BORDER_CLASHES:int = 1001;
		public static const SUBPHASE_MULTIPLE_ATTACKS:int = 1002;
		public static const SUBPHASE_SINGLE_ATTACKS:int = 1003;
		public static const SUBPHASE_SPOILS_OF_WAR:int = 1004;
		
		public function GamePhase() {
		}
		
		public static function getPhaseName(phase:int):String {
			switch(phase) {
				case TROOP_DEPLOYMENT_PHASE:
					return "Troop deployment phase";
				case ATTACK_PHASE:
					return "Attack phase";
				case BATTLE_PHASE:
					return "Battle phase";
				case TROOP_RELOCATION_PHASE:
					return "Troop relocation phase";
				default:
					throw new Error("Reguesting name for game phase " + phase);
			}
		}
	
	}

}