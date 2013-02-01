package ggj2013.maps 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import ggj2013.Entity;
	import mx.core.BitmapAsset;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class BasicBackground extends Entity 
	{
		[Embed(source = "../../../lib/characters/heart/mancha_piso.png")] private static const IMG_MANCHA_1:Class;
		[Embed(source = "../../../lib/characters/heart/mancha_piso_02.png")] private static const IMG_MANCHA_2:Class;
		[Embed(source = "../../../lib/characters/heart/mancha_piso_03.png")] private static const IMG_MANCHA_3:Class;
		
		protected var m_layer:Sprite = new Sprite;
		protected var m_bitmapBackground:Bitmap;
		protected var m_bitmapForeground:Bitmap;
		protected var m_bitmapCollisions:Bitmap;
		protected var m_manchas:Vector.<Bitmap> = new Vector.<Bitmap>;
		private var m_colorTransformBloodThing:ColorTransform = new ColorTransform(1, 1, 1, 0.5);
		
		public function BasicBackground(_layer:Sprite, _layerFore:Sprite, bgImage:Bitmap, collisionMap:Bitmap, fgImage:Bitmap) 
		{
			_layer.addChild(m_layer);
			m_layer.addChild(bgImage);
			if (fgImage != null) {
				_layerFore.addChild(fgImage);
			}
			
			m_manchas.push(new IMG_MANCHA_1);
			m_manchas.push(new IMG_MANCHA_2);
			m_manchas.push(new IMG_MANCHA_3);
			
			m_bitmapBackground = bgImage,
			m_bitmapCollisions = collisionMap;
			m_bitmapForeground = fgImage;
		}
		
		public function get getWidth():Number { return m_layer.width; }
		public function get getHeight():Number { return m_layer.height; }
		public function get getCollisionMap():Bitmap { return m_bitmapCollisions; }
		
		
		public function drawMancha(pos:Point):void 
		{
			//image sizes == 34x18
			
			var indexMancha:int = Math.floor(Math.random() * m_manchas.length);
			var mancha:Bitmap = m_manchas[indexMancha];
			var positionMtx:Matrix = new Matrix;
			positionMtx.scale(1, 1);
			
			//position + regPoint
			var xx:Number = pos.x - 34 / 2;
			var yy:Number = pos.y - 18 / 2;
			
			//randomize a bit
			var randX:Number = 20;
			var randY:Number = 10;
			xx += Math.random() * randX - randX / 2;
			yy += Math.random() * randY - randY / 2;
			
			positionMtx.translate(xx, yy);
			m_bitmapBackground.bitmapData.draw(mancha.bitmapData, positionMtx,m_colorTransformBloodThing);
		}
	}

}