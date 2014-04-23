package components.common 
{
	import components.events.MouseClickEvent;
	import feathers.core.FeathersControl;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import utils.States;
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class StatesAdapter extends EventDispatcher
	{
		private static const HELPER_POINT:Point = new Point();
		private var _targetComponent:ComponentWithStates;
		
		private var _currentState:int = States.UP;
		
		private var _inDownState:Boolean = false;
		
		public function StatesAdapter(targetComponent:ComponentWithStates) {
			if(targetComponent != null) {
				_targetComponent = targetComponent;
				_targetComponent.addEventListener(TouchEvent.TOUCH, touchListener);
			} else {
				throw new Error("Added null as target component to StatesAdapter");
			}
			
		}
		
		public function get currentState():int {
			return _currentState;
		}
		
		public function set currentState(value:int):void {
			if (value != _currentState) {
				_currentState = value;
				switch(_currentState) {
					case States.UP:
						_targetComponent.changeToUp();
						break;
					case States.DOWN:
						_targetComponent.changeToDown();
						break;
					case States.HOVERED:
						_targetComponent.changeToHovered();
						break;
					default:
						break;
				}
			}
		}
		
		private function touchListener(e:TouchEvent):void {
			var targetDOC:DisplayObjectContainer = _targetComponent as DisplayObjectContainer;
			var touch:Touch = e.getTouch(targetDOC, TouchPhase.BEGAN);
			if (touch != null) {
				this.currentState = States.DOWN;
				_inDownState = true;
				return;
			}
			
			touch = e.getTouch(targetDOC, TouchPhase.HOVER);
			if (touch != null) {
				this.currentState = States.HOVERED;
				return;
			}
			
			touch = e.getTouch(targetDOC, TouchPhase.ENDED);
			if (touch != null) {
				touch.getLocation(targetDOC.stage, HELPER_POINT);
				var isInBounds:Boolean = targetDOC.contains(targetDOC.stage.hitTest(HELPER_POINT, true));
				if (isInBounds) {
					this.currentState = States.HOVERED;
					if (_inDownState) {
						targetDOC.dispatchEvent(new MouseClickEvent(MouseClickEvent.CLICK, targetDOC as FeathersControl, true));
					}
				} else {
					this.currentState = States.UP;
				}
				
				_inDownState = false;
			}
			
			this.currentState = States.UP;
		}
		
	}

}