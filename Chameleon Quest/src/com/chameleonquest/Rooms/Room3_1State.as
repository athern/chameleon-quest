package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.WaterWheel;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;

	public class Room3_1State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_3-1_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 40;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Chameleon(2, ROOM_HEIGHT - 9);
			
			bgElems.add(new Door(2, 21, false));
			elems.add(new Door(36, 26, true));
			// add spikes
			Spikes.addSpikeRow(9, ROOM_HEIGHT - 5, 3, enemies, 6);
			Spikes.addSpikeRow(20, ROOM_HEIGHT -3, 13, enemies, 6);
			Spikes.addSpikeRow(26, 4, 1, enemies, 6);
			// add rope platform
			elems.add(new PlatformOnRope(16 * 9, 16 * 18, 2));
			elems.add(new PlatformOnRope(16 * 22, 16 * 19));
			elems.add(new PlatformOnRope(16 * 28, 16 * 19));
			enemies.add(new Snake(17 * 16, 18 * 16, 10 * 16));
			enemies.add(new Snake(14 * 16, 15.2 * 16, 14 * 16));
						
			// add torch
			bgElems.add(new Torch(7, (ROOM_HEIGHT - 9)));
			Main.lastRoom = 15;						
			super.create();
			
			var hint:FlxText;
			hint = new FlxText(121, 17*16 + 8, 70, "C");
			hint.setFormat(null, 14, 0x555555, "left");
			hint.alpha = .5;
			this.add(hint);
			
			var chargeHint:FlxText;
			chargeHint = new FlxText(22 * 16, 3 * 16, 200, "HOLD SPACE TO CHARGE");
			chargeHint.setFormat(null, 8, 0x555555, "left");
			chargeHint.alpha = .5;
			add(chargeHint);
		}
		
	}

}