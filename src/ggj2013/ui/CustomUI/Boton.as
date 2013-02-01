package ggj2013.ui.CustomUI
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ggj2013.AudioManager;
	import ggj2013.ui.MainMenu;
	
	//:::NOTA::://
	//Al hacer click en el boton genera un eventDispacher en el cual lo hereda el STAGE:
	//El parametro _nameEvent le da nombre a ese EventDispacher:
	//Si no le erro, con ese evento podes importar el SWF y dentro de tu codigo llamas al al evento desde el "stage":
	//:::Ejem::://
	//stage.addEventListener("START",function()->Cualquier funcion):
	//Espero que no lo tomes a mal este ejemplo jejej a mi me dejas re pintado cuando programas XD:
	public class  Boton extends Sprite
	{
		private var imgClick:Bitmap=new Bitmap();
		private var imgOver:Bitmap=new Bitmap();
		private var imgOut:Bitmap=new Bitmap();
				
		private var nameEvent:String;
		
		private var m_mainMenu:MainMenu;
		
		public function Boton(_imgClick:Bitmap,		//Insertamos los mapas de bit que tienen las imagenes.
							  _imgOver:Bitmap,
							  _imgOut:Bitmap,
							  _nameEvent:String,	//Le damos un nombre al Evento que creamos;
							  _mainMenu:MainMenu //Dirigimos el evento hacia el MainMenu
							  ):void {
			
			imgClick = _imgClick;
			imgOver = _imgOver;
			imgOut = _imgOut;
			
			nameEvent = _nameEvent;
			
			m_mainMenu = _mainMenu;
			
			this.addEventListener(MouseEvent.CLICK, clickButton, false, 0, true);	//Crea un eventDispacher para que pueda ejecutar una funcion externa.
								  
			this.addEventListener(MouseEvent.MOUSE_DOWN, downImg, false, 0, true);	//Cuando baja cambia a imagen click;
			this.addEventListener(MouseEvent.MOUSE_UP, upImg, false, 0, true);		//Cuando sube restaura el estado de over;
			this.addEventListener(MouseEvent.MOUSE_OVER, overImg, false, 0, true);	//Cuando entra cambia a imagen over;
			this.addEventListener(MouseEvent.MOUSE_OUT, outImg, false, 0, true);	//Cuando sale cambia a imagen out;
			
			addChild(imgOut);

		}
		
		private function clickButton(c:MouseEvent):void {
			m_mainMenu.clickButton(this);
			AudioManager.inst.playButtonClickSound();
		}
		private function downImg(d:MouseEvent):void {
			addChild(imgClick);
			removeChild(imgOver);
		}
		private function upImg(u:MouseEvent):void {
			addChild(imgOver);
			removeChild(imgClick);
		}
		private function overImg(ov:MouseEvent):void {
			addChild(imgOver);
			removeChild(imgOut);
			AudioManager.inst.playMouseOverSound();
		}
		private function outImg(ou:MouseEvent):void {
			addChild(imgOut);
			removeChild(imgOver);
		}
		
		
		
		
	}
	
}