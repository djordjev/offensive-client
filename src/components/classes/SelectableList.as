package components.classes {
	import components.events.MouseClickEvent;
	import feathers.controls.List;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class SelectableList extends List {
		public function SelectableList() {
			super();
			this.addEventListener(MouseClickEvent.CLICK, clickHandler);
		}
		
		private function clickHandler(e:MouseClickEvent):void {
			this.invalidate();
		}
		
		
	
	}

}