package modules.game.classes {
	import modules.game.GameController;
	import modules.game.GameModel;
	import utils.Alert;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ActionPerformedTroopDeployment implements IGameActionPerformed {
		
		private var _model:GameModel;
		private var _controller:GameController;
		
		public function ActionPerformedTroopDeployment() {
			_model = GameModel.instance;
			_controller = GameController.instance;
		}
		
		/* INTERFACE modules.game.classes.IGameActionPerformed */
		
		/** In troop deplyment phase  */
		public function clickOnTerritory(territory:TerritoryWrapper):void {
			if (territory.owner.userIdAsString == _model.me.userIdAsString) {
				_model.addReinforcement(territory.id);
				_controller.numberOfReinforcements = _model.numberOfReinforcements;
				_controller.unitsCount = _model.numberOfMyUnits;
			} else {
				Alert.showMessage("Mistake", "Can't place unit on opponents territory.");
			}
		}
	
	}

}