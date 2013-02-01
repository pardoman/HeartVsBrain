package ggj2013.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import ggj2013.Entity;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class GenericOverlay extends Entity 
	{
		[Embed(source = "../../../lib/Get-these-pieces.png")] private static const THESE_PIECES:Class;
		[Embed(source = "../../../lib/Your-life.png")] private static const YOUR_LIFE:Class;
		
		private var m_sprite:Sprite = new Sprite;
		
		public function GenericOverlay(_layer:Sprite) 
		{
			_layer.addChild(m_sprite);
			
			var bitmap:Bitmap;
			
			bitmap = new THESE_PIECES;
			bitmap.x = 120;
			bitmap.y = 30;
			m_sprite.addChild(bitmap);
			
			bitmap = new YOUR_LIFE;
			bitmap.x = 140;
			bitmap.y = 495;
			m_sprite.addChild(bitmap);
		}
		
	}

}