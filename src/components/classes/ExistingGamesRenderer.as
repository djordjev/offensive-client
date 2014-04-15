package components.classes {
	import communication.protos.GameContext;
	import feathers.controls.Label;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import flash.geom.Point;
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import utils.States;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ExistingGamesRenderer extends LayoutGroupListItemRenderer {
		
		private static const HELPER_POINT:Point = new Point();
		
		private var _dirty:Boolean = true;
		
		private var _gameInfo:Label = new Label();
		private var _background:Quad = new Quad(150, 80, 0xFFFF00);
		
		private var _currentState:int = States.UP;
		
		public function ExistingGamesRenderer() {
			super();
		}
		private function get currentState():int {
			return _currentState;
		}
		
		private function set currentState(value:int):void {
			_currentState = value;
			switch(_currentState) {
				case States.UP:
					_background.color = 0xFFFF00;
					break;
				case States.HOVERED:
					_background.color = 0xFF8000;
					break;
				case States.DOWN:
					_background.color = 0x00FF00;
					break;
				default:
					break;
			}
			this.invalidate();
		}
		
		override public function set data(value:Object):void {
			super.data = value;
			_dirty = true;
		}
		
		public function get dataAsGameContext():GameContext {
			if (_data is GameContext) {
				return _data as GameContext;
			} else {
				return null;
			}
		}
		
		override protected function initialize():void {
			super.initialize();
			this.width = 150;
			this.height = 80;
			
			currentState = States.UP;
			
			this.addChild(_background);
			this.addChild(_gameInfo);
			
			this.useHandCursor = true;
			
			this.addEventListener(TouchEvent.TOUCH, touchListener);
		}
		
		override protected function commitData():void {
			if (_dirty && dataAsGameContext != null) {
				_gameInfo.text = dataAsGameContext.lightGameContext.gameDescription.gameName + " " + dataAsGameContext.lightGameContext.gameDescription.numberOfPlayers;
				_dirty = false;
			}
			super.commitData();
		}
		
		private function touchListener(e:TouchEvent):void {
			var touch:Touch = e.getTouch(this, TouchPhase.BEGAN);
			if (touch != null) {
				this.currentState = States.DOWN;
				trace("TOUCHED");
				return;
			}
			
			touch = e.getTouch(this, TouchPhase.HOVER);
			if (touch != null) {
				this.currentState = States.HOVERED;
				return;
			}
			
			touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch != null) {
				touch.getLocation(this.stage, HELPER_POINT);
				var isInBounds:Boolean = this.contains(this.stage.hitTest(HELPER_POINT, true));
				if (isInBounds) {
					this.currentState = States.HOVERED;
				} else {
					this.currentState = States.UP;
				}
			}
			
			this.currentState = States.UP;
		}
	
	}

}