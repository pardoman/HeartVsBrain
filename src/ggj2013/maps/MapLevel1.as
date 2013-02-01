package ggj2013.maps 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import ggj2013.Entity;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class MapLevel1 extends BasicBackground
	{
		[Embed(source = "../../../lib/maps/Lvl1Background.jpg")] private static const BG_IMAGE:Class;
		[Embed(source = "../../../lib/maps/Lvl1Col.png")] private static const COLLISION_MAP:Class;
		
		public function MapLevel1(_layer:Sprite, _foreLayer:Sprite ) 
		{
			super(_layer, _foreLayer, new BG_IMAGE, new COLLISION_MAP, null);
		}
		
	}

}