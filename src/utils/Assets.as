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
		
		public static function getProfileImageFrame():Texture {
			return uiAtlas.getTexture("profilePic");
		}
		
		public static function getScrollFriendsNormalImage():Texture {
			return uiAtlas.getTexture("right arrow_normal");
		}
		
		public static function getScrollFriendsOverImage():Texture {
			return uiAtlas.getTexture("right arrow_over");
		}
		
		public static function getBackNormal():Texture {
			return uiAtlas.getTexture("back_normal");
		}
		
		public static function getBackOver():Texture {
			return uiAtlas.getTexture("back_over");
		}
		
		[Embed(source="../../assets/gameAssets/sea.png")]
		public static const SeaBackground:Class;
		
		// Territories maps
		
		[Embed(source="../../assets/gameAssets/territories/territory_1.png")]
		private static const Territory_1:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_2.png")]
		private static const Territory_2:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_3.png")]
		private static const Territory_3:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_4.png")]
		private static const Territory_4:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_5.png")]
		private static const Territory_5:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_6.png")]
		private static const Territory_6:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_7.png")]
		private static const Territory_7:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_8.png")]
		private static const Territory_8:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_9.png")]
		private static const Territory_9:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_10.png")]
		private static const Territory_10:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_11.png")]
		private static const Territory_11:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_12.png")]
		private static const Territory_12:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_13.png")]
		private static const Territory_13:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_14.png")]
		private static const Territory_14:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_15.png")]
		private static const Territory_15:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_16.png")]
		private static const Territory_16:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_17.png")]
		private static const Territory_17:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_18.png")]
		private static const Territory_18:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_19.png")]
		private static const Territory_19:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_20.png")]
		private static const Territory_20:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_21.png")]
		private static const Territory_21:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_22.png")]
		private static const Territory_22:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_23.png")]
		private static const Territory_23:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_24.png")]
		private static const Territory_24:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_25.png")]
		private static const Territory_25:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_26.png")]
		private static const Territory_26:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_27.png")]
		private static const Territory_27:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_28.png")]
		private static const Territory_28:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_29.png")]
		private static const Territory_29:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_30.png")]
		private static const Territory_30:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_31.png")]
		private static const Territory_31:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_32.png")]
		private static const Territory_32:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_33.png")]
		private static const Territory_33:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_34.png")]
		private static const Territory_34:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_35.png")]
		private static const Territory_35:Class;
		
		//[Embed(source="../../assets/gameAssets/territories/territory_36.png")] Missing Siberia
		//private static const Territory_36:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_37.png")]
		private static const Territory_37:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_38.png")]
		private static const Territory_38:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_39.png")]
		private static const Territory_39:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_40.png")]
		private static const Territory_40:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_41.png")]
		private static const Territory_41:Class;
		
		[Embed(source="../../assets/gameAssets/territories/territory_42.png")]
		private static const Territory_42:Class;
		
		public static function getTerritory(id:int):Class {
			return Assets["Territory_" + id];
		}
		
	}

}