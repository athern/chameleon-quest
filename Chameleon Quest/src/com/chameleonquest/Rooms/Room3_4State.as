package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Enemies.PoisonSnake;
	import com.chameleonquest.Enemies.Snake;
	import com.chameleonquest.Enemies.Squirrel;
	import com.chameleonquest.Enemies.SpikedWoodBlock;
	import org.flixel.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Objects.*;
	
	public class Room3_4State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_3-4_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 35;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Chameleon(2, 29);
			
			bgElems.add(new Door(2, 29, false));
			elems.add(new Door(31, 29, true));
			elems.add(new TNT(27, 29, new Array(new FlxPoint(27 * 16 + 6, 3 * 16 + 6), new FlxPoint(23 * 16 + 6, 3 * 16 + 6))));
			bgElems.add(new Torch(12, 29));
			enemies.add(new SpikedWoodBlock(25, 29));
			enemies.add(new Squirrel(21 * 16, 19 * 16));
			enemies.add(new PoisonSnake(13 * 16, 4 * 16));
			enemies.add(new Snake(11 * 16, 13 * 16, 14 * 16));
			Main.lastRoom = 18;
			super.create();
		}
	}

}