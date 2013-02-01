package ggj2013.elements 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ggj2013.Constants;
	import ggj2013.ICollisionable;
	import ggj2013.IPath;
	import ggj2013.LinearPath;
	import ggj2013.PathWalker;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class LittleBrain extends DetectableElement
	{
		[Embed(source = "../../../lib/characters/brain.swf", symbol = "LittleBrain")] private static const ASSETS:Class;
		
		private var m_mc:MovieClip; 
		
		private var m_posA:Point;
		private var m_posB:Point;
		private var m_path:IPath;
		private var m_walker:PathWalker;
		private var m_collisionTimer:Number = 0;
		
		public function LittleBrain(_layer:Sprite, _layerShadows:Sprite, _enemyData:Object) 
		{
			//{xStart,yStart,xEnd,yEnd}
			m_posA = new Point(_enemyData[0], _enemyData[1]);
			m_posB = new Point(_enemyData[2], _enemyData[3]);
			
			super(_layer, _layerShadows, m_posA);
			
			m_path = new LinearPath(m_posA, m_posB);
			m_walker = PathWalker.createSpeed(m_path, 80);
			m_walker.setPolicyPong();
			addChild(m_walker);
			
			m_mc = new ASSETS;
			m_mc.scaleX = m_mc.scaleY = 0.3;
			m_sprite.addChild(m_mc);
			m_sprite.graphics.clear();
			
			//Set a random animationframe
			m_mc.gotoAndStop(1 + int(Math.floor(Math.random() * 4.0)));
			
			//collision
			m_CollisionRadius = 5;
		}
		
		override protected function onUpdate(aDt:Number):void 
		{
			super.onUpdate(aDt);
			m_pos = m_walker.getPos();
			
			//collision timer
			if (m_collisionTimer > 0) {
				m_collisionTimer -= aDt;
				m_collisionTimer = Math.max(0, m_collisionTimer);
			}
		}
		
		override protected function onRender():void 
		{
			super.onRender();
			
			if (m_collisionTimer > 0) {
				m_sprite.alpha *= 0.5;
				m_shadowSpr.alpha *= 0.5;
			}
		}
		
		override public function getType():uint 
		{
			return Constants.TYPE_ENEMY;
		}
		
		override public function canCollision(aOther:ICollisionable):Boolean 
		{
			return (m_collisionTimer == 0);
		}
		
		override public function notifyCollision(aOther:ICollisionable):void 
		{
			if (aOther.getType() == Constants.TYPE_PLAYER)
			{
				m_collisionTimer = 2;
			}
		}
		
		override public function onMapReset():void 
		{
			super.onMapReset();
			m_collisionTimer = 0;
		}
		
	}

}