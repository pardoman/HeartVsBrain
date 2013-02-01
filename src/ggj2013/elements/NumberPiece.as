package ggj2013.elements 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ggj2013.AudioManager;
	import ggj2013.Constants;
	import ggj2013.ICollisionable;
	import ggj2013.ui.NumbersHud;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class NumberPiece extends MapElement
	{
		//Ale: 098-740-769, call me maybe?
		[Embed(source = "../../../lib/numbers.swf", symbol = "Numbers")] private static const NUMBERS:Class;
		[Embed(source = "../../../lib/items.swf", symbol = "Particles2")]private static const PARTICLES_2:Class;
		
		private var m_num:int;
		private var m_RadAngle:Number = 0;
		private var m_collected:Boolean = false;
		private var m_fadeOutTimer:Number = 1;
		private var m_isActive:Boolean;
		private var m_particles:MovieClip;
		
		public function get getDigit():int { return m_num; }
		public function getPos():Point { return m_pos; }
		
		public function NumberPiece(_layer:Sprite, _layerShadows:Sprite, _pos:Point, _num:int, _isActive:Boolean) 
		{
			super(_layer, _layerShadows, _pos);
			
			m_sprite.graphics.clear();
			m_num = _num;
			m_isActive = _isActive;
			
			var movieClip:MovieClip = new NUMBERS;
			movieClip.gotoAndStop(_num);
			m_sprite.addChild(movieClip);
			
			m_particles = new PARTICLES_2;
			_layerShadows.addChild(m_particles);
			m_particles.visible = false;
		}
		
		override public function getType():uint 
		{
			return Constants.TYPE_NUMBER_PIECE;
		}
		
		public function activate():void
		{
			m_isActive = true;
		}
		
		override public function canCollision(aOther:ICollisionable):Boolean 
		{
			return !m_collected && m_isActive;
		}
		
		override public function notifyCollision(aOther:ICollisionable):void 
		{
			//Asume collision with Player
			m_collected = true;
			NumbersHud.inst.setNumberFound(m_num, true);
			messageParent("got_number", m_num);
			
			m_particles.gotoAndPlay(1);
			m_particles.visible = true;
			AudioManager.inst.playGramItem();
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
			m_sprite.visible = m_isActive;
			
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

		override public function onMapReset():void
		{
			m_collected = false;
			m_fadeOutTimer = 1;
			m_isActive = (m_num == 1);
			m_particles.visible = false;
		}
		
	}

}