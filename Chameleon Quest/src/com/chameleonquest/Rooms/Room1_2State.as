package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Rooms.*;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room1_2State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-2_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{	
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			
			if (Main.lastRoom == 3) {
				// logger.logLevelStart(1, {"src": 3});
				Preloader.tracker.trackPageview("/level-2");
				Preloader.tracker.trackEvent("level-2", "level-enter", null, 3);
				
				
				player = new Chameleon(ROOM_WIDTH-2, 3);
				player.facing = FlxObject.LEFT;
			}
			else {
				// logger.logLevelStart(1, {"src": 1});
				Preloader.tracker.trackPageview("/level-2");
				Preloader.tracker.trackEvent("level-2", "level-enter", null, 1);
				
				player = new Chameleon(0, ROOM_HEIGHT-1);
			}
			
			elems.add(new Platform(new Array(new FlxPoint(40, 160), new FlxPoint(19 * 16, 160)), 60));
			
			Spikes.addSpikeRow(21, ROOM_HEIGHT - 2, 2, enemies);
			
			// add rock pile
			bgElems.add(new Pile(11, (ROOM_HEIGHT - 3)));
			bgElems.add(new Pile(ROOM_WIDTH - 3, ROOM_HEIGHT - 8));
			
			// add enemies
			enemies.add(new Snake(16 * 13, 16*15, 16 * (ROOM_HEIGHT - 7)));
			enemies.add(new Snake(16 * 16, 16*18-8, 16 * (ROOM_HEIGHT - 13)));
			enemies.add(new Bird(16 * 6, 16 * 20, 16 * (ROOM_HEIGHT - 22)));
			
			Turtle.addTurtleStack(16 * 19, 16 * (ROOM_HEIGHT - 7), 3, enemies),
			
			Main.lastRoom = 2;
			super.create();
			
			var spacehelp:FlxText;
			spacehelp = new FlxText(7*16, 24*16, 100, "SPACE");
			spacehelp.setFormat(null, 14, 0x555555, "center");
			spacehelp.alpha = .5;
			this.add(spacehelp);
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				//logger.logLevelEnd({"dest": 1, "time": playtime});
				FlxG.switchState(new Room1_1State());
			}
			if (player.x > map.width - 32) {
				player.velocity.y = 0;
			}
			if (player.x > map.width - 16) {
				//logger.logLevelEnd({"dest": 3, "time": playtime});
				Preloader.tracker.trackPageview("/level-2-end");
				Preloader.tracker.trackEvent("level-2", "level-end", null, playtime * 100);
				
				FlxG.switchState(new Room1_3State());
			}
		}
		
	}

}