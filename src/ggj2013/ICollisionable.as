package ggj2013 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public interface ICollisionable 
	{
		function getCollisionCenter():Point;
		function getRadius():Number;
		function getType():uint;
		function canCollision(aOther:ICollisionable):Boolean;
		function notifyCollision(aOther:ICollisionable):void;
	}
	
}