package ggj2013.elements 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import ggj2013.Constants;
	import ggj2013.Entity;
	import ggj2013.ICollisionable;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class Obstacle extends Entity implements ICollisionable 
	{
		private var m_sprite:Sprite = new Sprite;
		private var m_radius:Number = 0;
		
		public function Obstacle(_layer:Sprite, _pos:Point, _radius:Number) 
		{
			_layer.addChild(m_sprite);
			
			m_pos = _pos.clone();
			m_radius = _radius;
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
			return Constants.TYPE_OBSTACLE;
		}
		
		public function canCollision(aOther:ICollisionable):Boolean 
		{
			return true;
		}
		
		public function notifyCollision(aOther:ICollisionable):void 
		{
			//nothing
		}
		
	}

}