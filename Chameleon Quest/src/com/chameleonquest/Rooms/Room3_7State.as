package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Enemies.BossDragon;
	import com.chameleonquest.Enemies.BossSandworm;
	import com.chameleonquest.LevelCompleteState;
	import com.chameleonquest.Main;
	import com.chameleonquest.Objects.Platform;
	import com.chameleonquest.Objects.TNT;
	import com.chameleonquest.Objects.Torch;
	import com.chameleonquest.Objects.TunnelEntrance;
	import com.chameleonquest.PlayState;
	import com.chameleonquest.Preloader;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	
	public class Room3_7State extends PlayState
	{		
		[Embed(source = "../../../../assets/mapCSV_3-7_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		private const EMERGENCE_TIME:Number = 5;
		private var bossTimer:Number;
		private var tunnels:FlxGroup;
		private var boss:BossSandworm;
		
		public function Room3_7State() 
		{
			ROOM_WIDTH = 43;
			ROOM_HEIGHT = 30;
			
			boss = new BossSandworm(0, 0);
			add(boss);
			
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Chameleon(15, 3);//(0, 29);
			Preloader.logger.logLevelStart(21, {"src": 20});
			Preloader.tracker.trackPageview(Preloader.flag + "/level-21");
			Preloader.tracker.trackEvent("level-21", "level-enter", null, 20);
			
			elems.add(new Platform(new Array(new FlxPoint(2 * 16, 17 * 16), new FlxPoint(2 * 16, 9 * 16), new FlxPoint(5 * 16, 9 * 16)), 50));
			elems.add(new Platform(new Array(new FlxPoint(15 * 16, 18 * 16), new FlxPoint(25 * 16, 18 * 16)), 50));
			
			bgElems.add(new Torch(7, 29));
			
			tunnels = new FlxGroup();
			tunnels.add(new TunnelEntrance(16 * 21, 16 * (ROOM_HEIGHT - 3)));
			tunnels.add(new TunnelEntrance(16 * 5, 16 * 19));
			tunnels.add(new TunnelEntrance(16 * 19, 16 * 3, true));
			tunnels.add(new TunnelEntrance(16 * 40, 16 * 3, true));
			bgElems.add(tunnels);
			
			for (var i:int = 0; i < 4; i++)
			{
				//this.createTNT(i);
			}
			
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
				Preloader.tracker.trackPageview(Preloader.flag + "/level-21-end");
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
		
		private function createTNT(tunnelID:Number):void
		{
			var tnt:TNT = null;
			switch(tunnelID)
			{
				case 0:
					tnt = new TNT(27, 29, new Array(new FlxPoint(27 * 16 + 6, 3 * 16 + 6), new FlxPoint(23 * 16 + 6, 3 * 16 + 6)))
					break;
				case 1: 
					break;
				case 2: 
					break;
				case 3:
					break;
			}
			
			elems.add(tnt);
		}
	}

}