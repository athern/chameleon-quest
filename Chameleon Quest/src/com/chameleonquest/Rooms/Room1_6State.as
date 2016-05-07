package com.chameleonquest.Rooms 
{
	import com.chameleonquest.*;
	import com.chameleonquest.Chameleons.Player;
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
			if (Main.lastRoom == 7)
			{
				player = new Player(0, ROOM_HEIGHT - 1);
			}
			else
			{
				player = new Player(ROOM_WIDTH - 1, 14);
				player.facing = FlxObject.LEFT;
			}
			
			bgElems.add(new Pile(16, 11));
			bgElems.add(new Pile(8, 36));
			bgElems.add(new Pile(17, 44));
			var rotatingBlock:AngleBlock = new AngleBlock(1, 3, 90);
			var patrollingBlock:AngleBlock = new AngleBlock(14, 33, 0);
			patrollingBlock.patrol(14 * 16+4, 20 * 16, 20);
			var gate1:StoneGate = new StoneGate(4, 44, -1);
			var gate2:StoneGate = new StoneGate(7, 44, -1);
			elems.add(gate1);
			elems.add(gate2);
			intrELems.add(rotatingBlock);
			intrELems.add(patrollingBlock);
			intrELems.add(new AngleBlock(1, 10, 90));
			intrELems.add(new AngleBlock(28, 33, 180));
			intrELems.add(new AngleBlock(28, 43, 270));
			intrELems.add(new Button(1, 1, gate1, StoneGate.lift, 100, 180));
			intrELems.add(new Button(1, 36, rotatingBlock, AngleBlock.rotate, 20, 0));
			intrELems.add(new Button(15, 15, gate2, StoneGate.lift, 100, 180));
			intrELems.add(new Button(14, 35, patrollingBlock, AngleBlock.stopOrStart, 20, 270));
			elems.add(new Platform(new Array(new FlxPoint(90, 150), new FlxPoint(90, 540)), 60));
			elems.add(new Platform(new Array(new FlxPoint(186, 580), new FlxPoint(186, 680)), 50));
			
			
			
			Main.lastRoom = 6;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				FlxG.switchState(new Room1_7State());
			}
			else if (player.x > ROOM_WIDTH * 16 - 16) {
				FlxG.switchState(new Room1_5State());
			}
		}
		
	}

}