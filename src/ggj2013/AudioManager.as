package ggj2013 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class AudioManager 
	{
		[Embed(source="../../lib/audio.swf", symbol="heartbeat.wav")] private static const HEART_BEAT:Class;
		
		private static var s_inst:AudioManager = null;
		public static function get inst():AudioManager { return s_inst; }
		
		private var mComicMusic:Sound = new Sound;
		private var mBgMusicIntro:Sound = new Sound;
		private var mBgMusicLoop:Sound = new Sound;
		private var mSoundHeartBeat:Sound;
		
		private var mComicMusicChannel:SoundChannel;
		private var mBgMusicIntroChannel:SoundChannel;
		private var mBgMusicLoopChannel:SoundChannel;
		
		private var mBgMusicSndTransf:SoundTransform = new SoundTransform(0.4);
		
		public function AudioManager() 
		{
			s_inst = this;
			
			//begin loading 
			mComicMusic.load(new URLRequest("music/ggj-game2-128.mp3"));
			mBgMusicIntro.load(new URLRequest("music/ggj-game1-128.mp3"));
			mBgMusicLoop.load(new URLRequest("music/ggj-game1-128-sin-intro.mp3"));
			
			mSoundHeartBeat = new HEART_BEAT;
			
			//Global sound management
			SoundMixer.soundTransform = new SoundTransform(0.8);
		}
		
		public function playHeartBeat():void
		{
			mSoundHeartBeat.play(0,0,new SoundTransform(1.5));
		}
		
		public function startComic():void
		{
			mComicMusicChannel = mComicMusic.play();
		}
		
		public function startMusic():void
		{
			mBgMusicIntroChannel = mBgMusicIntro.play(0,0,mBgMusicSndTransf);
			mBgMusicIntroChannel.addEventListener(Event.SOUND_COMPLETE, onCompleteIntroMusic, false, 0, true);
		}
		
		public function stopMusic():void
		{
			mBgMusicIntroChannel.stop();
			mBgMusicLoopChannel.stop();
		}
		
		private function onCompleteIntroMusic(e:Event):void 
		{
			mBgMusicIntroChannel.removeEventListener(Event.SOUND_COMPLETE, onCompleteIntroMusic);
			mBgMusicLoopChannel = mBgMusicLoop.play(0,9999,mBgMusicSndTransf);
		}

		[Embed(source="../../lib/audio.swf", symbol="buttonclick.wav")] private static const SND_BUTTON_CLICK:Class;
		public function playButtonClickSound():void
		{
			var sound:Sound = new SND_BUTTON_CLICK;
			sound.play(0,0);
		}
		
		[Embed(source="../../lib/audio.swf", symbol="buttonhover.wav")] private static const SND_BUTTON_OVER:Class;
		public function playMouseOverSound():void
		{
			var sound:Sound = new SND_BUTTON_OVER;
			sound.play(0,0);
		}
		
		
		[Embed(source="../../lib/audio.swf", symbol="wallcrash3.wav")] private static const SND_WALL_CRASH:Class;
		public function playCrashWall():void
		{
			var sound:Sound = new SND_WALL_CRASH;
			sound.play(0,0);
		}
		
		[Embed(source="../../lib/audio.swf", symbol="powerup.wav")] private static const SND_POWER_UP:Class;
		public function playGramItem():void
		{
			var sound:Sound = new SND_POWER_UP;
			sound.play(0,0);
		}
		
		[Embed(source="../../lib/audio.swf", symbol="quitavida.wav")] private static const SND_CRASH_BRAIN:Class;
		public function playCrashBrain():void
		{
			var sound:Sound = new SND_CRASH_BRAIN;
			sound.play(0,0);
		}
		
		
		[Embed(source = "../../lib/audio.swf", symbol = "wipiii.wav")] private static const SND_HEARPLAY_1:Class;
		[Embed(source = "../../lib/audio.swf", symbol = "yahoo1.wav")] private static const SND_HEARPLAY_2:Class;
		[Embed(source = "../../lib/audio.swf", symbol = "yeah1.wav")] private static const SND_HEARPLAY_3:Class;
		[Embed(source = "../../lib/audio.swf", symbol = "ouuu.wav")] private static const SND_HEARPLAY_4:Class;
		[Embed(source = "../../lib/audio.swf", symbol = "ohno.wav")] private static const SND_HEARPLAY_5:Class;
		public function playRandomSoundHeart():void
		{
			var idSound:int = Math.floor(Math.random() * 5);
			var sound:Sound ;
			switch(idSound)
			{
				case 0:
					sound = new SND_HEARPLAY_1;
					break;
				case 1:
					sound = new SND_HEARPLAY_2;
					break;
				case 2:
					sound = new SND_HEARPLAY_3;
					break;
				case 3:
					sound = new SND_HEARPLAY_4;
					break;
				default:
					sound = new SND_HEARPLAY_5;
					break;
			}
			
			sound.play(0,0);
		}
		
	}

}