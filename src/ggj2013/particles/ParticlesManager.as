package ggj2013.particles 
{
	import flash.geom.Point;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.renderers.BitmapRenderer;

	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;
  
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class ParticlesManager 
	{
		private var m_layer:Sprite;
		private var emitter:Emitter2D;
		private var renderer:BitmapRenderer;
		
		private static var s_inst:ParticlesManager = null;		
		public static function get inst():ParticlesManager { return s_inst; }
		
		public function ParticlesManager(_layer:Sprite) 
		{
			m_layer = _layer;
			s_inst = this;
			
			renderer = new BitmapRenderer( new Rectangle( 0, 0, 400, 400 ) );
			renderer.addFilter( new BlurFilter( 2, 2, 1 ) );
			renderer.addFilter( new ColorMatrixFilter( 
			[ 
			0.8, 0, 0, 0, 0,
			0, .2, 0, 0, 0,
			0, 0, .2, 0, 0,
			0, 0, 0, 0.95, 0 
			] ) );
			m_layer.addChild( renderer );
		}
		
		public function doParticles(_pos:Point):void
		{
			emitter = new Sparkler( renderer );
			renderer.addEmitter( emitter );
			renderer.x = _pos.x-200;
			renderer.y = _pos.y-200;
			emitter.start();
		}
		
	}

}