package components.events 
{
	import communication.protos.GameContext;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class OpenGameEvent extends Event {
		
		public static const OPEN_GAME:String = "open game";
		
		private var _gameContext:GameContext;
		
		public function OpenGameEvent(type:String, context:GameContext, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			_gameContext = context;
		}
		
		public function get gameContext():GameContext {
			return _gameContext;
		}
		
	}

}