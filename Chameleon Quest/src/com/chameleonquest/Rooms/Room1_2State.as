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
			ROOM_HEIGHT = 32;
			map.loadMap(new levelMap, levelTiles, 16, 16);
				
			player = new Chameleon(2, ROOM_HEIGHT - 1);
			bgElems.add(new Door(2, ROOM_HEIGHT - 1, false));
			elems.add(new Door(26, 5, true));
			
			elems.add(new Platform(new Array(new FlxPoint(120, 192), new FlxPoint(19 * 16, 192)), 60));
			
			Spikes.addSpikeRow(21, ROOM_HEIGHT - 2, 2, enemies);
			
			// add rock pile
			bgElems.add(new Pile(11, (ROOM_HEIGHT - 4)));
			bgElems.add(new Pile(ROOM_WIDTH - 5, ROOM_HEIGHT - 8));
			
			// add enemies
			enemies.add(new Snake(16 * 13, 16*15, 16 * (ROOM_HEIGHT - 6)));
			enemies.add(new Snake(16 * 16, 16*18-8, 16 * (ROOM_HEIGHT - 13)));
			
			Turtle.addTurtleStack(16 * 19, 16 * (ROOM_HEIGHT - 7), 3, enemies);
			
			Main.lastRoom = 2;
			super.create();
			
			var spacehelp:FlxText;
			spacehelp = new FlxText(6*16, 24*16, 132, "SPACE");
			spacehelp.setFormat(null, 14, 0x555555, "center");
			spacehelp.alpha = .5;
			this.add(spacehelp);
			
			var morehelp:FlxText;
			morehelp = new FlxText(4 * 16, 25 * 16, 182, "GRAB ROCKS TO FIRE");
			morehelp.setFormat(null, 8, 0x555555, "center");
			morehelp.alpha = .5;
			add(morehelp);
		}
		
	}

}