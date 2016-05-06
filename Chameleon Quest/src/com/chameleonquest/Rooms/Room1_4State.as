package com.chameleonquest.Rooms 
{
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
			if (Main.lastRoom == 5) {
				player = new Player(ROOM_WIDTH - 2, ROOM_HEIGHT - 1);
				player.facing = FlxObject.LEFT;
			}
			else {
				player = new Player(0, ROOM_HEIGHT - 1);
			}
			
			// add rock pile
			bgElems.add(new Pile(13, ROOM_HEIGHT - 1));
			intrELems.add(new WoodBlock(24, 14));
			
			// add enemies
			enemies.add(new Bird(20 * 16, 26 * 16, (ROOM_HEIGHT - 10) * 16));
			enemies.add(new PoisonSnake(13 * 16, 16 * 2));
			//enemies.add(new PoisonSnake(new Array(new FlxPoint(13 * 16, 16 * 3))));
			
			Main.lastRoom = 4;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				FlxG.switchState(new Room1_3State());
			}
			
			if (player.x > map.width - 16) {
				FlxG.switchState(new Room1_5State());
			}
		}
		
	}

}