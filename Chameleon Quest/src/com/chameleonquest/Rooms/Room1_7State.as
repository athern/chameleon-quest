package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Player;
	import com.chameleonquest.Enemies.BossTurtle;
	import com.chameleonquest.Enemies.Geyser;
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
		
		private var fanfare:Boolean;
		
		private var geysers:FlxGroup = new FlxGroup();
		
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
				// logger.logLevelStart(1, {"src": 8});
				player = new Player(0, ROOM_HEIGHT - 1);
				player.facing = FlxObject.RIGHT;
				enteredBossChamber = true;
				boss.kill();
			}
			else
			{
				// logger.logLevelStart(1, {"src": 6});
				player = new Player(ROOM_WIDTH - 2, ROOM_HEIGHT - 1);
				player.facing = FlxObject.LEFT;
			}
			Main.lastRoom = 7;
			super.create();
			add(geysers);
			
			// for the boss celebration
			fanfare = false;
		}
		
		override public function update():void
		{
			super.update();
			FlxG.collide(player, geysers, hurtPlayer);
			if (boss.health == 3)
			{
				if (enteredBossChamber && Math.random() < .002)
				{
					Geyser.init(geysers, Math.random() * 16 * 12 + 8 * 16, 16 * 13);
				}
			}
			if (boss.health == 2)
			{
				if (enteredBossChamber && Math.random() < .004)
				{
					Geyser.init(geysers, Math.random() * 16 * 12 + 8 * 16, 16 * 13, 75, 3);
				}
			}
			if (boss.health == 1)
			{
				if (enteredBossChamber && Math.random() < .008)
				{
					Geyser.init(geysers, Math.random() * 16 * 12 + 8 * 16, 16 * 13, 50, 4);
				}
			}
			
			if (player.x < 370 && !enteredBossChamber)
			{
				enteredBossChamber = true;
				StoneGate.drop(leftgate);
				StoneGate.drop(rightgate);
			}
			if (player.x < 0) {
				//logger.logLevelEnd({"dest": 8, "time": playtime});
				FlxG.switchState(new Room2_1State());
			} else if (player.x > map.width - 16) {
				//logger.logLevelEnd({"dest": 6, "time": playtime});
				FlxG.switchState(new Room1_6State());
			}
			if (boss.health <= 0)
			{
				//logger.logAction(8, {"boss": "water"});
				StoneGate.lift(leftgate);
				StoneGate.lift(rightgate);
				if (!fanfare) {
					add(new Fanfare(8, 3));
					fanfare = true;
				}
			}
		}
		
	}

}