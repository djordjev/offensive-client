package components.events 
{
	import starling.events.Event;
	import wrappers.GameContextWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class OpenGameEvent extends Event {
		
		public static const OPEN_GAME:String = "open game";
		
		private var _gameContext:GameContextWrapper;
		
		public function OpenGameEvent(type:String, context:GameContextWrapper, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			_gameContext = context;
		}
		
		public function get gameContext():GameContextWrapper {
			return _gameContext;
		}
		
	}

}