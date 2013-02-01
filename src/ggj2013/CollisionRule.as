package ggj2013 
{
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class CollisionRule
	{
		private var mType1:uint;
		private var mType2:uint;
		
		public function CollisionRule(aType1:uint, aType2:uint) 
		{
			mType1 = aType1;
			mType2 = aType2;
		}
		
		public function get Type1():uint { return mType1; }
		public function get Type2():uint { return mType2; }
		
	}

}