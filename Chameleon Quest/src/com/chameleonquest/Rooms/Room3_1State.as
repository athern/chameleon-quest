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
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Player(0, ROOM_HEIGHT - 9);
			// add spikes
			Spikes.addSpikeRow(5, ROOM_HEIGHT - 1, 2, enemies);
			Spikes.addSpikeRow(15, ROOM_HEIGHT -3, 13, enemies);
			
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