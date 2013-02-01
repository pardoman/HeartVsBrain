package ggj2013.elements 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ggj2013.Constants;
	import ggj2013.Entity;
	import ggj2013.ICollisionable;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class Portal extends Entity implements ICollisionable
	{
		[Embed(source = "../../../lib/floor_portal.png")]private static const PORTAL_ASSET:Class;
		
		private var m_sprite:Sprite = new Sprite;
		private var m_num:int;
		private var m_isActive:Boolean;
		private var m_pos:Point;
		
		public function Portal(_layer:Sprite, _pos:Point, _num:int) 
		{
			_layer.addChild(m_sprite);
			m_num = _num;
			
			m_pos = _pos.clone();
			m_sprite.x = _pos.x;
			m_sprite.y = _pos.y;
			
			m_isActive = false;
			
			//image
			var bitmap:Bitmap = new PORTAL_ASSET;
			bitmap.x = -72;
			bitmap.y = -31;
			m_sprite.addChild(bitmap);
		}
		
		/* INTERFACE ggj2013.ICollisionable */
		
		public function getCollisionCenter():Point 
		{
			return m_pos;
		}
		
		public function getRadius():Number 
		{
			return 10;
		}
		
		public function getType():uint 
		{
			return Constants.TYPE_PORTAL;
		}
		
		public function canCollision(aOther:ICollisionable):Boolean 
		{
			return m_isActive;
		}
		
		public function notifyCollision(aOther:ICollisionable):void 
		{
			//nothing
		}
		
	}

}