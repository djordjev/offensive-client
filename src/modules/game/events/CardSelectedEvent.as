package modules.game.events {
	import communication.protos.Card;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Djordje
	 */
	public class CardSelectedEvent extends Event {
		public static const CARD_SELECTION_CHANGED:String = "card selection changed";
		
		private var _card:Card;
		private var _isSelected:Boolean;
		
		public function CardSelectedEvent(type:String, card:Card, isSelected:Boolean, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, data);
			_card = card;
			_isSelected = isSelected;
		}
		
		public function get isSelected():Boolean {
			return _isSelected;
		}
		
		public function get card():Card {
			return _card;
		}
	
	}

}