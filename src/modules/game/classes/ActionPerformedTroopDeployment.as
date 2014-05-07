package modules.game.classes {
	import modules.game.GameModel;
	import wrappers.TerritoryWrapper;
	
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
			_model.addReinforcement(territory.territory.id);
		}
	
	}

}