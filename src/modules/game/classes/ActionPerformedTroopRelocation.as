package modules.game.classes {
	import modules.game.GameController;
	import modules.game.GameModel;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ActionPerformedTroopRelocation implements IGameActionPerformed {
		
		private var _model:GameModel;
		private var _controller:GameController;
		
		public function ActionPerformedTroopRelocation() {
			_model = GameModel.instance;
			_controller = GameController.instance;
		}
		
		public function clickOnTerritory(territory:TerritoryWrapper):void {
			trace("Do nothing");
		}
	
	}

}