package components.events 
{
	import feathers.core.FeathersControl;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class MouseClickEvent extends Event {
		
		public static const CLICK:String = "clicked on component";
		
		private var _targetComponent:FeathersControl;
		
		public function MouseClickEvent(type:String, component:FeathersControl, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			_targetComponent = component;
		}
		
		public function get targetComponent():FeathersControl {
			return _targetComponent;
		}
		
	}

}