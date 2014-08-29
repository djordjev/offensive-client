package components.events {
	import components.common.LinkButton;
	import components.common.OLabel;
	import feathers.controls.LayoutGroup;
	import feathers.core.PopUpManager;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import starling.display.Quad;
	import utils.Colors;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class RelocatePopup extends LayoutGroup {
		
		private static const RELOCATION_POPUP_WIDTH:int = 300;
		private static const RELOCATION_POPUP_HEIGHT:int = 150;
		
		private static var _instance:RelocatePopup = null;
		
		public static function get instance():RelocatePopup {
			if (_instance == null) {
				_instance = new RelocatePopup();
			}
			
			return _instance;
		}
		
		private var _fromTerritoryName:OLabel = new OLabel();
		private var _toTerritoryName:OLabel = new OLabel();
		
		private var _addUnit:LinkButton = new LinkButton();
		private var _removeUnit:LinkButton = new LinkButton();
		
		private var _fromTerritoryNumberOfUnits:OLabel = new OLabel();
		private var _toTerritoryNumberOfUnits:OLabel = new OLabel();
		private var _unitsMove:OLabel = new OLabel();
		
		private var _okButton:LinkButton = new LinkButton();
		private var _cancelButton:LinkButton = new LinkButton();
		
		private var _unitsOnFrom:int = 0;
		private var _unitsOnTo:int = 0;
		private var _unitsMoving:int = 0;
		
		private var _callback:Function;
		
		public function RelocatePopup() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			var background:Quad = new Quad(RELOCATION_POPUP_WIDTH, RELOCATION_POPUP_HEIGHT, Colors.BLACK);
			background.alpha = 0.8;
			this.addChild(background);
			
			_fromTerritoryName.fontColor = Colors.WHITE;
			_fromTerritoryName.fontSize = 16;
			
			_toTerritoryName.fontColor = Colors.WHITE;
			_toTerritoryName.fontSize = 16;
			
			_addUnit.fontColor = Colors.WHITE;
			_addUnit.fontSize = 36;
			_addUnit.label = "+";
			
			_removeUnit.fontColor = Colors.WHITE;
			_removeUnit.fontSize = 36;
			_removeUnit.label = "-";
			
			_fromTerritoryNumberOfUnits.fontColor = Colors.WHITE;
			_fromTerritoryNumberOfUnits.fontSize = 16;
			
			_toTerritoryNumberOfUnits.fontColor = Colors.WHITE;
			_toTerritoryNumberOfUnits.fontSize = 16;
			
			_unitsMove.fontColor = Colors.WHITE;
			_unitsMove.fontSize = 16;
			
			var completeView:LayoutGroup = new LayoutGroup();
			completeView.layout = new HorizontalLayout();
			(completeView.layout as HorizontalLayout).gap = 10;
			this.addChild(completeView);
			
			var fromTerritoryGroup:LayoutGroup = new LayoutGroup();
			fromTerritoryGroup.layout = new VerticalLayout();
			(fromTerritoryGroup.layout as VerticalLayout).gap = 10;
			completeView.addChild(fromTerritoryGroup);
			
			fromTerritoryGroup.addChild(_fromTerritoryName);
			fromTerritoryGroup.addChild(_fromTerritoryNumberOfUnits);
			
			var middleGroup:LayoutGroup = new LayoutGroup();
			middleGroup.layout = new VerticalLayout();
			(middleGroup.layout as VerticalLayout).gap = 10;
			completeView.addChild(middleGroup);
			
			var controlsGroup:LayoutGroup = new LayoutGroup();
			controlsGroup.layout = new HorizontalLayout();
			(controlsGroup.layout as HorizontalLayout).gap = 5;
			middleGroup.addChild(controlsGroup);
			
			controlsGroup.addChild(_addUnit);
			controlsGroup.addChild(_removeUnit);
			
			middleGroup.addChild(_unitsMove);
			
			var opponentTerritoryGroup:LayoutGroup = new LayoutGroup();
			opponentTerritoryGroup.layout = new VerticalLayout();
			(opponentTerritoryGroup.layout as VerticalLayout).gap = 10;
			completeView.addChild(opponentTerritoryGroup);
			
			opponentTerritoryGroup.addChild(_toTerritoryName);
			opponentTerritoryGroup.addChild(_toTerritoryNumberOfUnits);
			
			_addUnit.addEventListener(MouseClickEvent.CLICK, clickOnAdd);
			_removeUnit.addEventListener(MouseClickEvent.CLICK, clickOnRemove);
			
			_okButton.x = 30;
			_okButton.y = 100;
			_okButton.fontColor = Colors.WHITE;
			_okButton.fontSize = 25;
			_okButton.label = "Move";
			this.addChild(_okButton);
			
			_cancelButton.x = 200;
			_cancelButton.y = 100;
			_cancelButton.fontColor = Colors.WHITE;
			_cancelButton.fontSize = 25;
			_cancelButton.label = "Cancel";
			this.addChild(_cancelButton);
		}
		
		private function clickOnAdd(e:MouseClickEvent):void {
			if (_unitsOnFrom > 1) {
				_unitsOnFrom--;
				_unitsOnTo++;
				_unitsMoving++;
				
				updateNumberOfUnitsView();
			}
		}
		
		private function clickOnRemove(e:MouseClickEvent):void {
			if (_unitsMoving > 0) {
				_unitsMoving--;
				_unitsOnTo--;
				_unitsOnFrom++;
				
				updateNumberOfUnitsView();
			}
		}
		
		private function updateNumberOfUnitsView():void {
			_fromTerritoryNumberOfUnits.text = _unitsOnFrom.toString();
			_toTerritoryNumberOfUnits.text = _unitsOnTo.toString();
			_unitsMove.text = _unitsMoving.toString();
		}
		
		private function cancelClicked(e:MouseClickEvent):void {
			PopUpManager.removePopUp(this);
		}
		
		private function okClicked(e:MouseClickEvent):void {
			if (this._callback != null) {
				this._callback(_unitsMoving);
			}
			PopUpManager.removePopUp(this);
		}
		
		public function showRelocationPopup(territoryFrom:TerritoryWrapper, territoryTo:TerritoryWrapper, callback:Function):void {
			_unitsOnFrom = territoryFrom.troopsOnIt;
			_unitsOnTo = territoryTo.troopsOnIt;
			_unitsMoving = 0;
			
			updateNumberOfUnitsView();
			
			_fromTerritoryName.text = territoryFrom.name;
			_toTerritoryName.text = territoryTo.name;
			
			_callback = callback;
			
			PopUpManager.addPopUp(this);
		}
	
	}

}