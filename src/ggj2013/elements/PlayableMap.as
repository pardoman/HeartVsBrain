package ggj2013.elements 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ggj2013.Camera;
	import ggj2013.Constants;
	import ggj2013.DepthManager;
	import ggj2013.Entity;
	import ggj2013.maps.BasicBackground;
	import ggj2013.maps.MainTerrain;
	import ggj2013.maps.MapLevel1;
	import ggj2013.particles.ParticlesManager;
	import ggj2013.ui.LifeBar;
	/**
	 * ...
	 * @author Federico Medina
	 */
	public class PlayableMap extends Entity
	{
		private var m_layer:Sprite = new Sprite;
		private var m_layerMap:Sprite = new Sprite;
		private var m_layerForeMap:Sprite = new Sprite;
		private var m_layerShadows:Sprite = new Sprite;
		private var m_layerParticles:Sprite = new Sprite;
		private var m_layerPlayer:Sprite = new Sprite;
		private var m_layerSpotlight:Sprite = new Sprite;
		private var m_layerArrow:Sprite = new Sprite;
		
		private var m_player:Player;
		private var m_camera:Camera;
		private var m_spotLight:SpotLight;
		private var m_background:BasicBackground;
		private var m_particlesMgr:ParticlesManager;
		private var m_lastManchaPos:Point = new Point;
		private var m_timeBloodSpot:Number = 0;
		//private var m_portal:Portal;
		private var m_depthManager:DepthManager;
		
		private var m_portalPositions:Vector.<Point> = new Vector.<Point>;
		private var m_pieces:Vector.<NumberPiece> = new Vector.<NumberPiece>;
		private var m_piecesIndex:int = 0;
		
		private var m_objectiveArrow:ArrowThing;
		
		public function PlayableMap(_layer:Sprite) 
		{
			m_portalPositions.push(new Point(1688, 1594));
			m_portalPositions.push(new Point(781,1394));
			m_portalPositions.push(new Point(887,2594));
			m_portalPositions.push(new Point(2957,1713));
			m_portalPositions.push(new Point(2407,475));
			m_portalPositions.push(new Point(1431,331));
			m_portalPositions.push(new Point(2400,2882));
			m_portalPositions.push(new Point(118,562));
			m_portalPositions.push(new Point(3845,2175));
			
			//Depth manager
			m_depthManager = new DepthManager(m_layerPlayer);
			
			//Add Map Layer
			_layer.addChild(m_layer);
			m_layer.addChild(m_layerMap);
			m_layer.addChild(m_layerShadows);
			m_layer.addChild(m_layerParticles);
			m_layer.addChild(m_layerPlayer);
			m_layer.addChild(m_layerForeMap);
			m_layer.addChild(m_layerSpotlight);
			m_layer.addChild(m_layerArrow);
			
			//Create a background
			m_background = new MainTerrain(m_layerMap, m_layerForeMap);
			//m_background = new MapLevel1(m_layerMap, m_layerForeMap);
			addChild(m_background);
			
			//crate spotlight
			m_spotLight = new SpotLight();
			m_layerSpotlight.addChild(m_spotLight);
			
			//Create main character
			m_player = new Player(m_layerPlayer, m_layerShadows, m_spotLight, new Point(1963,1594));
			addChild(m_player);
			m_depthManager.add(m_player);
			
			//Create camera
			var worldLimits:Point = new Point(m_background.getWidth, m_background.getHeight);
			m_camera = new Camera(m_layer, worldLimits);
			addChild(m_camera);
			m_camera.forceAt(m_player.getPos());
			
			//Arrow
			m_objectiveArrow = new ArrowThing(m_layerArrow);
			addChild(m_objectiveArrow);
			
			//Create items
			createContent();
			
			//Particles
			m_particlesMgr = new ParticlesManager(m_layerParticles);
			
		}
		
		public function addPortal():void
		{
			/*
			  start-1963,1594
			  portals:
				1-1688,1594
				2-781,1394
				3-887,2594
				4-2957,1713
				5-2407,475
				6-1431,331
				7-2400,2882
				8-118,562
				9-3845,2175
			 * */
			
			var portalId:int = 1;
			
			//m_portal = new Portal(m_layerMap, m_portalPositions[portalId-1], portalId);
			//addChild(m_portal);
		}
		
		private function createContent():void 
		{
			var i:int;
			var xx:Number;
			var yy:Number;
			var vPos:Point;
			var item:MapElement;
			
			var enemyData:Array = new Array;
			enemyData.push([1525,187,1619,275]);
			enemyData.push([1619,87,1706,168]);
			enemyData.push([1700,12,1813,131]);
			enemyData.push([2263,568,2344,625]);
			enemyData.push([2469,387,2294,581]);
			enemyData.push([2307,744,2475,1606]);
			enemyData.push([2269,1044,2869,1169]);
			enemyData.push([2569,1025,2951,1350]);
			enemyData.push([2738,1650,2851,950]);
			enemyData.push([2738,1650,2313,1344]);
			enemyData.push([2738,1650,3201,1800]);
			enemyData.push([3032,1594,2275,2182]);
			enemyData.push([3101,1881,3426,2532]);
			enemyData.push([3526,2488,3194,1856]);
			enemyData.push([3132,2025,3276,1969]);
			enemyData.push([3251,2194,3382,2138]);
			enemyData.push([3890,2365,3523,551]);
			enemyData.push([3467,1124,3684,1758]);
			enemyData.push([2983,1207,3690,1235]);
			enemyData.push([3495,1552,3695,1363]);
			enemyData.push([3528,1781,3773,1547]);
			enemyData.push([3812,1714,3701,1792]);
			enemyData.push([3718,1909,3851,1836]);
			enemyData.push([3437,1998,3862,1925]);
			enemyData.push([3885,2226,3250,2443]);
			enemyData.push([3912,2315,3150,2599]);
			enemyData.push([2866,3178,2103,2671]);
			enemyData.push([1781,3245,2766,2727]);
			enemyData.push([2816,2597,1725,3139]);
			enemyData.push([1230,2938,1987,2577]);
			enemyData.push([1925,2443,2248,2565]);
			enemyData.push([567,2126,923,2643]);
			enemyData.push([166,2482,617,1536]);
			enemyData.push([745,1569,144,2193]);
			enemyData.push([795,1842,1341,2326]);
			enemyData.push([1397,2282,829,1770]);
			enemyData.push([868,1569,985,1424]);
			enemyData.push([1040,1475,1241,1781]);
			enemyData.push([1118,1296,1224,706]);
			enemyData.push([1513,1196,1046,1146]);
			enemyData.push([1085,1029,1241,1046]);
			enemyData.push([1291,918,1107,896]);
			enemyData.push([751,1096,528,740]);
			enemyData.push([517,929,1079,506]);
			enemyData.push([751,896,83,762]);
			enemyData.push([83,762,272,256]);
			enemyData.push([272,256,1068,500]);
			enemyData.push([918,729,795,500]);
			enemyData.push([812,784,712,612]);
			enemyData.push([439,890,512,745]);
			enemyData.push([311,868,367,734]);
			enemyData.push([679,417,729,278]);
			enemyData.push([478,395,528,250]);


			//Enemies
			for each (var eData:Object in enemyData)
			{
				item = new LittleBrain(m_layerPlayer, m_layerShadows, eData);
				addChild(item);
				m_depthManager.add(item);
			}
			
			//Pills
			var pillPositions:Array = new Array;
			pillPositions.push(new Point(1909,1090));
			pillPositions.push(new Point(1374, 773));
			pillPositions.push(new Point(1998,3206));
			pillPositions.push(new Point(2799,1207));
			pillPositions.push(new Point(3033,2866));
			pillPositions.push(new Point(740,712));
			pillPositions.push(new Point(217,350));
			pillPositions.push(new Point(3445,2376));
			pillPositions.push(new Point(3673, 1480));
			for (i = 0; i < pillPositions.length; i++ )
			{
				var pillPos2:Point = pillPositions[i] as Point;
				item = new Pill(m_layerPlayer, m_layerShadows, pillPos2, 2);
				addChild(item);
				m_depthManager.add(item);
			}
			
			//Numbers
			for (i = 1; i <= 9; i++)
			{
				var isActive:Boolean = (i == 1);
				vPos = m_portalPositions[i - 1];
				var piece:NumberPiece = new NumberPiece(m_layerPlayer, m_layerShadows, vPos, i, isActive);
				item = piece;
				addChild(item);
				m_pieces.push(piece);
				m_depthManager.add(item);
			}
			m_piecesIndex = 0;
		}
		
		private function updateArroPow():void
		{
			var currentPiece:NumberPiece = null;
			
			if (m_piecesIndex < m_pieces.length) {
				currentPiece = m_pieces[m_piecesIndex];
			}
			if (currentPiece == null) {
				m_objectiveArrow.setNoTarget();
				return;
			}
			
			var dir:Point = currentPiece.getPos().subtract(m_player.getPos());
			if (dir.length > 300) {
				dir.normalize(300);
			}
			m_objectiveArrow.setTargetPos(m_player.getPos().add(dir), dir);
		}
		
		override protected function onUpdate(aDt:Number):void 
		{
			var playerPos:Point = m_player.getPos();
			m_camera.centerAt(playerPos);
			
			//draw into the background
			m_timeBloodSpot -= aDt;
			if (m_timeBloodSpot < 0 || Point.distance(m_lastManchaPos, playerPos) > Constants.DISTANCE_BLOOD_SPOT)
			{
				//draw blood spot
				m_background.drawMancha(playerPos);
				
				//reset variables
				m_timeBloodSpot = Constants.TIME_BLOOD_SPOT;				
				m_lastManchaPos.x = playerPos.x;
				m_lastManchaPos.y = playerPos.y;
			}
			
			updateArroPow();
			
			m_depthManager.sort();
		}
		
		override protected function onRender():void 
		{
			//TODO?
		}
		
		public function collidePlayerWithTerrain(aDt:Number):void
		{
			var vBitmap:Bitmap = m_background.getCollisionMap;
			if (vBitmap == null) {
				return;
			}
			
			var vBitmapData:BitmapData = vBitmap.bitmapData;
			
			var posPlayer:Point = m_player.getPos();
			var xPos:int = int(posPlayer.x);
			var yPos:int = int(posPlayer.y);
			
			var pixel:uint = vBitmapData.getPixel(xPos, yPos);
			if (pixel == 0)
			{
				m_player.collideToWall();
			}
		}
		
		override protected function onMessage(_message:String, _args:*):void 
		{
			if (_message == "got_number")
			{
				//var number:int = int(_args);
				m_piecesIndex++;
				
				if (m_piecesIndex < m_pieces.length)
				{
					//Next
					m_pieces[m_piecesIndex].activate();
				}
				else
				{
					//Win!
				}
			}
			else if (_message == "player_dead")
			{
				//reset the game
				LifeBar.inst.resetLifeBar();
				var entitiesToReset:Array = this.getEntitiesOfType(MapElement);
				for each (var mapElement:MapElement in entitiesToReset)
				{
					mapElement.onMapReset();
				}
				
				m_piecesIndex = 0;
				m_camera.forceAt(m_player.getPos());
				messageParent("onMapReset",null);
				
			}
			else if (_message == "got_pill")
			{
				LifeBar.inst.addLife();
			}
		}
	}

}