package ggj2013
{
	import flash.display.Sprite;
	import flash.events.Event;
	import ggj2013.comics.InitialComic;
	import ggj2013.ui.MainMenu;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class Main extends Sprite 
	{
		private var m_mainMenu:MainMenu;
		private var m_gameContainer:GameContainer;
		private var m_comicStart:InitialComic;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//Initialize systems
			Input.init(stage);
			Input.registerListeners();
			new AudioManager; // Singleton
			
			//Hook main loop
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
			
			
			m_mainMenu = new MainMenu();
			addChild(m_mainMenu);
		}
		
		private function initComic():void
		{
			//Comic
			m_comicStart = new InitialComic();
			addChild(m_comicStart);
		}
		
		private function initializeGame():void
		{
			//Initialize game
			m_gameContainer = new GameContainer(this);
			m_gameContainer.goToMainMapFrom(0);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			var dt:Number = 1.0 / stage.frameRate;
			
			if (m_gameContainer != null)
			{
				m_gameContainer.update(dt);
				m_gameContainer.render();	
			}
			else if (m_comicStart != null)
			{
				if (m_comicStart.isOver())
				{
					m_comicStart.parent.removeChild(m_comicStart);
					m_comicStart = null;
					initializeGame();
				}
			}
			else if (m_mainMenu != null)
			{
				if (m_mainMenu.beginGame()) {
					m_mainMenu.parent.removeChild(m_mainMenu);
					m_mainMenu = null;
					initComic();
				}
			}
			
			Input.inst.update();
		}
		
	}
	
}