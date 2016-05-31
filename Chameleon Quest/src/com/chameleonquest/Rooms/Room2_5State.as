package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.WaterWheel;
	import com.chameleonquest.interactiveObj.WoodBlock;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room2_5State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_2-5_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
				
			player = new Chameleon(26, ROOM_HEIGHT - 1);
			player.facing = FlxObject.LEFT;
			
			bgElems.add(new Door(26, 29, false));
			elems.add(new Door(26, 4, true));
			
			
			bgElems.add(new Pile(26, 24));
			var gate:StoneGate = new StoneGate(23, 4, 200, 240);
			elems.add(gate);
			bgElems.add(new WaterFountain(26, 13));
			new Pulley(elems, 16 * 4, 16 * 9, 16 * 8, 16 * 7);
			intrELems.add(new WaterWheel(13, 6, gate, StoneGate.gradualLift));
			enemies.add(new Turtle(16 * 4 - 10, 16 * 8));
			var otherTurtle:Turtle = new Turtle(16 * 5 + 2, 16 * 8);
			otherTurtle.facing = FlxObject.LEFT;
			enemies.add(otherTurtle);
			enemies.add(new PoisonSnake(15 * 16, 19 * 16));
			enemies.add(new Bird(2 * 16, 20 * 16, 2 * 16));
			enemies.add(new Snake(20 * 16, 23 * 16, 16 * 15));
			enemies.add(new Snake(7 * 16, 12 * 16, 16 * 15, FlxObject.RIGHT));
			intrELems.add(new WoodBlock(17, 9));
			Main.lastRoom = 12;
			super.create();
		}
		
	}

}