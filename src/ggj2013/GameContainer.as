package ggj2013 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import ggj2013.elements.PlayableMap;
	import ggj2013.ui.GenericOverlay;
	import ggj2013.ui.LifeBar;
	import ggj2013.ui.NumbersHud;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class GameContainer extends Entity 
	{
		private var m_layer:DisplayObjectContainer;
		private var m_mapLayer:Sprite = new Sprite;
		private var m_hudLayer:Sprite = new Sprite;
		
		private var m_map:PlayableMap;
		private var m_lifeBar:LifeBar;
		private var m_numbersHud:NumbersHud;
		private var m_genericOverlay:GenericOverlay;
		
		public function GameContainer(_layer:DisplayObjectContainer) 
		{
			m_layer = _layer;
			
			//Set layer order
			m_layer.addChild(m_mapLayer);
			m_layer.addChild(m_hudLayer);
			
			new CollisionsManager; // Singleton
			CollisionsManager.inst.setRule( Constants.TYPE_SONAR, Constants.TYPE_ITEM );
			CollisionsManager.inst.setRule( Constants.TYPE_PLAYER, Constants.TYPE_NUMBER_PIECE );
			CollisionsManager.inst.setRule( Constants.TYPE_PLAYER, Constants.TYPE_PORTAL );
			CollisionsManager.inst.setRule( Constants.TYPE_PLAYER, Constants.TYPE_PILL );
			CollisionsManager.inst.setRule( Constants.TYPE_PLAYER, Constants.TYPE_ENEMY );
			
			AudioManager.inst.startMusic();
			
			m_lifeBar = new LifeBar(m_hudLayer);
			addChild(m_lifeBar);
			
			m_numbersHud = new NumbersHud(m_hudLayer);
			addChild(m_numbersHud);
			
			m_genericOverlay = new GenericOverlay(m_hudLayer);
			addChild(m_genericOverlay);
			
		}
		
		public function goToMainMapFrom(_fromWhere:int):void
		{
			m_map = new PlayableMap(m_mapLayer);
			addChild(m_map);
			m_map.addPortal();
		}
		
		override protected function onUpdate(aDt:Number):void 
		{
			//Collisions with terrain
			m_map.collidePlayerWithTerrain(aDt);
			
			//Collisions with items and enemies
			CollisionsManager.inst.checkCollisions();
		}
		
		override protected function onMessage(_message:String, _args:*):void 
		{
			if (_message == "onMapReset")
			{
				m_numbersHud.onMapReset();
			}
		}
		
	}

}