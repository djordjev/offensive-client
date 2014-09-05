package components.common {
	import feathers.controls.Label;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import utils.Colors;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class OLabel extends Label {
		
		public static const FONT_ARIAL:String = "Arial";
		public static const FONT_GEARS_OF_PACE:String = "GearsOfPace";
		
		private var textFormat:TextFormat = new TextFormat("Arial")
		
		public function OLabel() {
			super();
			this.textRendererProperties.textFormat = textFormat;
			this.textRendererProperties.embedFonts = false;
			this.font = FONT_GEARS_OF_PACE;
			this.fontColor = Colors.BLACK;
			this.fontSize = 14;
		}
		
		public function set font(value:String):void {
			textFormat.font = value;
			if (value == FONT_ARIAL) {
				this.textRendererProperties.embedFonts = false;
			} else {
				this.textRendererProperties.embedFonts = true;
			}
			this.invalidate();
		}
		
		public function set fontSize(value:int):void {
			textFormat.size = value;
			this.invalidate();
		}
		
		public function set fontColor(value:int):void {
			textFormat.color = value;
			this.invalidate();
		}
		
		public function set textAlign(value:String):void {
			textFormat.align = value;
			this.invalidate();
		}
		
		override public function set text(value:String):void {
			if (value != null && !isAsciiOnly(value)) {
				font = FONT_ARIAL;
			}
			super.text = value;
		}
		
		private function isAsciiOnly(str:String):Boolean {
			for (var i:int = 0; i < str.length; i++) {
				var ch:Number = str.charCodeAt(i);
				if (ch > 126) {
					return false;
				}
			}
			
			return true;
		}
	}

}