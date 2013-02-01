package ggj2013.elements 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import ggj2013.Constants;
	import ggj2013.ICollisionable;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class DetectableElement extends MapElement
	{
		//private var m_timerVisible:Number = 0;
		
		public function DetectableElement(_layer:Sprite, _layerShadows:Sprite, _pos:Point) 
		{
			super(_layer, _layerShadows, _pos);
			
		}
		
		override protected function onRender():void 
		{
			super.onRender();
			
			/*
			if (m_timerVisible > 0)
			{
				m_sprite.visible = true;
				m_shadowSpr.visible = true;
				m_sprite.alpha = m_timerVisible / Constants.VISIBLE_TIMER;
				m_shadowSpr.alpha = m_sprite.alpha * Constants.ALPHA_SHADOWS;
			}
			else
			{
				m_sprite.visible = false;
				m_shadowSpr.visible = false;
			}
			*/
		}
		
		
		override protected function onUpdate(aDt:Number):void 
		{
			super.onUpdate(aDt);
			//m_timerVisible -= aDt;
		}
		
		override public function notifyCollision(aOther:ICollisionable):void 
		{
			if (aOther.getType() == Constants.TYPE_SONAR)
			{
				//m_timerVisible = Constants.VISIBLE_TIMER;
			}
		}
		
	}

}