package ggj2013.comics 
{
	import com.greensock.BlitMask;
	import com.greensock.easing.Quad;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import ggj2013.AudioManager;
	
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class InitialComic extends Sprite 
	{
		[Embed(source = "../../../lib/comics/historieta.jpg")] private static const COMIC_PANEL:Class;
		
		private var m_isOver:Boolean = false;
		private var m_step:int = 0;
		private var m_sprBlack:Sprite = new Sprite;
		private var m_comicSpr:Bitmap;
		
		public function InitialComic() 
		{
			m_comicSpr = new COMIC_PANEL;
			addChild(m_comicSpr);
			addChild(m_sprBlack);
			
			m_sprBlack.graphics.beginFill(0);
			m_sprBlack.graphics.drawRect(0, 0, 800, 600);
			m_sprBlack.graphics.endFill();
			m_sprBlack.alpha = 0;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
			
			m_comicSpr.x = 800;
			m_comicSpr.y = -104;
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			nextStep();
		}
		
		private function beginAnimation():void 
		{
			
		}
		
		private function nextStep(bla:*=null):void
		{
			m_step++;
			
			var time2:Number = 3.367;
			var time3:Number = 5.500; 
			var time4:Number = 7.769; 
			var time5:Number = 9.955; 
			
			time5 -= time4;
			time4 -= time3;
			time3 -= time2;
			
			switch (m_step)
			{
				case 1:
					TweenLite.to(m_comicSpr, 0.5, { x:122 , y: -104, delay:1, ease:Quad.easeOut, onComplete:nextStep } );
					break;
				case 2:
					AudioManager.inst.startComic(); //IM AT THE FIRST FRAME
					TweenLite.to(m_comicSpr, 0.5, { x:-355 , y: -104, delay:(time2-0.5), ease:Quad.easeOut, onComplete:nextStep } );
					break;
				case 3: //IM AT THE 2ND FRAME
					TweenLite.to(m_comicSpr, 0.5, { x:-896 , y: -104, delay:(time3-0.5), ease:Quad.easeOut, onComplete:nextStep } );
					break;
				case 4: //IM AT THE 3RD FRAME
					TweenLite.to(m_comicSpr, 0.5, { x:-141 , y: -509, delay:(time4-0.5), ease:Quad.easeOut, onComplete:nextStep } );
					break;
				case 5: //IM AT THE 4TH FRAME
					TweenLite.to(m_comicSpr, 0.5, { x: -896 , y: -509, delay:(time5-0.5), ease:Quad.easeOut, onComplete:nextStep } );
					break;
				case 6:
					TweenLite.to(m_sprBlack, 0.5, { alpha: 1, ease:Quad.easeOut, delay:2, onComplete:nextStep } );
					break;
				default:
					m_isOver = true;
					break;
					
			}
		}
		
		public function isOver():Boolean
		{
			return m_isOver;
		}
		
	}

}