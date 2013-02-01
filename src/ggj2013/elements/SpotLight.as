package ggj2013.elements 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ggj2013.Entity;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class SpotLight extends Sprite
	{
		[Embed(source="../../../lib/characters/spotLight.swf", symbol="SpotLight")] private static const MC_SPOTLIGHT:Class;
		private var m_sprite:Sprite = new Sprite;
		
		public function SpotLight() 
		{
			var spotlightMc:DisplayObject = new MC_SPOTLIGHT;
			addChild(spotlightMc);
			
			
			scaleX = scaleY = 1.5;
			
			var spr:Sprite;
			
			//create upper sprite
			spr = new Sprite;
			addChild(spr);
			spr.graphics.beginFill(0);
			spr.graphics.drawRect(0, 0, 1, 1);
			spr.graphics.endFill();
			spr.scaleX = 3000;
			spr.scaleY = 3000;
			spr.y = -3000 - spotlightMc.width / 2;
			spr.x = -1500;
			
			//create lower sprite
			spr = new Sprite;
			addChild(spr);
			spr.graphics.beginFill(0);
			spr.graphics.drawRect(0, 0, 1, 1);
			spr.graphics.endFill();
			spr.scaleX = 3000;
			spr.scaleY = 3000;
			spr.y = spotlightMc.width / 2 - 6;
			spr.x = -1500;
			
			//create right sprite
			spr = new Sprite;
			addChild(spr);
			spr.graphics.beginFill(0);
			spr.graphics.drawRect(0, 0, 1, 1);
			spr.graphics.endFill();
			spr.scaleX = 3000;
			spr.scaleY = 3000;
			spr.y = -spotlightMc.height / 2;
			spr.x = spotlightMc.width / 2;
			
			//create left sprite
			spr = new Sprite;
			addChild(spr);
			spr.graphics.beginFill(0);
			spr.graphics.drawRect(0, 0, 1, 1);
			spr.graphics.endFill();
			spr.scaleX = 3000;
			spr.scaleY = 3000;
			spr.y = -spotlightMc.height / 2;
			spr.x = -3000 - spotlightMc.width / 2 + 6;
		}
	}

}