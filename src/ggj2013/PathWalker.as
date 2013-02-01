package ggj2013 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author d
	 */
	public class PathWalker extends Entity
	{
		private const POLICY_STOP:uint = 1;
		private const POLICY_LOOP:uint = 2;
		private const POLICY_PONG:uint = 3;
		private var mPolicy:uint;
		
		private var mPath:IPath;
		private var mTotalTime:Number;
		private var mPathTime:Number;
		
		private var mIsForward:Boolean;
		private var mIsMoving:Boolean;
		private var mPos:Point;
		
		public function PathWalker() 
		{
			mPath = null;
			mTotalTime = 0;
			mPathTime = 0;
			mIsMoving = false;
			mPos = null;
			mPolicy = POLICY_STOP;
			mIsForward = true;
		}
		
		public static function createTimed(
			aPath:IPath, 
			aTime:Number ):PathWalker 
		{
			var pw:PathWalker = new PathWalker;
			pw.mPath = aPath;
			pw.mTotalTime = aTime;
			pw.mIsMoving = true;
			pw.mPos = aPath.getPos(0);
			return pw;
		}
		
		public static function createSpeed(
			aPath:IPath, 
			aSpeed:Number ):PathWalker 
		{
			var pw:PathWalker = new PathWalker;
			pw.mPath = aPath;
			pw.mTotalTime = aPath.getLength() / aSpeed;
			pw.mIsMoving = true;
			pw.mPos = aPath.getPos(0);
			return pw;
		}
		
		override protected function onUpdate(aDt:Number):void 
		{
			if ( mIsMoving )
			{
				if ( mIsForward ) {
					mPathTime += aDt;
				} else {
					mPathTime -= aDt;
				}
				applyPolicy();
				var s:Number = mPathTime / mTotalTime; //(2)
				mPos = mPath.getPos(s);
			}
		}
		
		private function applyPolicy():void 
		{
			if ( isPolicyStop() )
			{
				if ( mPathTime > mTotalTime ) {
					mPathTime = mTotalTime;
				}
			} 
			else if ( isPolicyLoop() )
			{
				if ( mPathTime > mTotalTime ) {
					mPathTime -= mTotalTime;
				}
			}
			else if ( isPolicyPong() )
			{
				if ( mIsForward ) {
					if ( mPathTime > mTotalTime ) {
						mPathTime = mTotalTime;
						mIsForward = false;
					}
				} else {
					if ( mPathTime < 0 ) {
						mPathTime = 0;
						mIsForward = true;
					}
				}
				
			}
		}
		
		public function isPolicyLoop():Boolean
		{
			return mPolicy == POLICY_LOOP;
		}
		
		public function isPolicyStop():Boolean
		{
			return mPolicy == POLICY_STOP;
		}
		
		public function isPolicyPong():Boolean
		{
			return mPolicy == POLICY_PONG;
		}
		
		public function isOver():Boolean
		{
			if (isPolicyStop() && mTotalTime == mPathTime)
			{
				return true;
			}
			
			return false;
		}
		
		public function setPolicyLoop():void 
		{
			mPolicy = POLICY_LOOP;
			mIsForward = true;
		}
		public function setPolicyStop():void 
		{
			mPolicy = POLICY_STOP;
			mIsForward = true;
		}
		public function setPolicyPong():void 
		{
			mPolicy = POLICY_PONG;
		}
			
		public function getPos():Point 
		{
			return mPos.clone();
		}
		
		public function getFuturePos(aDt:Number):Point 
		{
			var currentTime:Number = mPathTime;
			onUpdate(aDt);
			var p:Point = mPos.clone();
			
			// revert changes
			mPathTime = currentTime;
			onUpdate(0);
			
			return p;
		}
		
		public function pause():void
		{
			mIsMoving = false;
		}
		public function play():void
		{
			mIsMoving = true;
		}
	}

}