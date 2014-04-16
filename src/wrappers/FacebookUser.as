package wrappers 
{
	import flash.utils.Dictionary;
	import mx.utils.StringUtil;
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class FacebookUser 
	{
		/** Mapping facebookId to FacebookUser */
		public static var facebookUserLightInfo:Dictionary = new Dictionary();
		
		private static const PICTURE_LARGE_SIZE:int = 150;
		private static const PICTURE_SMALL_SIZE:int = 50;
		private static const PICTURE_URL:String = "http://graph.facebook.com/{0}/picture?width={1}&height={2}";
		
		public var facebookId:String;
		
		public var name:String;
		
		public var smallImageURL:String;
		
		public var largeImageURL:String;
		
		public var locale:String;
		
		public var username:String;
		
		
		public function FacebookUser() {
		}
		
		public function setFacebookId(fbId:String):void {
			facebookId = fbId;
			smallImageURL = StringUtil.substitute(PICTURE_URL, facebookId, PICTURE_SMALL_SIZE, PICTURE_SMALL_SIZE);
			largeImageURL = StringUtil.substitute(PICTURE_URL, facebookId, PICTURE_LARGE_SIZE, PICTURE_LARGE_SIZE);
			facebookUserLightInfo[fbId] = this;
		}
	}

}