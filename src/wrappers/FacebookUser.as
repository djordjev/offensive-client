package wrappers 
{
	import mx.utils.StringUtil;
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class FacebookUser 
	{
		private static const PICTURE_LARGE_SIZE:int = 150;
		private static const PICTURE_SMALL_SIZE:int = 50;
		private static const PICTURE_URL:String = "http://graph.facebook.com/{0}/picture?width={1}&height={2}";
		
		public var name:String;
		
		public var smallImageURL:String;
		
		public var largeImageURL:String;
		
		public var locale:String;
		
		public var username:String;
		
		
		public function FacebookUser() 
		{
		}
		
		public function setUsernameAndImages(playerUsername:String):void {
			username = playerUsername;
			smallImageURL = StringUtil.substitute(PICTURE_URL, username, PICTURE_SMALL_SIZE, PICTURE_SMALL_SIZE);
			largeImageURL = StringUtil.substitute(PICTURE_URL, username,PICTURE_LARGE_SIZE, PICTURE_LARGE_SIZE);
		}
		
		
		
	}

}