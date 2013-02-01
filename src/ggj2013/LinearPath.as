package ggj2013 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author d
	 */
	public class LinearPath implements IPath
	{
		private var mOrigin:Point;
		private var mDestiny:Point;
		
		public function LinearPath(
			aOrigin:Point, aDestiny:Point) 
		{
			mOrigin = aOrigin.clone();
			mDestiny = aDestiny.clone();
		}
		
		/* INTERFACE dvjw.elements.IPath */
		public function getPos(s:Number):Point
		{
			var A:Point = 
				mDestiny.subtract(mOrigin);
			A.normalize(s*A.length);
			return mOrigin.add(A);
		}
		
		public function getLength():Number
		{
			return Point.distance(
				mOrigin, mDestiny);
		}
		
		public function get O():Point
		{
			return mOrigin;
		}
		
		public function get D():Point
		{
			return mDestiny;
		}
	}

}