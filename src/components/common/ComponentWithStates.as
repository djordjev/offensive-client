package components.common 
{
	import feathers.core.IFeathersControl;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public interface ComponentWithStates extends IFeathersControl
	{
		function changeToUp():void;
		function changeToDown():void;
		function changeToHovered():void;
		function changeToDisabled():void;
	}
	
}