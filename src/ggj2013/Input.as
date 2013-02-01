package ggj2013 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class Input
	{
		private static var mInst:Input = null;
		
		private var mStage:Stage;
		
		private var mMouseIsDown:Boolean;
		private var mMousePressed:Boolean;
		private var mMouseReleased:Boolean;
		
		private var mKeysDown:Vector.<uint>;
		private var mKeysPressed:Vector.<uint>;
		private var mKeysReleased:Vector.<uint>;
		
		public function Input(aStage:Stage) 
		{
			mStage = aStage;
			
			mMouseIsDown = false;
			mMousePressed = false;
			mMouseReleased = false;
			
			mKeysDown = new Vector.<uint>;
			mKeysPressed = new Vector.<uint>;
			mKeysReleased = new Vector.<uint>;
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			mMouseIsDown = true;
			mMousePressed = true;
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			mMouseIsDown = false;
			mMouseReleased = true;
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			var vKey:uint = e.keyCode;
			if ( mKeysDown.indexOf(vKey) == -1) {
				mKeysDown.push(vKey);
				mKeysPressed.push(vKey);
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			var vKey:uint = e.keyCode;
			var vIndex:int = mKeysDown.indexOf(vKey);
			if ( vIndex != -1 ) {
				mKeysDown.splice(vIndex, 1);
			}
			mKeysReleased.push(vKey);
		}
		
		public function update():void 
		{
			mMousePressed  = false;
			mMouseReleased = false;
			
			mKeysPressed.splice(0, mKeysPressed.length);
			mKeysReleased.splice(0, mKeysReleased.length);
		}
		
		public function beginListening():void
		{
			/// Register Mouse listeners
			mStage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			mStage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			/// Register Keyboard listeners
			mStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			mStage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public static function init(aStage:Stage):void 
		{
			if ( mInst != null ) {
				throw new Error("Input has already registered Mouse & Keyboard listeners.");
			}
			mInst = new Input(aStage);
		}
		
		public static function registerListeners():void 
		{
			mInst.beginListening();
		}
		public static function get inst():Input 
		{ 
			return mInst;
		}
		
		
		/// Keyboard functions that operate on strings of length 1
		public function isKeyDown(aCharacter:String):Boolean {
			var vKey:uint = aCharacter.charCodeAt(0);
			return mKeysDown.indexOf(vKey) != -1;
		}
		public function isKeyPressed(aCharacter:String):Boolean {
			var vKey:uint = aCharacter.charCodeAt(0);
			return mKeysPressed.indexOf(vKey) != -1;
		}
		public function isKeyReleased(aCharacter:String):Boolean {
			var vKey:uint = aCharacter.charCodeAt(0);
			return mKeysReleased.indexOf(vKey) != -1;
		}
		
		/// Keyboard functions that operate on KeyCodes from Keyboard class.
		public function isKeyCodeDown(aKeyCode:uint):Boolean {
			return mKeysDown.indexOf(aKeyCode) != -1;
		}
		public function isKeyCodePressed(aKeyCode:uint):Boolean {
			return mKeysPressed.indexOf(aKeyCode) != -1;
		}
		public function isKeyCodeReleased(aKeyCode:uint):Boolean {
			return mKeysReleased.indexOf(aKeyCode) != -1;
		}
		
		/// Mouse functions
		public function isMouseDown():Boolean {
			return mMouseIsDown;
		}
		public function isMousePressed():Boolean {
			return mMousePressed;
		}
		public function isMouseReleased():Boolean {
			return mMouseReleased;
		}
		public function getMouseX():Number {
			return mStage.mouseX;
		}
		public function getMouseY():Number {
			return mStage.mouseY;
		}
		
		
	}

}