package ggj2013.elements 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ggj2013.AudioManager;
	import ggj2013.CollisionsManager;
	import ggj2013.Constants;
	import ggj2013.Entity;
	import ggj2013.ICollisionable;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class Sonar extends Entity implements ICollisionable
	{
		private static const MIN_RADIUS:Number = 30;
		private static const MAX_RADIUS:Number = 290;
		private static const MAX_TIMER:Number = 0.30;
		
		private var m_sprite:Sprite = new Sprite;
		private var m_radius:Number;
		private var m_maxRadius:Number;
		private var m_pos:Point = new Point;
		private var m_timer:Number = 0;
		private var m_spotLight:SpotLight;
		
		private var m_shrinking:Boolean = true;
		
		public function Sonar(_spotLight:SpotLight)
		{
			_spotLight.parent.addChild(m_sprite);
			m_spotLight = _spotLight;
			
			CollisionsManager.inst.add(this);
		}
		
		public function setPos(_pos:Point):void
		{
			m_pos = _pos.clone();
		}
		
		public function beep(_pos:Point):void
		{
			m_shrinking = false;
			m_pos = _pos.clone();
			m_radius = MIN_RADIUS;
			//m_timer = MAX_TIMER;
			AudioManager.inst.playHeartBeat();
		}
		
		/* INTERFACE ggj2013.ICollisionable */
		
		public function getCollisionCenter():Point 
		{
			return m_pos.clone();
		}
		
		public function getRadius():Number 
		{
			return m_radius;
		}
		
		public function getType():uint 
		{
			return Constants.TYPE_SONAR;
		}
		
		public function canCollision(aOther:ICollisionable):Boolean 
		{
			return !m_shrinking;
		}
		
		public function notifyCollision(aOther:ICollisionable):void 
		{
			//Nothing
		}
		
		override protected function onUpdate(aDt:Number):void 
		{
			if (m_shrinking)
			{
				m_timer += aDt * 0.2;
			}
			else
			{
				m_timer -= aDt;
				
				if (m_timer < 0) {
					m_shrinking = true;
					m_timer = 0;
				}
			
				var s:Number = 1 - m_timer / MAX_TIMER;
				m_radius = MIN_RADIUS + (MAX_RADIUS - MIN_RADIUS) * s;
			}
		}
		
		override protected function onRender():void 
		{
			if (!m_shrinking) 
			{
				m_sprite.visible = false;
				m_sprite.x = m_pos.x;
				m_sprite.y = m_pos.y;
				
				//Rendering
				var g:Graphics = m_sprite.graphics;
				g.clear();
				g.lineStyle(4, 0xD63041);
				g.drawCircle(0, 0, m_radius);
				
				//spotlight
				var s:Number = 1 - m_timer / MAX_TIMER;
				m_spotLight.scaleX = m_spotLight.scaleY = 0.5 + 2.0*s;
			}
			else 
			{
				m_sprite.visible = false;
				
				//spotlight
				var ss:Number = 1 - m_timer / MAX_TIMER;
				m_spotLight.scaleX = m_spotLight.scaleY = 0.5 + 2.0*ss;
			}
		}
		
		override protected function onDestroy():void 
		{
			CollisionsManager.inst.remove(this);
			m_sprite.parent.removeChild(m_sprite);
		}
	}

}