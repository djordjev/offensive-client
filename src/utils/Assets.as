package utils 
{
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
		
		[Embed(source="../../assets/gameAssets/background.jpg")]
		public static const MainControlsBackground:Class;
		
		
	}

}