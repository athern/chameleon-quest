package com.chameleonquest.Rooms 
{
	import com.chameleonquest.*;
	import org.flixel.*;
	import com.chameleonquest.Objects.*;
	
	public class Room1_6State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-6_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 45;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Player(ROOM_WIDTH - 1, 14);
			player.facing = FlxObject.LEFT;
			bgElems.add(new Pile(16, 11));
			elems.add(new Platform(new Array(new FlxPoint(90, 150), new FlxPoint(90, 570)), 100));
			elems.add(new Platform(new Array(new FlxPoint(190, 560), new FlxPoint(190, 690)), 60));
			Main.lastRoom = 6;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0 && player.y > 20*16) {
				player.x = 0;
			}
			else if (player.x > ROOM_WIDTH * 16 - 16) {
				FlxG.switchState(new Room1_5State());
			}
		}
		
	}

}