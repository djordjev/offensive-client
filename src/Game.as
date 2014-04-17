package
{
	import com.demonsters.debugger.MonsterDebugger;
	import communication.Me;
	import components.common.OffensiveScreenNavigator;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.AeonDesktopTheme;
	import flash.system.Security;
	import modules.control.ControllScreenView;
	import modules.game.GameView;
	import processors.LoginProcessor;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.FacebookCommunicator;
	import utils.Globals;
	import utils.Screens;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStage);
		}
		
		public var controllScreenView:ControllScreenView;
		public var gameScreenView:GameView;
		
		public var screenNavigator:ScreenNavigator;
		
		private function addedToStage(e:Event):void {
			trace("LOADED");
			// initialize theme
			new AeonDesktopTheme();
			// initialize monster debugger
			MonsterDebugger.initialize(this);
			// allowed domains
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			Security.loadPolicyFile("https://profile.ak.fbcdn.net/crossdomain.xml");
			Security.loadPolicyFile("https://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
			// store reference in globals
			Globals.instance.game = this;
			// create user if
			Me.instance.initialize(Globals.instance.parameters["userId"]);
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
			controllScreenView = new ControllScreenView();
			gameScreenView = new GameView();
			
			screenNavigator = new OffensiveScreenNavigator();
			screenNavigator.width = 1024;
			screenNavigator.height = 768;
			
			screenNavigator.addScreen(Screens.MENUS, new ScreenNavigatorItem(controllScreenView));
			screenNavigator.addScreen(Screens.GAME, new ScreenNavigatorItem(gameScreenView));
			
			this.addChild(screenNavigator);
			screenNavigator.showScreen(Screens.MENUS);
		}
	}
}