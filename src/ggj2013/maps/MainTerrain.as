package ggj2013.maps 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class MainTerrain extends BasicBackground
	{
		[Embed(source = "../../../lib/maps/PrincipalBackground.jpg")] private static const BG_IMAGE:Class;
		[Embed(source = "../../../lib/maps/PrincipalCol.png")] private static const COLLISION_MAP:Class;
		
		public function MainTerrain(_layer:Sprite, _foreLayer:Sprite) 
		{
			super(_layer, _foreLayer, new BG_IMAGE, new COLLISION_MAP, null);
		}
		
	}

}