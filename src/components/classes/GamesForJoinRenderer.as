package components.classes 
{
	import communication.protos.GameContext;
	import communication.protos.GameDescription;
	import feathers.controls.Label;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GamesForJoinRenderer extends LayoutGroupListItemRenderer 
	{
		
		private var _dirty:Boolean = true;
		
		private var _displayLabel:Label = new Label();
		
		private function get dataAsGameDescription():GameDescription {
			return _data as GameDescription;
		}
		
		override public function set data(value:Object):void {
			super.data = value;
			_dirty = true;
		}
		
		public function GamesForJoinRenderer() {
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			this.width = 250;
			this.height = 50;
			this.addChild(_displayLabel);
		}
		
		override protected function commitData():void 
		{
			if (_dirty) {
				_displayLabel.text = dataAsGameDescription.gameName + " " + 
					dataAsGameDescription.numberOfJoinedPlayers + "/" + dataAsGameDescription.numberOfPlayers;
				_dirty = false;
			}
			super.commitData();
		}
		
	}

}