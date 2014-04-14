package components.events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class CreateGameEvent extends Event 
	{
		public static const CREATED_OPEN_GAME:String = "created open game";
		
		public var gameName:String;
		public var numberOfPlayers:int;
		public var objective:int;
		public var invitedFriends:Array;
		
		
		public function CreateGameEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}

}