package components.classes {
	import communication.protos.GameContext;
	import components.common.ComponentWithStates;
	import components.common.StatesAdapter;
	import components.events.MouseClickEvent;
	import components.events.OpenGameEvent;
	import feathers.controls.Label;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import flash.geom.Point;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import utils.States;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class ExistingGamesRenderer extends LayoutGroupListItemRenderer implements ComponentWithStates{
		
		private var _dirty:Boolean = true;
		
		private var _gameInfo:Label = new Label();
		private var _background:Quad = new Quad(150, 80, 0xFFFF00);
		
		private var _statesAdapter:StatesAdapter;
		
		public function ExistingGamesRenderer() {
			super();
			_statesAdapter = new StatesAdapter(this);
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
		
		public function changeToUp():void {
			_background.color = 0xFFFF00;
			this.invalidate();
		}
		
		public function changeToDown():void {
			_background.color = 0x00FF00;
			this.invalidate();
		}
		
		public function changeToHovered():void {
			_background.color = 0xFF8000;
			this.invalidate();
		}
		
		override protected function initialize():void {
			super.initialize();
			this.width = 150;
			this.height = 80;
			
			_statesAdapter.currentState = States.UP;
			
			this.addChild(_background);
			this.addChild(_gameInfo);
			
			this.useHandCursor = true;
			
			_statesAdapter.addEventListener(MouseClickEvent.CLICK, clickHandler);
		}
		
		private function clickHandler(e:MouseClickEvent):void {
			this.dispatchEvent(new OpenGameEvent(OpenGameEvent.OPEN_GAME, dataAsGameContext, true));
		}
		
		override protected function commitData():void {
			if (_dirty && dataAsGameContext != null) {
				_gameInfo.text = dataAsGameContext.lightGameContext.gameDescription.gameName + " " + dataAsGameContext.lightGameContext.gameDescription.numberOfPlayers;
				_dirty = false;
			}
			super.commitData();
		}
	
	}

}