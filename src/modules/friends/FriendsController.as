package modules.friends 
{
	import components.events.MouseClickEvent;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import modules.base.BaseController;
	import modules.base.BaseModel;
	import starling.events.Event;
	import utils.FacebookCommunicator;
	import utils.Globals;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class FriendsController extends BaseController 
	{
		private static const FRIENDS_DISPLAYED:int = 6;
		
		private static var _instance:FriendsController;
		
		public static function get instance():FriendsController {
			if (_instance == null) {
				_instance = new FriendsController(Globals.instance.game.controllScreenView.friendsView, FriendsModel.instance);
			}
			return _instance;
		}
		
		public function FriendsController(view:FeathersControl, model:BaseModel) 
		{
			super(view, model);
		}
		
		public function get view():FriendsView {
			return _view as FriendsView;
		}
		
		public function get model():FriendsModel {
			return _model as FriendsModel;
		}
		
		override protected function addHandlers():void 
		{
			view.leftScrollButton.addEventListener(MouseClickEvent.CLICK, leftScrollClicked);
			view.rightScrollButton.addEventListener(MouseClickEvent.CLICK, rightScrollClicked);
		}
		
		override protected function initializeView():void {
			// request friends from facebook
			if (FacebookCommunicator.instance.isMeFacebookUser) {
				FacebookCommunicator.instance.requestMyFriendsList(function friendsListReceive(friends:Array):void {
					// received friends from facebook
					var friendsIds:Array = [];
					for each(var oneFriend:Object in friends) {
						friendsIds.push(oneFriend.id as String);
					}
					model.filterFriends(friendsIds, gatheringFriendsFinished);
				});
			}
		}
		
		private function leftScrollClicked(e:Event):void {
			var targetPostion:Number = Math.max(0, view.friendsList.horizontalScrollPosition - 130);
			view.friendsList.scrollToPosition(targetPostion, view.friendsList.verticalScrollPosition, 0.5);
		}
		
		private function rightScrollClicked(e:Event):void {
			var targetPostion:Number = Math.min(view.friendsList.maxHorizontalScrollPosition, view.friendsList.horizontalScrollPosition + 130);
			view.friendsList.scrollToPosition(targetPostion, view.friendsList.verticalScrollPosition, 0.5);
		}
		
		private function gatheringFriendsFinished():void {
			view.friendsList.dataProvider = new ListCollection(model.friends);
		}
		
	}
}