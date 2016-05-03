package com.chameleonquest.Rooms 
{
	import com.chameleonquest.interactiveObj.Button;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room1_1State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-1_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{	
			ROOM_WIDTH = 45;
			ROOM_HEIGHT = 15;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			
			// add spikes
			//enemies.add(new Spikes(17 * 16, 16 * ROOM_HEIGHT - 8));
			//enemies.add(new Spikes(18 * 16, 16 * ROOM_HEIGHT - 8));
			//enemies.add(new Spikes(19 * 16, 16 * ROOM_HEIGHT - 8));
			
			Spikes.addSpikeRow(17, ROOM_HEIGHT-1, 3, enemies);
			Spikes.addSpikeRow(27, ROOM_HEIGHT-1, 4, enemies);
			// add rock pile
			bgElems.add(new Pile(5, ROOM_HEIGHT-1));
			
			if (Main.lastRoom == 2) {
				player = new Player(ROOM_WIDTH-3, ROOM_HEIGHT-1, this.map.getBounds());
				player.facing = FlxObject.LEFT;
			}
			else {
				player = new Player(0, ROOM_HEIGHT-1, this.map.getBounds());
			}
			projectiles.add(player.getAmmo());
			
			enemies.add(new Snake(16 * 8, 16 * (ROOM_HEIGHT - 4)));
			
			//var poisonSnake:PoisonSnake = new PoisonSnake(16 * 27, 16 * (ROOM_HEIGHT - 2), map.getBounds());
			//poisonSnake.facing = FlxObject.LEFT;
			//enemies.add(poisonSnake);
			//enemyProjectiles.add(poisonSnake.getAmmo());
			
			enemies.add(new Bird(16 * 20, 16 * 30, 16 * (ROOM_HEIGHT - 8)));
			
			// TODO: remove when button sample is not needed anymore
			intrELems.add(new Button(64, 214, 100));
			
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