package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Player;
	import com.chameleonquest.interactiveObj.WaterWheel;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room2_3State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_2-3_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		public var grates:FlxGroup = new FlxGroup();
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 45;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			
			if (Main.lastRoom == 11)
			{
				player = new Player(1, 4);
				player.facing = FlxObject.RIGHT;
			}
			else
			{
				player = new Player(ROOM_WIDTH - 1, ROOM_HEIGHT - 1);
				player.facing = FlxObject.LEFT;
			}
			
			elems.add(new Platform(new Array(new FlxPoint(26 * 16, 16 * (ROOM_HEIGHT - 11)), new FlxPoint(26 * 16, 16 * (ROOM_HEIGHT - 19) )), 60));
			elems.add(new Platform(new Array(new FlxPoint(9 * 16, 16 * 5), new FlxPoint(22 * 16, 16 * 5)), 60));
			
			// add spikes
			Spikes.addSpikeRow(15, 6, 5, enemies);
			Spikes.addSpikeRow(18, ROOM_HEIGHT - 7, 7, enemies);
			Spikes.addSpikeRow(17, ROOM_HEIGHT - 8, 1, enemies);
			Spikes.addSpikeRow(16, ROOM_HEIGHT - 9, 1, enemies);
			Spikes.addSpikeRow(25, ROOM_HEIGHT - 8, 4, enemies);
			
			grates.add(new Grate(14, ROOM_HEIGHT - 15));
			grates.add(new Grate(14, ROOM_HEIGHT - 16));
			grates.add(new Grate(15, ROOM_HEIGHT - 16));
			grates.add(new Grate(15, ROOM_HEIGHT - 17));
			grates.add(new Grate(16, ROOM_HEIGHT - 17));
			grates.add(new Grate(16, ROOM_HEIGHT - 18));
			
			bgElems.add(grates);
			
			bgElems.add(new WaterFountain(6, ROOM_HEIGHT - 4));
			
			
			Main.lastRoom = 10
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			// water grate check
			if (player.getType() != Player.WATER) {
				FlxG.collide(player, grates);					
			}
			
			if (player.x < 0) {
				FlxG.switchState(new Room2_5State());
			}
			
			if (player.x > map.width - 16) {
				FlxG.switchState(new Room2_2State());
			}
		}
		
	}

}