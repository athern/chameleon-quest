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
				
			player = new Chameleon(2, 5);
			bgElems.add(new Door(2, 5, false));
			elems.add(new Door(26, 29, true));
			
			// add rock pile
			bgElems.add(new Pile(5, 5));
			bgElems.add(new Pile(6, ROOM_HEIGHT - 1));
			
			elems.add(new Platform(new Array(new FlxPoint(13 * 16, (ROOM_HEIGHT - 6) * 16), new FlxPoint(18 * 16, (ROOM_HEIGHT - 6) * 16)), 60));
			
			// add spikes
			Spikes.addSpikeRow(18, 13, 4, enemies);
			Spikes.addSpikeRow(12, ROOM_HEIGHT - 2, 12, enemies);
			
			intrELems.add(new WoodBlock(7, 10));
			intrELems.add(new WoodBlock(10, 10));
			
			// add enemies
			enemies.add(new Bird(11 * 16, 24 * 16, (ROOM_HEIGHT - 8) * 16));
			enemies.add(new Snake(23 * 16, 27 * 16, 10 * 16));
			enemies.add(new Snake(8 * 16, 13 * 16, 3 * 16));
			
			Turtle.addTurtleStack(16 * 16, 16 * 3, 2, enemies);
			
			Main.lastRoom = 3;
			super.create();
		}
		
	}

}