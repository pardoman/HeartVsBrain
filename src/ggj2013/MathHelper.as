package ggj2013 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class MathHelper
	{
		
		public function MathHelper() 
		{
			throw new Error("MathHelper should not be created. Use static methods instead.");
		}
		
		public static function segmentsIntersect(aA:Point, aB:Point, aC:Point, aD:Point):Point
		{
			var vValue:Number = ((aB.x - aA.x) * (aD.y - aC.y)) - ((aB.y - aA.y) * (aD.x - aC.x));
			  
			if (vValue == 0.0) {
				// Lines are parallel.    
				return null;
			} else {
				
				var vRTop:Number = ((aA.y - aC.y) * (aD.x - aC.x)) - ((aA.x - aC.x) * (aD.y - aC.y));
				var vSTop:Number = ((aA.y - aC.y) * (aB.x - aA.x)) - ((aA.x - aC.x) * (aB.y - aA.y));
				
				var vR:Number = vRTop / vValue;
				var vS:Number = vSTop / vValue;
				
				if ((vR >= 0.0) && (vR <= 1.0) && (vS >= 0.0) && (vS <= 1.0)) {
				  
					//var vPoint:Point = aA + ((aB - aA) * vR); // Pseudo-código.
					var vPoint:Point = aB.subtract(aA);
					vPoint.normalize(vR * vPoint.length);
					vPoint.add(aA);
					return vPoint;
				  
				} else {
					// Lines intersect beyond segment limits.    
					return null;
				}
			}
		}
		
	}

}