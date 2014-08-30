package components {
	import communication.protos.Card;
	import components.common.ComponentWithStates;
	import components.common.StatesAdapter;
	import components.events.MouseClickEvent;
	import feathers.controls.LayoutGroup;
	import feathers.core.PopUpManager;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class CardPopup extends LayoutGroup implements ComponentWithStates{
		
		private static var _instance:CardPopup = null;
		
		public static function get instance():CardPopup {
			if (_instance == null) {
				_instance = new CardPopup();
			}
			
			return _instance;
		}
		
		private var _cardComponent:CardComponent = new CardComponent();
		
		private var _statesAdapter:StatesAdapter;
		
		public function CardPopup() {
			super();
			_statesAdapter = new StatesAdapter(this);
		}
		
		override protected function initialize():void {
			super.initialize();
			
			this.addChild(_cardComponent);
			_cardComponent.selectionEnabled = false;
			
			this.addEventListener(MouseClickEvent.CLICK, clickHandler);
		}
		
		public function showCard(card:Card):void {
			if (card != null) {
				_cardComponent.init(card);
				PopUpManager.addPopUp(this);
			}
		}
		
		private function clickHandler(e:MouseClickEvent):void {
			PopUpManager.removePopUp(this);
		}
		
		public function changeToUp():void {
		}
		
		public function changeToDown():void {
		}
		
		public function changeToHovered():void {
		}
		
		public function changeToDisabled():void {
		}
	
	}

}