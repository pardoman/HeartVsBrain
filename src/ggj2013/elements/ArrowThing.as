package ggj2013.elements 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ggj2013.Entity;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class ArrowThing extends Entity 
	{
		[Embed(source = "../../../lib/hud.swf", symbol = "Arrow")] private static const ARROW_MC:Class;
		
		private var m_sprite:MovieClip = new ARROW_MC;
		private var m_targetPos:Point = new Point;
		private var m_dir:Point = new Point;
		private var m_hasTarget:Boolean = false;
		
		public function ArrowThing(_layer:Sprite) 
		{
			_layer.addChild(m_sprite);
			m_sprite.addChild(new ARROW_MC);
			m_sprite.scaleX = m_sprite.scaleY = 0.5;
		}
		
		public function setTargetPos(_pos:Point, _dir:Point):void
		{
			m_targetPos.x = _pos.x;
			m_targetPos.y = _pos.y;
			m_dir.x = _dir.x;
			m_dir.y = _dir.y;
			m_hasTarget = true
		}
		
		public function setNoTarget():void
		{
			m_hasTarget = false;
		}
		
		override protected function onUpdate(aDt:Number):void 
		{
			
		}
		
		override protected function onRender():void 
		{
			m_sprite.visible = m_hasTarget;
			
			if (m_hasTarget)
			{
				m_sprite.x = m_targetPos.x;
				m_sprite.y = m_targetPos.y;
				
				var rot:Number = Math.atan2(m_dir.y, m_dir.x);
				m_sprite.rotation = 90 + rot * 180.0 / Math.PI;
			}
		}
		
	}

}