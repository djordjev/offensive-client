package {
	import com.demonsters.debugger.MonsterDebugger;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import net.hires.debug.Stats;
	import starling.core.Starling;
	import utils.Globals;

	public class Main extends Sprite {
		private var _stats:Stats;

		private var _myStarling:Starling;

		public function Main() {
			_stats = new Stats();
			this.addChild(_stats);
			
			Globals.instance.parameters = this.root.loaderInfo.parameters;
			Starling.multitouchEnabled = false;

			_myStarling = new Starling(Game, stage, new Rectangle(0, 0, 1024, 768));
			_myStarling.simulateMultitouch = false;
			_myStarling.stage.stageWidth = 1024;
			_myStarling.stage.stageHeight = 768;
			_myStarling.antiAliasing = 1;
			_myStarling.start();
		}
	}
}
