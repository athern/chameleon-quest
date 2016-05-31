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
				
			player = new Chameleon(26, ROOM_HEIGHT - 1);
			bgElems.add(new Door(26, 14, false));
			elems.add(new Door(27, 4, true));
			
			player.facing = FlxObject.LEFT;
			
			elems.add(new Platform(new Array(new FlxPoint(16*16, 16 * 5), new FlxPoint(21 * 16, 16*5)), 60));
			
			// add spikes
			Spikes.addSpikeRow(3, ROOM_HEIGHT - 1, 5, enemies);
			Spikes.addSpikeRow(11, ROOM_HEIGHT - 1, 4, enemies);
			
			bgElems.add(new Pile(9, (ROOM_HEIGHT - 2)));
			
			enemies.add(new Snake(16, 16 * 3, 16 * (ROOM_HEIGHT - 8)));
			enemies.add(new Bird(16 * 9, 16 * 23, 16 * 2));
			
			bgElems.add(new WaterFountain(ROOM_WIDTH - 9, ROOM_HEIGHT - 1));
			
			grates.add(new Grate(ROOM_WIDTH - 5, 2));
			grates.add(new Grate(ROOM_WIDTH - 5, 3));
			grates.add(new Grate(ROOM_WIDTH - 5, 4));
			
			bgElems.add(grates);
			
			Main.lastRoom = 8;
			
			super.create();
			
			var hint:FlxText;
			hint = new FlxText(315, 160, 70, "C");
			hint.setFormat(null, 14, 0x555555, "center");
			hint.alpha = .5;
			this.add(hint);
		}
		
	}

}