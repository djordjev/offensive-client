package modules.base 
{
	import feathers.core.FeathersControl;
	import starling.events.Event;
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class BaseController 
	{
		protected var _view:FeathersControl;
		
		protected var _model:BaseModel;
		
		public function BaseController(view:FeathersControl, model:BaseModel) {
			_view = view;
			_model = model;
			
			if (_view.isInitialized) {
				viewInitialized();
			} else {
				_view.addEventListener(Event.ADDED_TO_STAGE, viewInitialized);
			}
		}
		
		private function viewInitialized(e:Event=null):void {
			addHandlers();
			initializeView();
		}
		
		protected function addHandlers():void {
		}
		
		protected function initializeView():void {
		}
		
	}

}