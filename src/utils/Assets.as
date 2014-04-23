package utils 
{
	import components.GameActionsDialog;
	import flash.display.Bitmap;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
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
		
		[Embed(source="../../assets/gameAssets/backgroundFade.png")]
		public static const BackgroundFade:Class;
		
		[Embed(source="../../assets/gameAssets/uiAtlas.xml", mimeType="application/octet-stream")]
		private static const uiAtlasXML:Class;
		
		[Embed(source="../../assets/gameAssets/uiAtlas.png")]
		private static const uiTextures:Class;
		
		private static var _uiAtlas:TextureAtlas;
		
		public static function get uiAtlas():TextureAtlas {
			if (_uiAtlas == null) {
				var texture:Texture = Texture.fromBitmap(new uiTextures());
				var xml:XML = XML(new uiAtlasXML());
				_uiAtlas = new TextureAtlas(texture, xml);
			}
			
			return _uiAtlas;
		}
		
		public static function getPofileImageFrame():Texture {
			return uiAtlas.getTexture("profilePic");
		}
	}

}