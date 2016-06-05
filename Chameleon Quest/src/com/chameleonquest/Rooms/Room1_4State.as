package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.WoodBlock;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;

	
	public class Room1_4State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-4_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 15;
			map.loadMap(new levelMap, levelTiles, 16, 16);
				
			player = new Chameleon(2, ROOM_HEIGHT - 1);
			bgElems.add(new Door(2, ROOM_HEIGHT - 1, false));
			elems.add(new Door(27, ROOM_HEIGHT - 1, true));
			
			// add rock pile
			bgElems.add(new Pile(13, ROOM_HEIGHT - 1));
			intrELems.add(new WoodBlock(24, 14));
			
			// add enemies
			enemies.add(new Bird(20 * 16, 26 * 16, (ROOM_HEIGHT - 10) * 16));
			enemies.add(new PoisonSnake(13 * 16, 16 * 2));
			
			Main.lastRoom = 4;
			super.create();
		}
		
	}

}