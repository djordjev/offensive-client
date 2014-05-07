package modules.game.classes 
{
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public interface IGameActionPerformed 
	{
		function clickOnTerritory(territory:TerritoryWrapper):void;
	}
	
}