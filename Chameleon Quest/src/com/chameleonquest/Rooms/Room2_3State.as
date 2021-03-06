package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.WaterWheel;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room2_3State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_2-3_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
				
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 45;
			map.loadMap(new levelMap, levelTiles, 16, 16);
				
			player = new Chameleon(26, 44);
			player.facing = FlxObject.LEFT;
			
			bgElems.add(new Door(26, 44, false));
			elems.add(new Door(2, 4, true));
			
			elems.add(new Platform(new Array(new FlxPoint(26 * 16, 16 * (ROOM_HEIGHT - 11)), new FlxPoint(26 * 16, 16 * (ROOM_HEIGHT - 19) )), 60));
			elems.add(new Platform(new Array(new FlxPoint(9 * 16, 16 * 5), new FlxPoint(22 * 16, 16 * 5)), 60));
			
			// add spikes
			Spikes.addSpikeRow(15, 6, 5, enemies);
			Spikes.addSpikeRow(18, ROOM_HEIGHT - 7, 7, enemies);
			Spikes.addSpikeRow(17, ROOM_HEIGHT - 8, 1, enemies);
			Spikes.addSpikeRow(16, ROOM_HEIGHT - 9, 1, enemies);
			Spikes.addSpikeRow(25, ROOM_HEIGHT - 8, 4, enemies);
			
			enemies.add(new PoisonSnake(26 * 16, 18 * 16));
			enemies.add(new Snake(20 * 16, 22 * 16, 8 * 16));
			enemies.add(new Bird(3 * 16, 24 * 16, 2 * 16));
			
			grates.add(new Grate(14, ROOM_HEIGHT - 15));
			grates.add(new Grate(14, ROOM_HEIGHT - 16));
			grates.add(new Grate(15, ROOM_HEIGHT - 16));
			grates.add(new Grate(15, ROOM_HEIGHT - 17));
			grates.add(new Grate(16, ROOM_HEIGHT - 17));
			grates.add(new Grate(16, ROOM_HEIGHT - 18));
			
			bgElems.add(grates);
			
			bgElems.add(new WaterFountain(6, ROOM_HEIGHT - 2));
			
			
			Main.lastRoom = 10;
			super.create();
		}
		
	}

}