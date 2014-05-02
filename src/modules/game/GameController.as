package modules.game {
	import communication.protos.GameContext;
	import communication.protos.Territory;
	import feathers.core.FeathersControl;
	import modules.base.BaseController;
	import modules.base.BaseModel;
	import modules.game.classes.Territories;
	import starling.events.Event;
	import utils.Globals;
	import utils.Screens;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class GameController extends BaseController {
		
		private static var _instance:GameController;
		
		public static function get instance():GameController {
			if (_instance == null) {
				_instance = new GameController(Globals.instance.game.gameScreenView, GameModel.instance);
			}
			
			return _instance;
		}
		
		public function get model():GameModel {
			return _model as GameModel;
		}
		
		public function get view():GameView {
			return _view as GameView;
		}
		
		public function GameController(view:FeathersControl, model:BaseModel) {
			super(view, model);
		}
		
		override protected function addHandlers():void {
			view.backButton.addEventListener(Event.TRIGGERED, goBack);
		}
		
		private function goBack(e:Event):void {
			mainScreenNavigator.showScreen(Screens.MENUS);
		}
		
		public function initForGame(gameContext:GameContext):void {
			model.initForGame(gameContext);
			
			for (var i:int = 1; i <= Territories.NUMBER_OF_TERRITORIES; i++) {
				var t:Territory = new Territory();
				t.id = i;
				view.getTerritoryVisual(i).territory = new TerritoryWrapper(t);
			}
			
			var t:Territory = new Territory();
			t.id = 1;
			var tw:TerritoryWrapper = new TerritoryWrapper(t);
			
			view.getTerritoryVisual(1).territory = tw;
		}
	
	}

}