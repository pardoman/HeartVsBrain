package ggj2013.elements 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ggj2013.AudioManager;
	import ggj2013.Constants;
	import ggj2013.ICollisionable;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class Pill extends MapElement 
	{
		[Embed(source = "../../../lib/items.swf", symbol = "Pill")] private static const PILL_MC:Class;
		[Embed(source = "../../../lib/items.swf", symbol = "Pill2")] private static const PILL_2_MC:Class;
		[Embed(source = "../../../lib/items.swf", symbol = "Particles1")] private static const PARTICLES:Class;
		
		private var mc_pill:MovieClip;
		private var m_RadAngle:Number = 0;
		private var m_collected:Boolean = false;
		private var m_fadeOutTimer:Number = 1;
		private var m_id:int;
		
		private var m_particles:MovieClip;
		
		public function Pill(_layer:Sprite, _layerShadows:Sprite, _pos:Point, _id:int) 
		{
			super(_layer, _layerShadows, _pos);
			m_id = _id;
			/*
			if (_id == 1) {
				mc_pill = new PILL_MC;
			} else {
				mc_pill = new PILL_2_MC;
			}*/
			mc_pill = new PILL_2_MC;
			
			mc_pill.scaleX = mc_pill.scaleY = 0.2;
			m_sprite.addChild(mc_pill);
			
			//particles
			m_particles = new PARTICLES;
			_layerShadows.addChild(m_particles);
			m_particles.visible = false;
		}
		
		override protected function onUpdate(aDt:Number):void 
		{
			super.onUpdate(aDt);
			
			//Animate up and down only when not collected
			if (!m_collected) {
				m_RadAngle += Math.PI * aDt;
				if (m_RadAngle > Math.PI * 2) {
					m_RadAngle -= Math.PI * 2;
				}
			}
			
			if (m_collected && m_fadeOutTimer > 0) {
				m_fadeOutTimer -= aDt;
				m_fadeOutTimer = Math.max(0, m_fadeOutTimer);
			}
		}
		
		override protected function onRender():void 
		{
			//No super() call here!
			m_sprite.visible = true;
			
			m_sprite.x = int(m_pos.x);
			m_sprite.y = int(m_pos.y + Math.sin(m_RadAngle) * 20);
			
			m_shadowSpr.x = m_sprite.x;
			m_shadowSpr.y = int(m_pos.y);
			
			m_sprite.alpha = 1;
			m_shadowSpr.alpha = Constants.ALPHA_SHADOWS;
			if (m_collected) {
				m_sprite.alpha *= m_fadeOutTimer;
				m_shadowSpr.alpha *= m_fadeOutTimer;
			}
			
			if (m_collected)
			{
				m_particles.x = m_shadowSpr.x;
				m_particles.y = m_shadowSpr.y;
				if (m_particles.currentFrame == m_particles.totalFrames) {
					m_particles.visible = false;
				}
			}
		}
		
		override public function getType():uint 
		{
			return Constants.TYPE_PILL;
		}
		
		override public function getRadius():Number 
		{
			return 10;
		}

		override public function canCollision(aOther:ICollisionable):Boolean 
		{
			return !m_collected;
		}
		
		override public function notifyCollision(aOther:ICollisionable):void 
		{
			m_collected = true;
			messageParent("got_pill", m_id);
			
			m_particles.gotoAndPlay(1);
			m_particles.visible = true;
			
			AudioManager.inst.playGramItem();
		}
		
		override public function onMapReset():void
		{
			m_collected = false;
			m_fadeOutTimer = 1;
			m_particles.visible = false;
		}
	}

}