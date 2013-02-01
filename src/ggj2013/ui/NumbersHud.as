package ggj2013.ui 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import ggj2013.Entity;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class NumbersHud extends Entity
	{
		private static var s_instance:NumbersHud = null;
		public static function get inst():NumbersHud { return s_instance; }
		
		[Embed(source = "../../../lib/numbers.swf", symbol = "HudNumbers")] private static const HUD_NUMBERS:Class;		
		private var m_mc:MovieClip;

		
		public function NumbersHud(_layer:Sprite) 
		{
			s_instance = this; //Jojojo!!
			
			m_mc = new HUD_NUMBERS;
			_layer.addChild(m_mc);
			
			//Initialize numbers as not found
			for (var i:int = 1; i <= 9; i++)
			{
				setNumberFound(i, false);
			}

			//position
			m_mc.x = 400+200;
			m_mc.y = 50;
			m_mc.scaleX = m_mc.scaleY = 0.7;
		}
		
		public function setNumberFound(itemNumber:int, isFound:Boolean):void
		{
			var child:MovieClip = m_mc.getChildByName("num" + itemNumber) as MovieClip;
			child.gotoAndStop(isFound ? 2 : 1);
		}
		
		public function onMapReset():void
		{
			for (var i:int = 1; i <= 9; i++)
			{
				setNumberFound(i, false);
			}
		}
		
	}

}