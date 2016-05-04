package com.chameleonquest.Rooms 
{
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	
	public class Room3_2State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_3-2_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 45;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Player(0, 3);
			
			// add spikes
			Spikes.addSpikeRow(19, ROOM_HEIGHT - 1, 8, enemies);
			
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