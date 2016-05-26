package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Enemies.BossDragon;
	import com.chameleonquest.Enemies.BossSandworm;
	import com.chameleonquest.LevelCompleteState;
	import com.chameleonquest.Main;
	import com.chameleonquest.Objects.TunnelEntrance;
	import com.chameleonquest.PlayState;
	import com.chameleonquest.Preloader;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	
	public class Room3_7State extends PlayState
	{		
		[Embed(source = "../../../../assets/mapCSV_3-7_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		private const EMERGENCE_TIME:Number = 10;
		private var bossTimer:Number;
		private var tunnels:FlxGroup;
		private var boss:BossSandworm;
		
		public function Room3_7State() 
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			
			boss = new BossSandworm(0, 0);
			add(boss);
			//enemies.add(boss);
			
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Chameleon(0, 29);
			Preloader.logger.logLevelStart(21, {"src": 20});
			Preloader.tracker.trackPageview("/level-21");
			Preloader.tracker.trackEvent("level-21", "level-enter", null, 20);
			
			tunnels = new FlxGroup();
			
			// TODO
			tunnels.add(new TunnelEntrance(16 * 20, 16 * (ROOM_HEIGHT - 3)));
			tunnels.add(new TunnelEntrance(16 * 2, 16 * 19));
			//tunnels.add(new TunnelEntrance(**, **));
			//tunnels.add(new TunnelEntrance(**, **));
			bgElems.add(tunnels);
			
			//boss = new BossSandworm(0, 0);
			//enemies.add(boss);
			
			bossTimer = 0;
			
			//Main.lastRoom = 21;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16) {
				Preloader.logger.logLevelEnd({"dest": 22, "time": playtime});
				Preloader.tracker.trackPageview("/level-21-end");
				Preloader.tracker.trackEvent("level-21", "level-end", null, int(Math.round(playtime)));
				FlxG.switchState(new LevelCompleteState(playtime));
			}
			
			if (bossTimer > EMERGENCE_TIME)
			{
				// emerge!
				do
				{
					var tunnel:TunnelEntrance = tunnels.getRandom() as TunnelEntrance;
				}
				while (!tunnel.isOpen);
				
				boss.emergeFrom(tunnel);
				
				bossTimer = -EMERGENCE_TIME;
			}
			
			bossTimer += FlxG.elapsed;
		}
	}

}