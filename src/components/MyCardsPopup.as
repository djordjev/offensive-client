package components {
	import communication.protos.Card;
	import components.common.LinkButton;
	import components.events.MouseClickEvent;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.layout.TiledColumnsLayout;
	import modules.game.classes.CardRenderer;
	import modules.game.events.CardSelectedEvent;
	import starling.events.Event;
	import utils.Alert;
	import utils.Colors;
	
	/**
	 * ...
	 * @author Djordje
	 */
	public class MyCardsPopup extends LayoutGroup {
		
		private static const WIDTH:int = 545;
		private static const HEIGHT:int = 595;
		
		private static var _instance:MyCardsPopup = null;
		
		public static function get instance():MyCardsPopup {
			if (_instance == null) {
				_instance = new MyCardsPopup();
			}
			
			return _instance;
		}
		
		private var _selectedCards:Array = [];
		
		private var _callback:Function;
		
		
		private var _tradeButton:LinkButton = new LinkButton();
		private var _closeButton:LinkButton = new LinkButton();
		
		private var _cardsList:List = new List();
		
		public function MyCardsPopup() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			_cardsList.x = 25;
			_cardsList.y = 25;
			_cardsList.width = 495;
			_cardsList.height = 515;
			
			var listLayout:TiledColumnsLayout = new TiledColumnsLayout();
			listLayout.horizontalGap = 15;
			listLayout.verticalGap = 15;
			listLayout.useVirtualLayout = false;
			listLayout.useSquareTiles = false;
			
			_cardsList.layout = listLayout;
			_cardsList.itemRendererFactory = cardRendererItemFactory;
			listLayout.addEventListener(Event.ADDED_TO_STAGE, function listAddedToStage(e:Event):void {
				_cardsList.backgroundSkin.alpha = 0;
			});
			
			this.addChild(_cardsList);
			
			_tradeButton.fontColor = Colors.WHITE;
			_tradeButton.fontSize = 30;
			_tradeButton.x = 550;
			_tradeButton.y = 565;
			_tradeButton.label = "Trade";
			this.addChild(_tradeButton);
			
			_closeButton.fontColor = Colors.WHITE;
			_closeButton.fontSize = 30;
			_closeButton.x = 25;
			_closeButton.y = 565;
			_closeButton.label = "Close";
			this.addChild(_closeButton);
			
			_tradeButton.addEventListener(MouseClickEvent.CLICK, tradeClicked);
			_closeButton.addEventListener(MouseClickEvent.CLICK, closeClicked);
			_cardsList.addEventListener(CardSelectedEvent.CARD_SELECTION_CHANGED, selectionChaged);
		}
		
		private function selectionChaged(e:CardSelectedEvent):void {
			if (e.isSelected) {
				_selectedCards.push(e.card);
			} else {
				for (var i:int = _selectedCards.length - 1; i >= 0; i--) {
					if ((_selectedCards[i] as Card).territoryId == e.card.territoryId) {
						_selectedCards.splice(i, 1);
						break;
					}
				}
			}
		}
		
		private function tradeClicked(e:MouseClickEvent):void {
			if (_selectedCards.length == 3) {
				if (_callback != null) {
					_callback(_selectedCards[0], _selectedCards[1], _selectedCards[2]);
					hidePopup();
				}
			} else {
				Alert.showMessage("", "You have to trade exactly 3 cards");
			}
		}
		
		private function closeClicked(e:MouseClickEvent):void {
			hidePopup();
		}
		
		/** @param myCards - array of Card */
		public function showPopup(myCards:Array, callback:Function):void {
			PopUpManager.addPopUp(this);
			_cardsList.dataProvider = new ListCollection(myCards);
			_selectedCards = [];
			_callback = callback;
		}
		
		public function hidePopup():void {
			PopUpManager.removePopUp(this);
			_callback = null;
		}
		
		private function cardRendererItemFactory():IListItemRenderer {
			return new CardRenderer();
		}
	
	}

}