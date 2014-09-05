package modules.game.classes {
	import components.AttackPopup;
	import modules.game.GameController;
	import modules.game.GameModel;
	import utils.Alert;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ActionPerformedAttack implements IGameActionPerformed {
		
		private var _model:GameModel;
		private var _controller:GameController;
		
		private var _selectedTerritory:TerritoryWrapper;
		
		public function ActionPerformedAttack() {
			_model = GameModel.instance;
			_controller = GameController.instance;
		}
		
		/* INTERFACE modules.game.classes.IGameActionPerformed */
		
		public function clickOnTerritory(territory:TerritoryWrapper):void {
			if (_selectedTerritory == null && territory.owner == _model.me) {
				_selectedTerritory = territory;
			} else if (_selectedTerritory == null && territory.owner != _model.me) {
				Alert.showMessage("Error", "Can't attack from opponent's terrotory");
			} else if (territory.owner == _model.me) {
				// clicked on same territory, deselect it
				_selectedTerritory = null;
			} else if (_selectedTerritory.troopsOnIt <= 1) {
				Alert.showMessage("Not enough troops", "You can't attack from territory that has less than 2 units on it");
				_selectedTerritory = null;
			} else if(Territories.isConnected(_selectedTerritory.id, territory.id)){
				// it's OK to attack
				AttackPopup.instance.showAttackDialog(_selectedTerritory, territory, function attackResolution(numberOfUnitsInAttack:int):void {
						if (numberOfUnitsInAttack != AttackPopup.ATTACK_CANCELED) {
							_model.attack(_selectedTerritory, territory, numberOfUnitsInAttack);
						}
						_selectedTerritory = null;
					});
			} else {
				Alert.showMessage("Illegal attack", "You can't attack territory that is not connected");
			}
		}
	}

}