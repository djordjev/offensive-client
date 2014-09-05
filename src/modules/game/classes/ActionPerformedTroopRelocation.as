package modules.game.classes {
	import components.events.RelocatePopup;
	import modules.game.GameController;
	import modules.game.GameModel;
	import utils.Alert;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ActionPerformedTroopRelocation implements IGameActionPerformed {
		
		private var _model:GameModel;
		private var _controller:GameController;
		
		private var _selectedTerritory:TerritoryWrapper;
		
		public function ActionPerformedTroopRelocation() {
			_model = GameModel.instance;
			_controller = GameController.instance;
		}
		
		public function clickOnTerritory(territory:TerritoryWrapper):void {
			if (_selectedTerritory == null && territory.owner == _model.me) {
				_selectedTerritory = territory;
			} else if (_selectedTerritory == null && territory.owner != _model.me) {
				Alert.showMessage("Error", "Can't relocate units from opponent's terrotory");
			} else if (_selectedTerritory != null && territory.id == _selectedTerritory.id) {
				// clicked on same territory, deselect it
				_selectedTerritory = null;
			} else if (_selectedTerritory.troopsOnIt <= 1) {
				Alert.showMessage("Not enough troops", "You can't leave territory empty");
				_selectedTerritory = null;
			} else if(Territories.isConnected(_selectedTerritory.id, territory.id)){
				// it's OK to relocate
				RelocatePopup.instance.showRelocationPopup(_selectedTerritory, territory, function unitsAdded(numberOfMoving:int):void {
					if (numberOfMoving > 0) {
						_model.moveUnits(_selectedTerritory, territory, numberOfMoving);
					}
					_selectedTerritory = null;
				});
			} else {
				Alert.showMessage("Illegal move", "You can't move to territory that is not connected");
			}
		}
	
	}

}