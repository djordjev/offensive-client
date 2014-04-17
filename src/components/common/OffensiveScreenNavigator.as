package components.common 
{
	import feathers.controls.ScreenNavigator;
	import feathers.motion.transitions.ScreenFadeTransitionManager;
	import starling.animation.Transitions;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class OffensiveScreenNavigator extends ScreenNavigator 
	{
		private static const DURATION:Number = 1;
		
		private var _transitionManager:ScreenFadeTransitionManager;
		
		public function OffensiveScreenNavigator() {
			super();
			_transitionManager = new ScreenFadeTransitionManager(this);
			_transitionManager.duration = DURATION;
			_transitionManager.ease = Transitions.EASE_OUT_BACK;
		}
		
		
	}

}