package com.chameleonquest 
{
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	
	public class Room1_2State extends PlayState
	{
		
		[Embed(source = "../../../assets/mapCSV_1-2_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{	
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Player(0, 449, this.map.getBounds());
			projectiles.add(player.getAmmo());
			elems.add(new Platform(new Array(new FlxPoint(40, 160), new FlxPoint(19 * 16, 160)), 60));
			
			// add spikes
			enemies.add(new Spikes(21 * 16, 16 * ROOM_HEIGHT - 24));
			enemies.add(new Spikes(22 * 16, 16 * ROOM_HEIGHT - 24));
			
			// add rock pile
			bgElems.add(new Pile(9 * 16, (ROOM_HEIGHT - 4) * 16 ));
			bgElems.add(new Pile((ROOM_WIDTH - 3) * 16, (ROOM_HEIGHT - 9) * 16 ));
			
			// add enemies
			enemies.add(new Snake(16 * 14, 16 * (ROOM_HEIGHT - 6)));
			
			
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