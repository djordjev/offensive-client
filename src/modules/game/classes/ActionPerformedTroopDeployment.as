package modules.game.classes {
	import communication.Me;
	import modules.game.GameModel;
	import wrappers.TerritoryWrapper;
	import wrappers.UserWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ActionPerformedTroopDeployment implements IGameActionPerformed {
		
		private var _model:GameModel;
		
		public function ActionPerformedTroopDeployment(model:GameModel) {
			_model = model;
		}
		
		/* INTERFACE modules.game.classes.IGameActionPerformed */
		
		/** In troop deplyment phase  */
		public function clickOnTerritory(territory:TerritoryWrapper):void {
			if (territory.owner.userIdAsString == _model.me.userIdAsString) {
				_model.addReinforcement(territory.territory.id);
			} else {
				trace("Can't deploy unit on enemy territory");
			}
		}
	
	}

}