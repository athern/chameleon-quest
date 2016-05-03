package com.chameleonquest 
{
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;


	public class Room3_1State extends PlayState
	{
		
		[Embed(source = "../../../assets/mapCSV_3-1_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 25;
			ROOM_HEIGHT = 22;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Player(0, (ROOM_HEIGHT - 7) * 16, map.getBounds());
			
			// add spikes
			enemies.add(new Spikes(4 * 16, 16 * ROOM_HEIGHT - 24));
			enemies.add(new Spikes(5 * 16, 16 * ROOM_HEIGHT - 24));
			enemies.add(new Spikes(13 * 16, 16 * ROOM_HEIGHT - 8));
			enemies.add(new Spikes(14 * 16, 16 * ROOM_HEIGHT - 8));
			enemies.add(new Spikes(15 * 16, 16 * ROOM_HEIGHT - 8));
			enemies.add(new Spikes(16 * 16, 16 * ROOM_HEIGHT - 8));
			enemies.add(new Spikes(17 * 16, 16 * ROOM_HEIGHT - 8));
			enemies.add(new Spikes(18 * 16, 16 * ROOM_HEIGHT - 8));
			enemies.add(new Spikes(19 * 16, 16 * ROOM_HEIGHT - 8));
			enemies.add(new Spikes(20 * 16, 16 * ROOM_HEIGHT - 8));
			enemies.add(new Spikes(21 * 16, 16 * ROOM_HEIGHT - 8));
			enemies.add(new Spikes(22 * 16, 16 * ROOM_HEIGHT - 8));
			
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