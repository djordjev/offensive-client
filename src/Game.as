package
{
	import com.demonsters.debugger.MonsterDebugger;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.AeonDesktopTheme;
	import flash.system.Security;
	import modules.control.ControllScreenView;
	import processors.LoginProcessor;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.FacebookCommunicator;
	import utils.Globals;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStage);
		}
		
		public var controllScreenView:ControllScreenView;
		
		private function addedToStage(e:Event):void {
			trace("LOADED");
			// initialize theme
			new AeonDesktopTheme();
			// initialize monster debugger
			MonsterDebugger.initialize(this);
			// allowed domains
			Security.allowDomain("*");
			Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			// store reference in globals
			Globals.instance.game = this;
			// init facebook communicator
			FacebookCommunicator.instance.initialize(Globals.instance.parameters["facebookId"], function mineFacebookInfoInitialized():void {
				// populate view
				populateView();
				
				LoginProcessor.instance.addEventListener(LoginProcessor.LOGIN_COMPLETED, loginFinished);
				LoginProcessor.instance.processLogin();
			});
		}
		
		private function loginFinished(e:Event):void {
			LoginProcessor.instance.removeEventListener(LoginProcessor.LOGIN_COMPLETED, loginFinished);
		}
		
		private function populateView():void {
			controllScreenView = new ControllScreenView;
			this.addChild(controllScreenView);
		}
	}
}