package com.chameleonquest.Rooms 
{
	import com.chameleonquest.interactiveObj.WaterWheel;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room2_2State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_2-2_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Player(ROOM_WIDTH - 1, ROOM_HEIGHT - 1);
			player.facing = FlxObject.LEFT;
			
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16) {
				player.x = map.width - 16;
			}
		}
		
	}

}