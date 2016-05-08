package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Player;
	import com.chameleonquest.interactiveObj.WaterWheel;
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
			
			if (Main.lastRoom == 9)
			{
				player = new Player(ROOM_HEIGHT - 1, 2);
			}
			else
			{
				player = new Player(ROOM_WIDTH - 1, ROOM_HEIGHT - 1);
			}
			
			player.facing = FlxObject.LEFT;
			
			elems.add(new Platform(new Array(new FlxPoint(18*16, 16 * 5), new FlxPoint(22 * 16, 16*5)), 60));
			
			// add spikes
			Spikes.addSpikeRow(3, ROOM_HEIGHT - 1, 5, enemies);
			Spikes.addSpikeRow(11, ROOM_HEIGHT - 1, 4, enemies);
			
			enemies.add(new Snake(16, 16 * 3, 16 * (ROOM_HEIGHT - 8)));
			enemies.add(new Bird(16 * 2, 16 * 23, 16 * 2));
			
			bgElems.add(new WaterFountain(ROOM_WIDTH - 9, ROOM_HEIGHT - 3));
			
			bgElems.add(new Grate(ROOM_WIDTH - 3, 2));
			bgElems.add(new Grate(ROOM_WIDTH - 3, 3));
			
			Main.lastRoom = 8;
			
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x > ROOM_WIDTH * 16 - 16 && player.y <= 4*16) {
				FlxG.switchState(new Room2_2State());
			}
			
			if (player.x > ROOM_WIDTH * 16 - 16 && player.y > (ROOM_HEIGHT - 2) * 16) {
				FlxG.switchState(new Room1_7State());			
			}
		}
		
	}

}