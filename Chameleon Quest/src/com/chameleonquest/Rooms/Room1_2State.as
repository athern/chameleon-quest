package com.chameleonquest.Rooms 
{
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
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Player(0, ROOM_HEIGHT - 1, this.map.getBounds());
			projectiles.add(player.getAmmo());
			elems.add(new Platform(new Array(new FlxPoint(40, 160), new FlxPoint(19 * 16, 160)), 60));
			
			Spikes.addSpikeRow(21, ROOM_HEIGHT - 2, 2, enemies);
			
			// add rock pile
			bgElems.add(new Pile(9, (ROOM_HEIGHT - 3)));
			bgElems.add(new Pile(ROOM_WIDTH - 3, ROOM_HEIGHT - 8));
			
			// add enemies
			enemies.add(new Snake(16 * 14, 16 * (ROOM_HEIGHT - 6)));
			enemies.add(new Snake(16 * 16, 16 * (ROOM_HEIGHT - 15)));
			enemies.add(new Bird(16 * 6, 16 * 20, 16 * (ROOM_HEIGHT - 22)));
			
			
			Main.lastRoom = 2;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				FlxG.switchState(new Room1_1State());
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