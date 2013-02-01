package ggj2013.ui.CustomUI
{
	import flash.display.Sprite;
	
	//Esta clase inserta en un sprite y los botones y los ordena en forma vertical y horizontal:
	//El punto x=0 de este Sprite es el centro del ancho del mismo:
	public class  Menu extends Sprite
	{
		public var marging:uint = 5;
		
		public function Menu(_objArray:Array)		//Enviamos un array que contengan los botones:
		{
			for (var i:uint = 0; i < _objArray.length; i++) {
				_objArray[i].x = - _objArray[i].width / 2;
				_objArray[i].y = (_objArray[i].height + marging) * i;
				addChild(_objArray[i]);
			}
			
		}
	}
	
}