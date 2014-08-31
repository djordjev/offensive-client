package components {
	import communication.protos.Card;
	import components.common.ComponentWithStates;
	import components.common.StatesAdapter;
	import components.events.MouseClickEvent;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import starling.filters.BlurFilter;
	import utils.Assets;
	import utils.Colors;
	
	/**
	 * ...
	 * @author Djordje
	 */
	public class CardComponent extends LayoutGroup implements ComponentWithStates {
		
		private static const WIDTH:int = 150;
		private static const HEIGHT:int = 250;
		
		private var _statesAdapter:StatesAdapter;
		
		public var selectionEnabled:Boolean = true;
		
		private var _isSelected:Boolean = false;
		
		private var _cardImage:ImageLoader = new ImageLoader();
		
		private var _glow:BlurFilter;
		
		private var _card:Card;
		
		public function CardComponent() {
			super();
			_statesAdapter = new StatesAdapter(this);
			_glow = BlurFilter.createGlow(Colors.WHITE, 1, 6);
		}
		
		public function init(card:Card):void {
			this._card = card;
			
			_cardImage.source = Assets.getCard(_card.territoryId);
		}
		
		public function get card():Card {
			return _card;
		}
		
		public function get isSelected():Boolean {
			return _isSelected;
		}
		
		override protected function initialize():void {
			super.initialize();
			
			this.addChild(_cardImage);
			
			this.addEventListener(MouseClickEvent.CLICK, clickHandler);
		
		}
		
		private function clickHandler(e:MouseClickEvent):void {
			if (selectionEnabled) {
				_isSelected = !_isSelected;
				if (_isSelected) {
					this.filter = _glow;
				} else {
					this.filter = null;
				}
			}
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