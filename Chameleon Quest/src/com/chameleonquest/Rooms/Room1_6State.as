package com.chameleonquest.Rooms 
{
	import com.chameleonquest.*;
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Enemies.Bird;
	import com.chameleonquest.Enemies.PoisonSnake;
	import com.chameleonquest.Enemies.Snake;
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
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
				
			player = new Chameleon(26, 14);
			bgElems.add(new Door(26, 14, false));
			elems.add(new Door(2, 29, true));
			player.facing = FlxObject.LEFT;
			
			bgElems.add(new Pile(16, 11));
			bgElems.add(new Pile(6, 21));
			bgElems.add(new Pile(17, 29));
			enemies.add(new Bird(4 * 16, 22 * 16, 152));
			enemies.add(new Snake(9 * 16, 11 * 16, 6 * 16));
			enemies.add(new PoisonSnake(26 * 16, 27 * 16));
			var rotatingBlock:AngleBlock = new AngleBlock(1, 8, 180, AngleBlock.RED);
			var patrollingBlock:AngleBlock = new AngleBlock(14, 18, 0, AngleBlock.BLUE);
			patrollingBlock.patrol(14 * 16+4, 20 * 16, 20);
			var gate1:StoneGate = new StoneGate(8, 21, -1, 240, StoneGate.YELLOW);
			var gate2:StoneGate = new StoneGate(7, 29, -1, 240, StoneGate.GREEN);
			elems.add(gate1);
			elems.add(gate2);
			intrELems.add(rotatingBlock);
			intrELems.add(patrollingBlock);
			intrELems.add(new AngleBlock(1, 10, 90));
			intrELems.add(new AngleBlock(28, 18, 180));
			intrELems.add(new AngleBlock(28, 28, 270));
			intrELems.add(new Button(1, 5, gate1, StoneGate.lift, 50, 180, Button.YELLOW));
			intrELems.add(new Button(1, 20, rotatingBlock, AngleBlock.rotate, 10, 0, Button.RED));
			intrELems.add(new Button(15, 15, gate2, StoneGate.lift, 50, 180, Button.GREEN));
			intrELems.add(new Button(14, 20, patrollingBlock, InteractiveObj.stopOrStart, 10, 270, Button.BLUE));
			elems.add(new Platform(new Array(new FlxPoint(3*16, 14*16), new FlxPoint(3*16, 18*16)), 60));
			elems.add(new Platform(new Array(new FlxPoint(10*16, 21*16), new FlxPoint(10*16, 26*16)), 50));
			
			
			Main.lastRoom = 6;
			super.create();
		}
		
	}

}