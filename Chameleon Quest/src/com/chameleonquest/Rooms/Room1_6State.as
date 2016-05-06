package com.chameleonquest.Rooms 
{
	import com.chameleonquest.*;
	import org.flixel.*;
	import com.chameleonquest.Objects.*;
	import com.chameleonquest.interactiveObj.*;
	
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
			bgElems.add(new Pile(8, 36));
			bgElems.add(new Pile(17, 44));
			var rotatingBlock:AngleBlock = new AngleBlock(1, 3, 90);
			intrELems.add(rotatingBlock);
			intrELems.add(new AngleBlock(1, 10, 90));
			//intrELems.add(new Button(1, 1, 100, 180));
			intrELems.add(new Button(1, 36, rotatingBlock, AngleBlock.rotate, 100, 0));
			//intrELems.add(new Button(14, 15, 100, 180));
			//intrELems.add(new Button(13, 35, 100, 270));
			elems.add(new Platform(new Array(new FlxPoint(90, 150), new FlxPoint(90, 540)), 60));
			elems.add(new Platform(new Array(new FlxPoint(186, 560), new FlxPoint(186, 660)), 60));
			
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