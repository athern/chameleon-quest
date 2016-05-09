package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Player;
	import com.chameleonquest.Enemies.BossTurtle;
	import com.chameleonquest.interactiveObj.AngleBlock;
	import com.chameleonquest.interactiveObj.Button;
	import org.flixel.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room1_7State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-7_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		public var enteredBossChamber:Boolean = false;
		
		private var leftgate:StoneGate;
		private var rightgate:StoneGate;
		
		private var boss:BossTurtle;
		
		override public function create():void
		{	
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 15;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			boss = new BossTurtle(7 * 16, 16 * 16, 16 * (ROOM_HEIGHT - 5));
			enemies.add(boss);
			elems.add(new Platform(new Array(new FlxPoint(10 * 16, 4 * 16), new FlxPoint(10 * 16, 9 * 16)), 50));
			bgElems.add(new Pile(24, 11));
			intrELems.add(new Button(5, 1, boss, BossTurtle.flipBoss, 250, 90));
			intrELems.add(new AngleBlock(15, 7, 90));
			leftgate = new StoneGate(2, 14, -1, 20);
			rightgate = new StoneGate(26, 14, -1, 20);
			elems.add(leftgate);
			elems.add(rightgate);
			StoneGate.lift(leftgate);
			StoneGate.lift(rightgate);
			if (Main.lastRoom == 8)
			{
				player = new Player(0, ROOM_HEIGHT - 1);
				player.facing = FlxObject.RIGHT;
				enteredBossChamber = true;
				boss.kill();
			}
			else
			{
				player = new Player(ROOM_WIDTH - 2, ROOM_HEIGHT - 1);
				player.facing = FlxObject.LEFT;
			}
			Main.lastRoom = 7;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			if (player.x < 370 && !enteredBossChamber)
			{
				enteredBossChamber = true;
				StoneGate.drop(leftgate);
				StoneGate.drop(rightgate);
			}
			if (player.x < 0) {
				FlxG.switchState(new Room2_1State());
			} else if (player.x > map.width - 16) {
				FlxG.switchState(new Room1_6State());
			}
			if (boss.health <= 0)
			{
				StoneGate.lift(leftgate);
				StoneGate.lift(rightgate);
			}
		}
		
	}

}