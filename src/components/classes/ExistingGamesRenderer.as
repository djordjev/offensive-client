package components.classes {
	import components.common.ComponentWithStates;
	import components.common.OLabel;
	import components.common.StatesAdapter;
	import components.events.MouseClickEvent;
	import components.events.OpenGameEvent;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import flash.text.TextFormatAlign;
	import starling.display.Quad;
	import starling.filters.BlurFilter;
	import utils.Colors;
	import utils.States;
	import wrappers.GameContextWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ExistingGamesRenderer extends LayoutGroupListItemRenderer implements ComponentWithStates {
		
		private static const BACKGROUND_QUAD_ALPHA:Number = 0.5;
		private static const WIDTH:int = 215;
		private static const HEIGHT:int = 87;
		
		private var _dirty:Boolean = true;
		
		private var _gameName:OLabel = new OLabel();
		private var _numberOfPlayers:OLabel = new OLabel();
		
		private var _background:Quad = new Quad(WIDTH, HEIGHT, Colors.BLACK);
		private var _glow:BlurFilter;
		
		private var _statesAdapter:StatesAdapter;
		
		public function ExistingGamesRenderer() {
			super();
			_statesAdapter = new StatesAdapter(this);
			_glow = BlurFilter.createGlow(Colors.WHITE);
		}
		
		override public function set data(value:Object):void {
			super.data = value;
			_dirty = true;
		}
		
		public function get dataAsGameContext():GameContextWrapper {
			if (_data is GameContextWrapper) {
				return _data as GameContextWrapper;
			} else {
				return null;
			}
		}
		
		public function changeToUp():void {
			_background.color = Colors.BLACK;
			_background.filter = null;
			this._gameName.fontColor = Colors.WHITE;
			this._numberOfPlayers.fontColor = Colors.WHITE;
			this.invalidate();
		}
		
		public function changeToDown():void {
			_background.color = Colors.WHITE;
			_background.filter = null;
			this._gameName.fontColor = Colors.BLACK;
			this._numberOfPlayers.fontColor = Colors.BLACK;
			this.invalidate();
		}
		
		public function changeToHovered():void {
			_background.color = Colors.WHITE;
			_background.filter = _glow;
			this._gameName.fontColor = Colors.BLACK;
			this._numberOfPlayers.fontColor = Colors.BLACK;
			this.invalidate();
		}
		
		override protected function initialize():void {
			super.initialize();
			this.width = WIDTH;
			this.height = HEIGHT;
			
			_statesAdapter.currentState = States.UP;
			_background.alpha = BACKGROUND_QUAD_ALPHA;
			
			this.addChild(_background);
			
			_gameName.width = WIDTH;
			_gameName.textAlign = TextFormatAlign.CENTER;
			_gameName.y = 5;
			_gameName.fontSize = 20;
			_gameName.font = OLabel.FONT_GEARS_OF_PACE;
			_gameName.fontColor = Colors.WHITE;
			this.addChild(_gameName);
			
			_numberOfPlayers.width = WIDTH;
			_numberOfPlayers.textAlign = TextFormatAlign.CENTER;
			_numberOfPlayers.y = 45;
			_numberOfPlayers.fontSize = 12;
			_numberOfPlayers.font = OLabel.FONT_GEARS_OF_PACE;
			_numberOfPlayers.fontColor = Colors.WHITE;
			this.addChild(_numberOfPlayers);
			
			this.useHandCursor = true;
			
			addEventListener(MouseClickEvent.CLICK, clickHandler);
		}
		
		private function clickHandler(e:MouseClickEvent):void {
			this.dispatchEvent(new OpenGameEvent(OpenGameEvent.OPEN_GAME, dataAsGameContext, true));
		}
		
		override protected function commitData():void {
			if (_dirty && dataAsGameContext != null) {
				_gameName.text = dataAsGameContext.gameName;
				_numberOfPlayers.text = "PLAYERS IN GAME: " +  dataAsGameContext.numberOfJoinedPlayers + 
																"/" + dataAsGameContext.numberOfPlayers;
				_dirty = false;
			}
			
			super.commitData();
		}
	
	}

}