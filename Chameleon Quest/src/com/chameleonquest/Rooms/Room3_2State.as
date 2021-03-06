package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Objects.Boulder;
	import com.chameleonquest.Objects.Door;
	import com.chameleonquest.Objects.Platform;
	import com.chameleonquest.Objects.PlatformOnRope;
	import com.chameleonquest.Objects.Torch;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	
	public class Room3_2State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_3-2_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		public var boulderDropped:Boolean;
		
		override public function create():void
		{
			ROOM_WIDTH = 45;
			ROOM_HEIGHT = 45;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Chameleon(2, 4);
			bgElems.add(new Door(2, 4, false));
			elems.add(new Door(42, 43, true));
			// add spikes
			Spikes.addSpikeRow(15, ROOM_HEIGHT - 3, 5, enemies, 6);
			Spikes.addSpikeRow(23, ROOM_HEIGHT - 3, 3, enemies, 6);
			Spikes.addSpikeRow(29, ROOM_HEIGHT - 3, 3, enemies, 6);
			Spikes.addSpikeRow(35, ROOM_HEIGHT - 3, 2, enemies, 6);
			Spikes.addSpikeRow(40, ROOM_HEIGHT - 3, 1, enemies, 6);
			elems.add(new Platform(new Array(new FlxPoint(20 * 16, 43 * 16-8)), 0));
			elems.add(new PlatformOnRope(32 * 16, 40 * 16));
			elems.add(new Platform(new Array(new FlxPoint(26 * 16, 43 * 16 - 8)), 0));
			elems.add(new Platform(new Array(new FlxPoint(37 * 16, 43 * 16-8)), 0));
			bgElems.add(new Torch(18, 7));
			Main.lastRoom = 16;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			if (player.y > 12 * 16 && !boulderDropped)
			{
				elems.add(new Boulder(22 * 16, -64));
				boulderDropped = true;
			}
		}
		
	}

}