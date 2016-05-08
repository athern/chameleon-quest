package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Player;
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
			
			if (Main.lastRoom == 10)
			{
				player = new Player(1, ROOM_HEIGHT - 15);
			}
			else
			{
				player = new Player(1, ROOM_HEIGHT - 6);			
				
			}
			
			
			player.facing = FlxObject.RIGHT;
			
			bgElems.add(new Pile(ROOM_WIDTH - 7, 8));
			
			bgElems.add(new Grate(ROOM_WIDTH - 4, ROOM_HEIGHT - 8));
			bgElems.add(new Grate(ROOM_WIDTH - 3, ROOM_HEIGHT - 8));
			bgElems.add(new Grate(ROOM_WIDTH - 2, ROOM_HEIGHT - 8));
			
			bgElems.add(new WaterFountain(6, ROOM_HEIGHT - 8));
			
			var gate:StoneGate = new StoneGate(5, 15, -1);
			elems.add(gate);
			
			intrELems.add(new AngleBlock(11, 7, 0));
			intrELems.add(new Button(11, 1, gate, StoneGate.lift, 100, 180));
			
			intrELems.add(new WoodBlock(15, (ROOM_HEIGHT - 6)));
			
			Main.lastRoom = 9;

			super.create();
			
			var hint:FlxText;
			hint = new FlxText(8 * 16, 16 * (ROOM_HEIGHT - 10), 70, "C --> X");
			hint.setFormat(null, 14, 0x555555, "center");
			hint.alpha = .5;
			this.add(hint);
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0 && player.y >= ROOM_HEIGHT - 7) {
				FlxG.switchState(new Room2_1State());
			} else if (player.x < 0 && player.y >= ROOM_HEIGHT - 16) {
				FlxG.switchState(new Room2_3State());
			}
		}
		
	}

}