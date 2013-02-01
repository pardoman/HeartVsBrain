package ggj2013.elements 
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import ggj2013.AudioManager;
	import ggj2013.CollisionsManager;
	import ggj2013.Constants;
	import ggj2013.Entity;
	import ggj2013.ICollisionable;
	import ggj2013.Input;
	import ggj2013.elements.Sonar;
	import ggj2013.particles.ParticlesManager;
	import ggj2013.ui.LifeBar;
	import ggj2013.ui.NumbersHud;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class Player extends MapElement
	{
		[Embed(source = "../../../lib/characters/heart.swf", symbol = "Heart")] private static const MC_ASSETS:Class;
		
		private var m_prevPos:Point = new Point;
		private var m_speed:Point = new Point;
		private var m_sonar:Sonar;
		private var m_movieClip:MovieClip;
		
		private var m_movementForce:Number = 1000.0;
		private var m_dragForce:Number = 100;
		private var m_maxSpeed:Number = 300;
		
		private var m_timerBeep:Number = 1.4;
		private var m_timerNextBeep:Number = m_timerBeep;
		private var m_spotLight:SpotLight;
		
		public function getPos():Point { return m_pos.clone(); }
		public function getPrevPos():Point { return m_prevPos.clone(); }
		
		private var m_kUp:Boolean = false;
		private var m_kDown:Boolean = false;
		private var m_kRight:Boolean = false;
		private var m_kLeft:Boolean = false;
		
		private var m_initPos:Point;
		private var m_timeCollision:Number = 0;
		
		public function Player(_layer:Sprite, _layerShadows:Sprite, _spotLight:SpotLight, _pos:Point) 
		{
			super(_layer, _layerShadows, _pos);
			
			m_initPos = _pos.clone();
			m_spotLight = _spotLight;
			
			createSprite();
			updatePrevPosition();
			
			m_sonar = new Sonar(m_spotLight);
			addChild(m_sonar);
			
			CollisionsManager.inst.add(this);
			
			onRender();
		}
		
		private function updatePrevPosition():void
		{
			m_prevPos.x = m_pos.x;
			m_prevPos.y = m_pos.y;
		}
		
		private function createSprite():void 
		{
			m_sprite.graphics.clear();
			
			m_movieClip = new MC_ASSETS;
			m_sprite.addChild(m_movieClip);
			m_movieClip.gotoAndStop("down");
			m_movieClip.scaleX = m_movieClip.scaleY = 0.45;
		}
		
		/* INTERFACE ggj2013.ICollisionable */
		
		override public function getType():uint 
		{
			return Constants.TYPE_PLAYER;
		}
		
		override public function canCollision(aOther:ICollisionable):Boolean 
		{
			return true;
		}
		
		override public function notifyCollision(aOther:ICollisionable):void 
		{
			if (aOther.getType() == Constants.TYPE_ENEMY)
			{
				doCollisionToBadThing();
				AudioManager.inst.playCrashBrain();
			}
		}
		
		override protected function onUpdate(aDt:Number):void 
		{
			super.onUpdate(aDt);
			
			updatePrevPosition();
			
			var kRight:Boolean = Input.inst.isKeyCodeDown(Keyboard.RIGHT);
			var kLeft:Boolean = Input.inst.isKeyCodeDown(Keyboard.LEFT);
			var kUp:Boolean = Input.inst.isKeyCodeDown(Keyboard.UP);
			var kDown:Boolean = Input.inst.isKeyCodeDown(Keyboard.DOWN);
			
			//Cancel opposing forces
			if (kRight && kLeft) {
				kRight = kLeft = false;
			}
			if (kUp && kDown) {
				kUp = kDown = false;
			}
			
			m_kUp = kUp;
			m_kDown = kDown;
			m_kRight = kRight;
			m_kLeft = kLeft;
			
			var speedStep:Point = new Point;
			
			//Update velocity based on input
			if (kRight) { speedStep.x = 1; } 
			else if (kLeft) { speedStep.x = -1; }
			if (kUp) { speedStep.y = -1; } 
			else if (kDown) { speedStep.y = 1; }
			
			if (speedStep.length > 0) {
				speedStep.normalize(m_movementForce);
			}
			
			//Apply speed step
			m_speed.x += speedStep.x * aDt;
			m_speed.y += speedStep.y * aDt;
			
			//Limit maximum speed
			if (m_speed.length > m_maxSpeed) {
				m_speed.normalize(m_maxSpeed);
			}
			
			//Update speed
			if (m_speed.length > 0)
			{
				//apply dragForce
				var reducedLength:Number = m_speed.length - m_dragForce * aDt;
				if (reducedLength < 0) {
					m_speed.x = m_speed.y = 0;
				} else {
					m_speed.normalize(reducedLength);
				}
			}
			
			//Update position
			m_pos.x += m_speed.x * aDt;
			m_pos.y += m_speed.y * aDt;
			
			
			//Update timer sonar
			m_timerNextBeep -= aDt;
			if (m_timerNextBeep < 0 || Input.inst.isKeyCodePressed(Keyboard.SPACE)) {
				m_timerNextBeep += m_timerBeep;
				m_sonar.beep(m_pos);
			}
			m_sonar.setPos(m_pos);
			
			
			//Collision Timer
			if (m_timeCollision > 0)
			{
				m_timeCollision -= aDt;
				m_timeCollision = Math.max(m_timeCollision, 0);
			}
		}
		
		override protected function onRender():void 
		{
			super.onRender();
			
			m_spotLight.x = m_pos.x;
			m_spotLight.y = m_pos.y;
			
			if (m_kDown)
			{
				m_movieClip.gotoAndStop("down");
			}
			else if (m_kUp)
			{
				m_movieClip.gotoAndStop("up");
			}
			else if (m_kLeft)
			{
				m_movieClip.gotoAndStop("left");
			}
			else if (m_kRight)
			{
				m_movieClip.gotoAndStop("right");
			}
			else if (m_speed.length == 0)
			{
				m_movieClip.gotoAndStop("standDown");
			}
			else if (m_speed.length < 150)
			{
				if (Math.abs(m_speed.x) > Math.abs(m_speed.y))
				{
					if (m_speed.x > 0) {
						m_movieClip.gotoAndStop("standRight");
					} else {
						m_movieClip.gotoAndStop("standLeft");
					}
				}
				else
				{
					if (m_speed.y > 0) {
						m_movieClip.gotoAndStop("standDown");
					} else {
						m_movieClip.gotoAndStop("standUp");
					}
				}
			}
		}
		
		public function collideToWall():void
		{	
			m_pos.x = m_prevPos.x;
			m_pos.y = m_prevPos.y;
			
			m_speed.x = 0;
			m_speed.y = 0;
			
			if (m_timeCollision == 0)
			{
				m_timeCollision = 1;
				doCollisionToBadThing();
				AudioManager.inst.playCrashWall();
			}
		}
		
		private function doCollisionToBadThing():void
		{
			ParticlesManager.inst.doParticles(m_pos);
			var isDead:Boolean = LifeBar.inst.takeLife();
			if (isDead) {
				messageParent("player_dead", null);
			}
		}
		
		override public function onMapReset():void
		{
			m_pos = m_initPos.clone();
			m_speed = new Point;
		}
	}

}