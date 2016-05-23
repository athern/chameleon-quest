package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.*;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room2_1State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_2-1_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
				
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 15;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			
			Preloader.logger.logLevelStart(8, {"src": 7});
			Preloader.tracker.trackPageview("/level-8");
			Preloader.tracker.trackEvent("level-8", "level-enter", null, 7);
				
			player = new Chameleon(ROOM_WIDTH - 1, ROOM_HEIGHT - 1);
			
			player.facing = FlxObject.LEFT;
			
			elems.add(new Platform(new Array(new FlxPoint(16*16, 16 * 5), new FlxPoint(21 * 16, 16*5)), 60));
			
			// add spikes
			Spikes.addSpikeRow(3, ROOM_HEIGHT - 1, 5, enemies);
			Spikes.addSpikeRow(11, ROOM_HEIGHT - 1, 4, enemies);
			
			bgElems.add(new Pile(9, (ROOM_HEIGHT - 2)));
			
			enemies.add(new Snake(16, 16 * 3, 16 * (ROOM_HEIGHT - 8)));
			enemies.add(new Bird(16 * 9, 16 * 23, 16 * 2));
			
			bgElems.add(new WaterFountain(ROOM_WIDTH - 9, ROOM_HEIGHT - 1));
			
			grates.add(new Grate(ROOM_WIDTH - 3, 2));
			grates.add(new Grate(ROOM_WIDTH - 3, 3));
			
			bgElems.add(grates);
			
			Main.lastRoom = 8;
			
			super.create();
			
			var hint:FlxText;
			hint = new FlxText(315, 160, 70, "C");
			hint.setFormat(null, 14, 0x555555, "center");
			hint.alpha = .5;
			this.add(hint);
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x > ROOM_WIDTH * 16 - 16 && player.y <= 4 * 16) {
				Preloader.logger.logLevelEnd({"dest": 9, "time": playtime});
				Preloader.tracker.trackPageview("/level-8-end");
				Preloader.tracker.trackEvent("level-8", "level-end", null, int(Math.round(playtime)));
				
				FlxG.switchState(new LevelCompleteState(playtime));
			}
			
			if (player.x > ROOM_WIDTH * 16 - 16 && player.y > (ROOM_HEIGHT - 2) * 16) {
				player.x = ROOM_WIDTH * 16 - 16;		
			}
		}
		
	}

}