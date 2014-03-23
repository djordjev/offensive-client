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

			_myStarling = new Starling(Game, stage, new Rectangle(0, 0, 1024, 768));
			_myStarling.stage.stageWidth = 1024;
			_myStarling.stage.stageHeight = 768;
			_myStarling.antiAliasing = 1;
			_myStarling.start();
			
			/*Communicator.instance.addEventListener(Communicator.SOCKET_CONNECTED, function socketConnected(e:Event):void {
				var getUserData:GetUserDataRequest = new GetUserDataRequest();
				getUserData.userId = Int64.parseInt64(facebookId);
				Communicator.instance.send(HandlerCodes.GET_USER_DATA, getUserData, function handleResponse(message:ProtocolMessage):void {
					var response:GetUserDataResponse = message.data as GetUserDataResponse;
					label.appendText(" received message ");
				});
			});
			Communicator.instance.connect(Settings.HOSTNAME, Settings.PORT);*/
		}
	}
}
