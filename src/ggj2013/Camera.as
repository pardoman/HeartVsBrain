package ggj2013 
{
	import flash.display.DisplayObject;
	import flash.display.JointStyle;
	import flash.geom.Point;
	import ggj2013.maps.BasicBackground;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class Camera extends Entity
	{
		private var mLayerCam:DisplayObject;
		private var mPos:Point = new Point;
		private var mGoToPos:Point = new Point;
		
		private var m_worldPos:Point = new Point;
		private var m_worldTransform:Point = new Point;
		private var m_worldLimits:Point;
		private var m_bgScale:Number;
		private var m_stageSize:Point = new Point;
		
		public function Camera(aLayerCam:DisplayObject, _worldLimits:Point) 
		{
			mLayerCam = aLayerCam;
			m_bgScale = 1;
			m_stageSize.x = Constants.StageWidth;
			m_stageSize.y = Constants.StageHeight;
			m_worldTransform.x = m_stageSize.x / 2;
			m_worldTransform.y = m_stageSize.y / 2;
			m_worldLimits = _worldLimits;
		}
		
		public function forceAt(aPos:Point):void
		{
			centerAt(aPos);
			mPos.x = mGoToPos.x;
			mPos.y = mGoToPos.y;
			m_worldPos = mPos.add(m_worldTransform);
		}
		
		public function centerAt(aPos:Point):void 
		{
			mGoToPos.x = aPos.x - m_stageSize.x / 2;
			mGoToPos.y = aPos.y - m_stageSize.y / 2;
			bound(mGoToPos);
		}
		
		override protected function onUpdate(aDt:Number):void 
		{
			var delta:Point = mGoToPos.subtract(mPos);
			delta.normalize(aDt* delta.length * 4);
			mPos = mPos.add(delta);
			m_worldPos = mPos.add(m_worldTransform);
		}
		
		override protected function onRender():void 
		{
			mLayerCam.x = -mPos.x;
			mLayerCam.y = -mPos.y;
		}
		
		private function bound(aPos:Point):void 
		{
			/// Bound X
			if ( mPos.x < 0 ) { 
				mPos.x = 0;
			} else if ( mPos.x + m_stageSize.x > m_worldLimits.x ) {
				mPos.x = m_worldLimits.x - m_stageSize.x;
			}
			/// Bound Y
			if ( mPos.y < 0 ) { 
				mPos.y = 0;
			} else if ( mPos.y + m_stageSize.y > m_worldLimits.y) {
				mPos.y = m_worldLimits.y - m_stageSize.y;
			}
		}
		
		
		public function getWorldPos():Point 
		{
			return m_worldPos;
		}
		
	}

}