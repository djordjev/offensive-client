package components {
	import components.common.LinkButton;
	import components.common.OLabel;
	import components.events.MouseClickEvent;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Slider;
	import feathers.core.PopUpManager;
	import starling.display.Quad;
	import starling.events.Event;
	import utils.Assets;
	import utils.Colors;
	import wrappers.PlayerWrapper;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AttackPopup extends LayoutGroup {
		
		public static const ATTACK_CANCELED:int = 0;
		
		private static const ATTACK_POPUP_WIDTH:int = 300;
		private static const ATTACK_POPUP_HEIGHT:int = 150;
		
		private var _myImage:ImageLoader = new ImageLoader();
		private var _opponentImage:ImageLoader = new ImageLoader();
		
		private var _myName:OLabel = new OLabel();
		private var _opponentName:OLabel = new OLabel();
		
		private var _myTerritoryName:OLabel = new OLabel();
		private var _opponentTerritoryName:OLabel = new OLabel();
		
		private var _okButton:LinkButton = new LinkButton();
		private var _cancelButton:LinkButton = new LinkButton();
		
		private var _plusButton:LinkButton = new LinkButton();
		private var _minusButton:LinkButton = new LinkButton();
		
		private var _unitsInAttack:OLabel = new OLabel();
		
		private var _maxUnitsToAttack:uint;
		private var _currentUnitsToAttack:uint;
		
		private var _callback:Function;
		
		private static var _instance:AttackPopup;
		
		public static function get instance():AttackPopup {
			if (_instance == null) {
				_instance = new AttackPopup();
			}
			return _instance;
		}
		
		
		public function AttackPopup() {
			super();
		}
		
		private function creationComplete():void {
			_plusButton.addEventListener(MouseClickEvent.CLICK, addOneUnit);
			_minusButton.addEventListener(MouseClickEvent.CLICK, removeOneUnit);
			_cancelButton.addEventListener(MouseClickEvent.CLICK, cancelAttack);
			_okButton.addEventListener(MouseClickEvent.CLICK, confirmAttack);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			var background:Quad = new Quad(ATTACK_POPUP_WIDTH, ATTACK_POPUP_HEIGHT, Colors.BLACK);
			background.alpha = 0.8;
			this.addChild(background);
			
			_myImage.x = 22;
			_myImage.y = 12;
			this.addChild(_myImage);
			
			_myName.x = 13;
			_myName.y = 70;
			_myName.fontColor = Colors.WHITE;
			this.addChild(_myName);
			
			_opponentImage.x = 228;
			_opponentImage.y = 12;
			this.addChild(_opponentImage);
			
			_opponentName.x = 204;
			_opponentName.y = 70;
			_opponentName.fontColor = Colors.WHITE;
			this.addChild(_opponentName);
			
			_myTerritoryName.x = 15;
			_myTerritoryName.y = 90;
			_myTerritoryName.fontColor = Colors.WHITE;
			this.addChild(_myTerritoryName);
			
			_opponentTerritoryName.x = 210;
			_opponentTerritoryName.y = 90;
			_opponentTerritoryName.fontColor = Colors.WHITE;
			this.addChild(_opponentTerritoryName);
			
			_plusButton.label = "+";
			_plusButton.fontSize = 36;
			_plusButton.x = 100;
			_plusButton.y = 10;
			_plusButton.fontColor = Colors.WHITE;
			this.addChild(_plusButton);
			
			_minusButton.label = "-";
			_minusButton.fontSize = 36;
			_minusButton.x = 160;
			_minusButton.y = 10;
			_minusButton.fontColor = Colors.WHITE;
			this.addChild(_minusButton);
			
			_unitsInAttack.fontSize = 36;
			_unitsInAttack.x = 130;
			_unitsInAttack.y = 50;
			_unitsInAttack.fontColor = Colors.WHITE;
			this.addChild(_unitsInAttack);
			
			_okButton.label = "Confirm";
			_okButton.x = 165;
			_okButton.y = 110;
			_okButton.fontColor = Colors.WHITE;
			this.addChild(_okButton);
			
			_cancelButton.label = "Cancel";
			_cancelButton.x = 20;
			_cancelButton.y = 110;
			_cancelButton.fontColor = Colors.WHITE;
			this.addChild(_cancelButton);
			
			creationComplete();
		}
		
		public function showAttackDialog(territoryFrom:TerritoryWrapper, territoryTo:TerritoryWrapper, callback:Function):void {
										
			var me:PlayerWrapper = territoryFrom.owner;
			var opponent:PlayerWrapper = territoryTo.owner;
			if (me.userWrapper.facebookUser != null) {
				_myImage.source = me.userWrapper.facebookUser.smallImageURL;
				_myName.text = me.userWrapper.facebookUser.name;
			} else {
				_myImage.source = Assets.getNonFBUserAvatar();
				_myName.text = me.userWrapper.userId.toString();
			}
			
			if (opponent.userWrapper.facebookUser != null) {
				_opponentImage.source = opponent.userWrapper.facebookUser.smallImageURL;
				_opponentName.text = opponent.userWrapper.facebookUser.name;
			} else {
				_opponentImage.source = Assets.getNonFBUserAvatar();
				_opponentName.text = opponent.userWrapper.userId.toString();
			}
			
			_myTerritoryName.text = territoryFrom.name;
			_opponentTerritoryName.text = territoryTo.name;
			
			_maxUnitsToAttack = territoryFrom.troopsOnIt - 1;
			_currentUnitsToAttack = 1;
			_unitsInAttack.text = _currentUnitsToAttack.toString();
			
			_callback = callback;
			
			PopUpManager.addPopUp(this);
		}
		
		private function addOneUnit(event:MouseClickEvent):void {
			if (_currentUnitsToAttack + 1 <= _maxUnitsToAttack) {
				_currentUnitsToAttack++;
				_unitsInAttack.text = _currentUnitsToAttack.toString();
			}
		}
		
		private function removeOneUnit():void {
			if (_currentUnitsToAttack > 1) {
				_currentUnitsToAttack--;
				_unitsInAttack.text = _currentUnitsToAttack.toString();
			}
		}
		
		private function cancelAttack(e:MouseClickEvent):void {
			if (_callback != null) {
				_callback(ATTACK_CANCELED);
			}
			_callback = null;
			PopUpManager.removePopUp(this);
		}
		
		private function confirmAttack(e:MouseClickEvent):void {
			if (_callback != null) {
				_callback(_currentUnitsToAttack);
			}
			_callback = null;
			PopUpManager.removePopUp(this);
		}
	
	}

}