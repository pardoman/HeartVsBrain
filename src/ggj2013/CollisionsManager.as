package ggj2013 
{	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class CollisionsManager
	{
		private static var mInst:CollisionsManager;
		private var mLists:Dictionary;
		private var mRules:Vector.<CollisionRule>;
		
		public function CollisionsManager() 
		{
			mLists = new Dictionary;
			mRules = new Vector.<CollisionRule>;
			mInst = this;
		}
		
		public static function get inst():CollisionsManager 
		{
			return mInst;
		}
		
		public function setRule(aType1:uint, aType2:uint):void 
		{
			mRules.push( new CollisionRule(aType1,aType2) );
			trace( "Rule Added: " + aType1 + " <-> " + aType2 );
		}		
		
		public function add(aObj:ICollisionable):void
		{
			var list:Vector.<ICollisionable> = mLists[aObj.getType()];
			if ( list == null ) {
				list = new Vector.<ICollisionable>;
				mLists[aObj.getType()] = list;
				trace( "list created for type " + aObj.getType() );
			}
			list.push(aObj);
		}
		public function remove(aObj:ICollisionable):void 
		{
			var list:Vector.<ICollisionable> = mLists[aObj.getType()];
			var i:int = list.indexOf(aObj);
			if ( i >= 0 ) {
				list.splice(i, 1);
			}
		}
		
		public function checkCollisions():void 
		{
			for ( var i:int = 0; i < mRules.length; i++ )
			{
				var rule:CollisionRule = mRules[i];
				if ( rule.Type1 == rule.Type2) {
					checkCollisionsInCategory( mLists[rule.Type1] );
				} else {
					checkCollisionsIn2Categories( mLists[rule.Type1], mLists[rule.Type2] );
				}
			}
		}
		
		private function checkCollisionsInCategory(aList:Vector.<ICollisionable>):void 
		{
			if (aList == null) {
				return;
			}
			
			var center1:Point;
			var radius1:Number;
			var center2:Point;
			var radius2:Number;
			var obj1:ICollisionable;
			var obj2:ICollisionable;
			
			for ( var i:int = 0; i < aList.length - 1; i++ ) {
				obj1 = aList[i];
				center1 = obj1.getCollisionCenter();
				radius1 = obj1.getRadius();
				for ( var j:int = i + 1; j < aList.length; j++ ) {
					obj2 = aList[j];
					if ( obj1.canCollision(obj2) && obj2.canCollision(obj1) ) {
						center2 = obj1.getCollisionCenter();
						radius2 = obj1.getRadius();
						if ( Point.distance(center1, center2) < radius1 + radius2 ) {
							obj1.notifyCollision(obj2);
							obj2.notifyCollision(obj1);
						}
					}
				}
			}
		}
		
		private function checkCollisionsIn2Categories(aList1:Vector.<ICollisionable>, aList2:Vector.<ICollisionable>):void
		{
			if (aList1 == null || aList2 == null) {
				return;
			}
			
			var center1:Point;
			var radius1:Number;
			var center2:Point;
			var radius2:Number;
			var obj1:ICollisionable;
			var obj2:ICollisionable;
			
			for ( var i:int = 0; i < aList1.length; i++ ) {
				obj1 = aList1[i];
				center1 = obj1.getCollisionCenter();
				radius1 = obj1.getRadius();
				for ( var j:int = 0; j < aList2.length; j++ ) {
					obj2 = aList2[j];
					if ( obj1.canCollision(obj2) && obj2.canCollision(obj1) ) {
						center2 = obj2.getCollisionCenter();
						radius2 = obj2.getRadius();
						if ( Point.distance(center1, center2) < radius1 + radius2 ) {
							obj1.notifyCollision(obj2);
							obj2.notifyCollision(obj1);
						}
					}
				}
			}
		}
		
	}

}