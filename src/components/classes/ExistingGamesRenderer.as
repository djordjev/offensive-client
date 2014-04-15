package components.classes {
	import communication.protos.GameContext;
	import feathers.controls.Label;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ExistingGamesRenderer extends LayoutGroupListItemRenderer {
		
		private var _dirty:Boolean = true;
		
		private var _gameInfo:Label = new Label();
		
		public function ExistingGamesRenderer() {
			super();
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
		
		override protected function initialize():void 
		{
			super.initialize();
			this.width = 150;
			this.height = 80;
			var background:Quad = new Quad(150, 80, 0xFFFF00);
			this.addChild(background);
			
			this.addChild(_gameInfo);
		}
		
		override protected function commitData():void {
			trace("commit data");
			if (_dirty && dataAsGameContext != null) {
				_gameInfo.text = dataAsGameContext.lightGameContext.gameDescription.gameName + " " + dataAsGameContext.lightGameContext.gameDescription.numberOfPlayers;
				_dirty = false;
			}
			super.commitData();
		}
	
	}

}