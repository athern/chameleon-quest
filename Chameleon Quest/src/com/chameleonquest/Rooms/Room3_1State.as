package com.chameleonquest.Rooms 
{
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;

	public class Room3_1State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_3-1_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 25;
			ROOM_HEIGHT = 22;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Player(0, ROOM_HEIGHT - 6);
			// add spikes
			Spikes.addSpikeRow(4, ROOM_HEIGHT - 2, 2, enemies);
			Spikes.addSpikeRow(13, ROOM_HEIGHT - 1, 10, enemies);
			
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			if (player.x > map.width - 32) {
				player.velocity.y = 0;
			}
			if (player.x > map.width - 16) {
				player.x = map.width - 16;
			}
		}
		
	}

}