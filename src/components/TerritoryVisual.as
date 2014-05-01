package components {
	import communication.protos.Territory;
	import components.common.OLabel;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import starling.textures.Texture;
	import utils.Assets;
	import utils.Colors;
	import wrappers.TerritoryWrapper;
	
	/**
	 * ...
	 * @author Djordje Vukovic
	 */
	public class TerritoryVisual extends LayoutGroup {
		
		private var _territory:TerritoryWrapper;
		
		private var _image:ImageLoader = new ImageLoader();
		private var _nameLabel:OLabel = new OLabel();
		
		public function TerritoryVisual() {
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			this.addChild(_image);
			
			_nameLabel.x = 15;
			_nameLabel.y = 20;
			this.addChild(_nameLabel);
		}
		
		public function set territory(value:TerritoryWrapper):void {
			if (value != null) {
				_territory = value;
				// add background image
				var texture:Texture = Assets.getTerritory(value.territory.id);
				_image.source = texture;
				
				_nameLabel.text = _territory.name;
				
				this.x = 500;
				this.y = 500;
				
			}
		}
		
		public function get territory():TerritoryWrapper {
			return _territory;
		}
	
	}

}