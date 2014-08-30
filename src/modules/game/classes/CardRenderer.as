package modules.game.classes {
	import communication.protos.Card;
	import components.CardComponent;
	import components.common.ComponentWithStates;
	import components.events.MouseClickEvent;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import modules.game.events.CardSelectedEvent;
	
	/**
	 * ...
	 * @author Djordje
	 */
	public class CardRenderer extends LayoutGroupListItemRenderer implements ComponentWithStates{
		
		private var _cardComponent:CardComponent = new CardComponent();
		
		private var _dirty:Boolean = true;
		
		public function CardRenderer() {
			super();
		}
		
		override public function set data(value:Object):void {
			super.data = value;
			_dirty = true;
		}
		
		public function get dataAsCard():Card {
			return _data as Card;
		}
		
		override protected function initialize():void {
			super.initialize();
			
			this.addChild(_cardComponent);
			_cardComponent.selectionEnabled = true;
			
			_cardComponent.addEventListener(MouseClickEvent.CLICK, clickHandler);
		}
		
		override protected function commitData():void {
			if (_dirty) {
				_dirty = false;
				
				_cardComponent.init(dataAsCard);
			}
			super.commitData();
		}
		
		public function changeToUp():void {
		}
		
		public function changeToDown():void {
		}
		
		public function changeToHovered():void {
		}
		
		public function changeToDisabled():void {
		}
		
		private function clickHandler(e:MouseClickEvent):void {
			_cardComponent.isSelected = !_cardComponent.isSelected;
			dispatchEvent(new CardSelectedEvent(CardSelectedEvent.CARD_SELECTION_CHANGED, 
												dataAsCard, _cardComponent.isSelected, true));
		}
	
	}

}