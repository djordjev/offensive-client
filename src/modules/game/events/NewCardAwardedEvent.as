package modules.game.events {
	import communication.protos.Card;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Djordje
	 */
	public class NewCardAwardedEvent extends Event {
		
		public static const NEW_CARD_RECEIVED:String = "new card received";
		
		private var _card:Card
		
		public function NewCardAwardedEvent(type:String, card:Card, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, data);
			_card = card;
		}
		
		public function get card():Card {
			return _card;
		}
	
	}

}