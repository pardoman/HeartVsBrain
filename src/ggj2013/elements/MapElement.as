package ggj2013.elements 
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ggj2013.CollisionsManager;
	import ggj2013.Constants;
	import ggj2013.Entity;
	import ggj2013.ICollisionable;
	import ggj2013.IDepthManagerEntity;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class MapElement extends Entity implements ICollisionable, IDepthManagerEntity
	{	
		protected var m_pos:Point = new Point;
		protected var m_sprite:Sprite = new Sprite;
		protected var m_shadowSpr:Sprite = new Sprite;
		protected var m_CollisionRadius:Number = 20;
		
		public function MapElement(_layer:Sprite, _layerShadows:Sprite, _pos:Point) 
		{
			_layer.addChild(m_sprite);
			_layerShadows.addChild(m_shadowSpr);
			
			//drawDebugGraphics();
			drawShadow();
			
			m_pos.x = _pos.x;
			m_pos.y = _pos.y;
			
			CollisionsManager.inst.add(this);
		}
		
		private function drawShadow():void 
		{
			m_shadowSpr.graphics.beginFill(0);
			m_shadowSpr.graphics.drawCircle(0, 0, 10);
			m_shadowSpr.graphics.endFill();
			
			m_shadowSpr.alpha = Constants.ALPHA_SHADOWS;
			m_shadowSpr.scaleX = 2;
			m_shadowSpr.scaleY = 0.5;
		}
		
		private function drawDebugGraphics():void 
		{
			var g:Graphics = m_sprite.graphics;
			g.clear();
			g.lineStyle(2, 0);
			g.beginFill(0x00FF00);
			g.drawCircle(0, 0, 20);
			g.endFill();
		}
		
		/* INTERFACE ggj2013.ICollisionable */
		
		public function getCollisionCenter():Point 
		{
			return m_pos;
		}
		
		public function getRadius():Number 
		{
			return m_CollisionRadius;
		}
		
		public function getType():uint 
		{
			return Constants.TYPE_ITEM;
		}
		
		public function canCollision(aOther:ICollisionable):Boolean 
		{
			return true;
		}
		
		public function notifyCollision(aOther:ICollisionable):void 
		{
			//Nothing here
		}
		
		/* INTERFACE ggj2013.IDepthManagerEntity */
		
		public function getLayer():DisplayObject 
		{
			return m_sprite;
		}
		
		public function getLayerDepth():int 
		{
			return m_pos.y;
		}
		
		override protected function onDestroy():void 
		{
			CollisionsManager.inst.remove(this);
		}
		
		override protected function onRender():void 
		{	
			m_sprite.x = m_pos.x;
			m_sprite.y = m_pos.y;
			m_shadowSpr.x = m_pos.x;
			m_shadowSpr.y = m_pos.y;
		}
		
		public function onMapReset():void
		{
			//TODO
		}
		
	}

}