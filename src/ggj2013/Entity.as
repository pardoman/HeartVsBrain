package ggj2013 
{
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class Entity
	{
		private var mIsDead:Boolean = false;
		private var mChildren:Vector.<Entity> = new Vector.<Entity>;
		protected var m_parent:Entity;
		
		public function Entity() 
		{
			
		}
		
		/////////////////////////////////////
		public function update(aDt:Number):void
		{
			for ( var i:int = 0; i < mChildren.length; i++ ) {
				mChildren[i].update(aDt);
				if ( mChildren[i].isDead() ) {
					mChildren[i].destroy();
					mChildren.splice(i, 1);
					i--;
				}
			}
			onUpdate(aDt);
		}
		
		public function render():void
		{
			for ( var i:int = 0; i < mChildren.length; i++ ) {
				mChildren[i].render();
			}
			onRender();
		}
		
		public function destroy():void
		{
			for ( var i:int = 0; i < mChildren.length; i++ ) {
				mChildren[i].destroy();
			}
			onDestroy();
		}
		
		/////////////////////////////////////
		protected function onUpdate(aDt:Number):void
		{	
		}
		protected function onRender():void
		{	
		}
		protected function onDestroy():void
		{
		}
		
		/////////////////////////////////////
		public function die():void
		{
			mIsDead = true;
		}
		public function isDead():Boolean
		{
			return mIsDead;
		}
		
		/////////////////////////////////////
		public function addChild(aEntity:Entity):void
		{
			mChildren.push(aEntity);
			aEntity.m_parent = this;
		}
		
		public function messageParent(_message:String, _args:*):void
		{
			m_parent.onMessage(_message, _args);
		}
		
		protected function onMessage(_message:String, _args:*):void
		{
			//TODO: Override
		}
		
		public function getEntitiesOfType(_class:Class):Array
		{
			var array:Array = new Array;
			
			for each(var entity:Entity in mChildren)
			{
				if (entity is _class) {
					array.push(entity);
				}
			}
			
			return array;
		}
		
	}

}