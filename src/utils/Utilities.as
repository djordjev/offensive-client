package utils {
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Utilities {
		
		public function Utilities() {
		
		}
		
		public static function callWhenInitialized(component:FeathersControl, callback:Function):void {
			if (component.isInitialized) {
				if (callback != null) {
					callback();
				}
			} else {
				component.addEventListener(FeathersEventType.INITIALIZE, function componentInitialized(e:Event):void {
						component.removeEventListener(FeathersEventType.INITIALIZE, componentInitialized);
						if (callback != null) {
							callback();
						}
					});
			}
		}
	
	}

}