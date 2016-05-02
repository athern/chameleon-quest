package com.chameleonquest 
{
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	
	public class Room1_1State extends PlayState
	{
		
		[Embed(source = "../../../assets/mapCSV_1-1_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{	
			ROOM_WIDTH = 40;
			ROOM_HEIGHT = 15;
			add(map.loadMap(new levelMap, levelTiles, 16, 16));
			
			// add spikes
			spikeBar.add(new Spikes(17 * 16, 16 * ROOM_HEIGHT - 8));
			spikeBar.add(new Spikes(18 * 16, 16 * ROOM_HEIGHT - 8));
			spikeBar.add(new Spikes(19 * 16, 16 * ROOM_HEIGHT - 8));
			add(spikeBar);
			
			if (Main.lastRoom == 2) {
				add(player = new Player(39 * 16, 208));
				player.facing = FlxObject.LEFT;
			}
			else {
				add(player = new Player(0, 208));
			}
			
			enemies = new FlxGroup();
			var snake:Snake = new Snake(16*8, 16* (ROOM_HEIGHT - 4));
			enemies.add(snake);
			
			Main.lastRoom = 1;
			
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
				FlxG.switchState(new Room1_2State());
			}
		}
		
	}

}