package ggj2013 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class DepthManager
	{
		private var mSortingLayer:DisplayObjectContainer;
		private var mElements:Vector.<IDepthManagerEntity>;
		
		public function DepthManager(aSortingLayer:DisplayObjectContainer) 
		{
			mSortingLayer = aSortingLayer;
			mElements = new Vector.<IDepthManagerEntity>;
		}
		
		public function add(aElement:IDepthManagerEntity):void 
		{
			mElements.push(aElement);
		}
		public function rem(aElement:IDepthManagerEntity):void
		{
			mElements.splice(mElements.indexOf(aElement), 1);
		}

		public function sort():void
		{
			mElements.sort(sortFunction);
			
			/// Remove all children from SortingLayer
			while ( mSortingLayer.numChildren > 0 )	{
				mSortingLayer.removeChildAt(mSortingLayer.numChildren - 1);
			}
			
			/// Add all children now that they are sorted
			for ( var i:int = 0; i < mElements.length; i++ ) {
				mSortingLayer.addChild( mElements[i].getLayer() );
			}
		}
		
		private function sortFunction(x:IDepthManagerEntity, y:IDepthManagerEntity):Number 
		{
			return x.getLayerDepth() - y.getLayerDepth();
		}
		
	}

}