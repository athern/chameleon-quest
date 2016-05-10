package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Player;
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
				// logger.logLevelStart(1, {"src": 4});
				player = new Player(ROOM_WIDTH-2, ROOM_HEIGHT -1);
				player.facing = FlxObject.LEFT;
			}
			else {
				// logger.logLevelStart(1, {"src": 2});
				player = new Player(0, 5);
			}
			
			// add rock pile
			bgElems.add(new Pile(5, 5));
			bgElems.add(new Pile(6, ROOM_HEIGHT - 1));
			
			elems.add(new Platform(new Array(new FlxPoint(15 * 16, (ROOM_HEIGHT - 5) * 16), new FlxPoint(20 * 16, (ROOM_HEIGHT - 5) * 16)), 60));
			
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
				//logger.logLevelEnd({"dest": 2, "time": playtime});
				FlxG.switchState(new Room1_2State());
			}
			
			if (player.x > map.width - 16) {
				//logger.logLevelEnd({"dest": 4, "time": playtime});
				FlxG.switchState(new Room1_4State());
			}
		}
		
	}

}