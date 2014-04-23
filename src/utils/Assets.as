package utils 
{
	import components.GameActionsDialog;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public dynamic class Assets 
	{
		public function Assets() {	
		}
		
		[Embed(source="../../assets/fonts/GearsOfPeace.ttf", fontName="GearsOfPace", mimeType="application/x-font", embedAsCFF="true")]
		public static const GearsOfPaceFont:Class;
		
		[Embed(source="../../assets/gameAssets/MainBackground.jpg")]
		private static const MainControlsBackground:Class;
		
		[Embed(source="../../assets/gameAssets/CreateOpenGameBackground.jpg")]
		private static const CreateOpenGameBackground:Class;
		
		[Embed(source="../../assets/gameAssets/CreatePrivateGameBackground.jpg")]
		private static const CreatePrivateGameBackground:Class;
		
		[Embed(source="../../assets/gameAssets/JoinGameBackground.jpg")]
		private static const JoinGameBackground:Class;
		
		public static function getBackgroundImage(gameActionState:String):Class {
			switch(gameActionState) {
				case GameActionsDialog.STATE_MENU:
					return MainControlsBackground;
				case GameActionsDialog.STATE_OPEN_GAME:
					return CreateOpenGameBackground;
				case GameActionsDialog.STATE_PRIVATE_GAME:
					return CreatePrivateGameBackground;
				case GameActionsDialog.STATE_JOIN_GAME:
					return JoinGameBackground;
				default:
					return null;
			}
		}
		
		
	}

}