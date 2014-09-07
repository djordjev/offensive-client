package components.classes {
	import components.common.OLabel;
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import flash.text.TextFormatAlign;
	import starling.display.Quad;
	import utils.Assets;
	import utils.Colors;
	import utils.FacebookCommunicator;
	import utils.PlayerColors;
	import wrappers.FacebookUser;
	import wrappers.PlayerWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class PlayerRenderer extends LayoutGroupListItemRenderer {
		
		private static const WIDTH:int = 100;
		private static const HEIGHT:int = 130;
		private static const BACKGROUND_ALPHA:Number = 0.35;
		
		private var _dirty:Boolean = true;
		
		private var _background:Quad;
		private var _playerImage:ImageLoader = new ImageLoader();
		private var _playerName:OLabel = new OLabel();
		private var _playerTerritories:OLabel = new OLabel();
		private var _cards:OLabel = new OLabel();
		private var _alliance:Button = new Button();
		
		public function PlayerRenderer() {
			super();
		}
		
		public function get dataAsPlayersWrapper():PlayerWrapper {
			return _data as PlayerWrapper;
		}
		
		override public function set data(value:Object):void {
			super.data = value;
			_dirty = true;
		}
		
		override protected function commitData():void {
			if (_dirty) {
				_background.color = PlayerColors.getColor(dataAsPlayersWrapper.color);
				if (dataAsPlayersWrapper.isDummy) {
					// this is dummy player. That means that this user is not joined yet.
					_playerImage.source = Assets.getMissingUserAvatar();
					_playerName.text = "Waiting for player";
				} else if (dataAsPlayersWrapper.userWrapper.facebookUser != null) {
					// it this is facebook user
					// request facebook info
					FacebookCommunicator.instance.requestFBUserInfo(dataAsPlayersWrapper.userWrapper.facebookUser.facebookId, 
						function receivedFacebookUser(fbUser:FacebookUser):void {
							dataAsPlayersWrapper.userWrapper.facebookUser = fbUser;
							
							_playerImage.source = dataAsPlayersWrapper.userWrapper.facebookUser.smallImageURL;
							_playerName.text = dataAsPlayersWrapper.userWrapper.facebookUser.name;
						});
				} else {
					// this is not facebook user
					_playerImage.source = Assets.getNonFBUserAvatar();
					_playerName.text = dataAsPlayersWrapper.userWrapper.userId.toString();
				}
				
				_playerTerritories.text = "Territories: " + dataAsPlayersWrapper.numberOfTerritories;
				_cards.text = "Cards: " + dataAsPlayersWrapper.cardsNumber;
				_dirty = false;
			}
			super.commitData();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			this.width = WIDTH;
			this.height = HEIGHT;
			
			_background = new Quad(WIDTH, HEIGHT, Colors.BLACK);
			_background.alpha = BACKGROUND_ALPHA;
			this.addChild(_background);
			
			_playerImage.x = 25;
			_playerImage.y = 6;
			_playerImage.width = 50;
			_playerImage.height = 50;
			this.addChild(_playerImage);
			
			_playerName.fontSize = 10;
			_playerName.x = 5;
			_playerName.y = 58;
			_playerName.width = WIDTH - 10;
			_playerName.textAlign = TextFormatAlign.CENTER;
			this.addChild(_playerName);
			
			_playerTerritories.fontSize = 10;
			_playerTerritories.x = 5;
			_playerTerritories.y = 77;
			_playerTerritories.width = WIDTH - 10;
			_playerTerritories.textAlign = TextFormatAlign.LEFT;
			this.addChild(_playerTerritories);
			
			_cards.fontSize = 10;
			_cards.x = 5;
			_cards.y = 96;
			_cards.width = WIDTH - 10;
			_cards.textAlign = TextFormatAlign.LEFT;
			this.addChild(_cards);
			
			_alliance.width = 80;
			_alliance.y = 104;
			_alliance.x = 10;
			_alliance.label = "Alliance";
			//this.addChild(_alliance);
		}
	
	}

}