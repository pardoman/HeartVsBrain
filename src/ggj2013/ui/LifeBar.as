package ggj2013.ui 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import ggj2013.Entity;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class LifeBar extends Entity 
	{
		private static var s_instance:LifeBar;
		public static function get inst():LifeBar { return s_instance; }
		
		[Embed(source = "../../../lib/hud.swf", symbol = "LifeBar")] private static const LIFE_BAR:Class;
		
		private var m_sprite:MovieClip;
		private var m_currentLife:Number;
		private var m_gotoLifeBar:Number
		
		private var m_speedDown:Number = 100;
		private var m_speedUp:Number = 100;
		
		public function LifeBar(_layer:Sprite) 
		{
			m_sprite = new LIFE_BAR;	// 100 frames!
			_layer.addChild(m_sprite);
			
			m_gotoLifeBar = 100;
			m_currentLife = 100;
			
			onRender();
			
			s_instance = this; // jojojoo!
		}
		
		public function resetLifeBar():void
		{
			m_gotoLifeBar = 100;
		}
		
		public function takeLife():Boolean //returns true when dead
		{
			m_gotoLifeBar -= 10;
			m_gotoLifeBar = Math.max(0, m_gotoLifeBar);
			return (m_gotoLifeBar == 0);
		}
		
		public function addLife():void
		{
			m_gotoLifeBar += 10;
			m_gotoLifeBar = Math.min(100, m_gotoLifeBar);
		}
		
		override protected function onUpdate(aDt:Number):void 
		{
			if (m_currentLife > m_gotoLifeBar)
			{
				//move it down
				m_currentLife -= aDt * m_speedDown;
				m_currentLife = Math.max(m_currentLife, m_gotoLifeBar);
			}
			else if (m_currentLife < m_gotoLifeBar)
			{
				//move it up
				m_currentLife += aDt * m_speedUp;
				m_currentLife = Math.min(m_currentLife, m_gotoLifeBar);
			}
		}
		
		override protected function onRender():void 
		{
			m_sprite.gotoAndStop(int(m_currentLife));
			
			m_sprite.x = 136;
			m_sprite.y = 546;
		}
		
	}

}