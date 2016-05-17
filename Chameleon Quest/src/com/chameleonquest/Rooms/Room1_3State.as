package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.WoodBlock;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room1_3State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-3_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			if (Main.lastRoom == 4) {
				Preloader.logger.logLevelStart(1, {"src": 4});
				Preloader.tracker.trackPageview("/level-3");
				Preloader.tracker.trackEvent("level-3", "level-enter", null, 4);
				
				player = new Chameleon(ROOM_WIDTH-2, ROOM_HEIGHT -1);
				player.facing = FlxObject.LEFT;
			}
			else {
				Preloader.logger.logLevelStart(1, {"src": 2});
				Preloader.tracker.trackPageview("/level-3");
				Preloader.tracker.trackEvent("level-3", "level-enter", null, 2);
				
				player = new Chameleon(0, 5);
			}
			
			// add rock pile
			bgElems.add(new Pile(5, 5));
			bgElems.add(new Pile(6, ROOM_HEIGHT - 1));
			
			elems.add(new Platform(new Array(new FlxPoint(13 * 16, (ROOM_HEIGHT - 6) * 16), new FlxPoint(18 * 16, (ROOM_HEIGHT - 6) * 16)), 60));
			
			// add spikes
			Spikes.addSpikeRow(18, 13, 4, enemies);
			Spikes.addSpikeRow(12, ROOM_HEIGHT - 2, 13, enemies);
			
			intrELems.add(new WoodBlock(7, 10));
			intrELems.add(new WoodBlock(10, 10));
			
			// add enemies
			enemies.add(new Bird(11 * 16, 24 * 16, (ROOM_HEIGHT - 8) * 16));
			enemies.add(new Snake(23 * 16, 27 * 16, 10 * 16));
			enemies.add(new Snake(8 * 16, 13 * 16, 3 * 16));
			
			Turtle.addTurtleStack(16 * 16, 16 * 3, 2, enemies),
			
			Main.lastRoom = 3;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16) {
				Preloader.logger.logLevelEnd({"dest": 4, "time": playtime});
				Preloader.tracker.trackPageview("/level-3-end");
				Preloader.tracker.trackEvent("level-3", "level-end", null, int(Math.round(playtime)));
				
				FlxG.switchState(new LevelCompleteState(playtime, 60, 20));
			}
		}
		
	}

}