package com.chameleonquest.Rooms 
{
	import org.flixel.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room1_7State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-7_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{	
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 15;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Player(ROOM_WIDTH - 2, ROOM_HEIGHT - 1);
			player.facing = FlxObject.LEFT;
			
			
			Main.lastRoom = 7;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0
			} else if (player.x > map.width - 16) {
				FlxG.switchState(new Room1_6State());
			}
		}
		
	}

}