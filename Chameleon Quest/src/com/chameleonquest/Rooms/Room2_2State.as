package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.*;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room2_2State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_2-2_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
				
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			
			player = new Chameleon(2, 24);			
			player.facing = FlxObject.RIGHT;
			
			bgElems.add(new Door(2, 24, false));
			elems.add(new Door(2, 15, true));
			
			bgElems.add(new Pile(ROOM_WIDTH - 7, 8));
			
			grates.add(new Grate(ROOM_WIDTH - 4, ROOM_HEIGHT - 8));
			grates.add(new Grate(ROOM_WIDTH - 3, ROOM_HEIGHT - 8));
			grates.add(new Grate(ROOM_WIDTH - 2, ROOM_HEIGHT - 8));
			
			bgElems.add(grates);
			
			bgElems.add(new WaterFountain(6, ROOM_HEIGHT - 6));
			
			var gate:StoneGate = new StoneGate(5, 15, -1);
			elems.add(gate);
			
			intrELems.add(new AngleBlock(11, 7, 0));
			intrELems.add(new Button(11, 5, gate, StoneGate.lift, 100, 180, Button.RED));
			
			intrELems.add(new WoodBlock(15, (ROOM_HEIGHT - 6)));
			
			
			enemies.add(new PoisonSnake(11 * 16, (ROOM_HEIGHT - 14) * 16));
			enemies.add(new Bird(11 * 16, 18 * 16, (ROOM_HEIGHT - 20) * 16));
			enemies.add(new Snake((ROOM_WIDTH - 7) * 16, (ROOM_WIDTH - 6) * 16, (ROOM_HEIGHT - 18) * 16));
			
			Main.lastRoom = 9;

			super.create();
			
			var hint:FlxText;
			hint = new FlxText(8 * 16, 16 * (ROOM_HEIGHT - 10), 70, "C --> X");
			hint.setFormat(null, 14, 0x555555, "center");
			hint.alpha = .5;
			this.add(hint);
		}
		
	}

}