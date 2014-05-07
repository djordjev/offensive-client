package modules.game.classes 
{
	import feathers.controls.Alert;
	import wrappers.TerritoryWrapper;
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ActionPerformedWaitingForOpponents implements IGameActionPerformed 
	{
		
		public function ActionPerformedWaitingForOpponents() 
		{
			
		}
		
		/* INTERFACE modules.game.classes.IGameActionPerformed */
		
		public function clickOnTerritory(territory:TerritoryWrapper):void {
			trace("No action possible in this phase");
		}
		
	}

}