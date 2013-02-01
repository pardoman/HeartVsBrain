package ggj2013.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ggj2013.AudioManager;
	import ggj2013.ui.CustomUI.Boton;
	import ggj2013.ui.CustomUI.Menu;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class MainMenu extends Sprite
	{
		//Imagenes del fondo:
		[Embed(source = "Img/BackGround/Menu_001.png")]	 private var BackGround:Class;
		private var img_backGround:Bitmap = new BackGround;
		
		//Imagenes para el boton START;
		[Embed(source = "Img/Start/Start_Click.png")]	 private var START_CLICK:Class;
		[Embed(source = "Img/Start/Start_Out.png")]		 private var START_OUT:Class;
		[Embed(source = "Img/Start/Start_Over.png")]	 private var START_OVER:Class;
		
		private var img_start_CLICK:Bitmap = new START_CLICK;
		private var img_start_OVER:Bitmap = new  START_OVER;
		private var img_start_OUT:Bitmap = new START_OUT;
		
		//Imagenes para el boton CREDITS
		[Embed(source = "Img/Credits/Credit_Click.png")]	private var CREDITS_CLICK:Class;
		[Embed(source = "Img/Credits/Credit_Out.png")]		private var CREDITS_OUT:Class;
		[Embed(source = "Img/Credits/Credit_Over.png")]	 	private var CREDITS_OVER:Class;
		
		private var img_credit_CLICK:Bitmap = new CREDITS_CLICK;
		private var img_credit_OVER:Bitmap = new  CREDITS_OVER;
		private var img_credit_OUT:Bitmap = new CREDITS_OUT;
		
		//Imagenes para el boton EXIT
		[Embed(source = "Img/Exit/Exit_Click.png")]	 	private var EXIT_CLICK:Class;
		[Embed(source = "Img/Exit/Exit_Out.png")]		private var EXIT_OUT:Class;
		[Embed(source = "Img/Exit/Exit_Over.png")]	 	private var EXIT_OVER:Class;
		
		private var img_exit_CLICK:Bitmap = new EXIT_CLICK;
		private var img_exit_OVER:Bitmap = new  EXIT_OVER;
		private var img_exit_OUT:Bitmap = new EXIT_OUT;
		
		//Creamos los botones;
		private var startButton:Boton;
		private var creditButton:Boton;
		private var exitButton:Boton;
												  
		//Este array posee los botones;
		private var buttonArray:Array = new Array();

		private var m_isOver:Boolean = false;

		
		[Embed(source = "Img/Credits/Credits.jpg")] private static const CREDITS_THING:Class;
		private var m_sprCredits:Sprite;
		
		public function MainMenu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			startButton = new Boton(img_start_CLICK, 
												  img_start_OVER,
												  img_start_OUT,
												  "START",
												  this);
		
			creditButton = new Boton(img_credit_CLICK, 
												  img_credit_OVER,
												  img_credit_OUT,
												  "CREDITS",
												  this);

			exitButton = new Boton(img_exit_CLICK, 
												  img_exit_OVER,
												  img_exit_OUT,
												  "EXIT",
												  this);
		
			
			//insertamos el fondo;
			addChild(img_backGround);
			
			
			//Insertamos los botones en un array:
			buttonArray.push(startButton);
			buttonArray.push(creditButton);
			buttonArray.push(exitButton);
			
			exitButton.visible = false;
			
			m_sprCredits = new Sprite;
			var creditsBitmap:Bitmap = new CREDITS_THING;
			m_sprCredits.addChild(creditsBitmap);
			addChild(m_sprCredits);
			m_sprCredits.visible = false
			m_sprCredits.addEventListener(MouseEvent.CLICK, onClickCredits, false, 0, true);
			m_sprCredits.buttonMode = true;
			
			//Creamos el menu y lo centramos:
			var menuGame:Menu = new Menu(buttonArray);
				menuGame.x = stage.stageWidth / 2;
				menuGame.y = (stage.stageHeight - menuGame.height);
				addChild(menuGame);
		}
		
		private function onClickCredits(e:MouseEvent):void 
		{
			m_sprCredits.visible = false;
			creditButton.visible = true;
			startButton.visible = true;
			AudioManager.inst.playButtonClickSound();
		}
		
		public function beginGame():Boolean
		{
			return m_isOver;
		}
		
		public function clickButton(btn:Boton):void
		{
			if (btn == startButton) {
				m_isOver = true;
			}
			else if (btn == creditButton) {
				creditButton.visible = false;
				startButton.visible = false;
				m_sprCredits.visible = true;
			}
		}
	}

}