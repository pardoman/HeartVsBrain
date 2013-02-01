package ggj2013 
{
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class Constants 
	{
		
		public function Constants() 
		{
			
		}
		
		public static const StageWidth:Number = 800;
		public static const StageHeight:Number = 600;
				
		///
		// Collision Types
		public static const TYPE_SONAR:uint = 1;
		public static const TYPE_PLAYER:uint = 2;
		public static const TYPE_ITEM:uint = 3;
		public static const TYPE_OBSTACLE:uint = 4;
		public static const TYPE_NUMBER_PIECE:uint = 5;
		public static const TYPE_PORTAL:uint = 6;
		public static const TYPE_PILL:uint = 7;
		public static const TYPE_ENEMY:uint = 8;
		
		public static const VISIBLE_TIMER:Number = 0.5;
		
		public static const DISTANCE_BLOOD_SPOT:Number = 5;
		public static const TIME_BLOOD_SPOT:Number = 0.05;
		
		public static const ALPHA_SHADOWS:Number = 0.5;
	}

}