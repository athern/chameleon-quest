package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
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
			ROOM_WIDTH = 36;
			ROOM_HEIGHT = 15;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			boss = new BossTurtle(10 * 16, 19 * 16, 16 * (ROOM_HEIGHT - 5));
			enemies.add(boss);
			elems.add(new Platform(new Array(new FlxPoint(12 * 16, 4 * 16), new FlxPoint(12 * 16, 9 * 16)), 50));
			bgElems.add(new Pile(27, 11));
			intrELems.add(new Button(8, 1, boss, BossTurtle.flipBoss, 125, 90, Button.RED));
			intrELems.add(new AngleBlock(18, 7, 90));
			leftgate = new StoneGate(5, 14, -1, 10);
			rightgate = new StoneGate(29, 14, -1, 10);
			elems.add(leftgate);
			elems.add(rightgate);
			StoneGate.lift(leftgate);
			StoneGate.lift(rightgate);
			player = new Chameleon(ROOM_WIDTH - 4, ROOM_HEIGHT - 1);
			player.facing = FlxObject.LEFT;
			bgElems.add(new Door(32, 14, false));
			elems.add(new Door(2, 14, true));
			Main.lastRoom = 7;
			Geyser.initCache();
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
				if (enteredBossChamber && Math.random() < .004)
				{
					Geyser.init(geysers, Math.random() * 16 * 12 + 9 * 16, 16 * 13);
				}
			}
			if (boss.health == 2)
			{
				if (enteredBossChamber && Math.random() < .006)
				{
					Geyser.init(geysers, Math.random() * 16 * 12 + 9 * 16, 16 * 13, 40, 6);
				}
			}
			if (boss.health == 1)
			{
				if (enteredBossChamber && Math.random() < .009)
				{
					Geyser.init(geysers, Math.random() * 16 * 12 + 9 * 16, 16 * 13, 20, 8);
				}
			}
			
			if (player.x < 27*16 && !enteredBossChamber)
			{
				enteredBossChamber = true;
				StoneGate.drop(leftgate);
				StoneGate.drop(rightgate);
			}
			if (boss.health <= 0)
			{
				StoneGate.lift(leftgate);
				StoneGate.lift(rightgate);
				if (!fanfare) {
					Preloader.logger.logAction(8, {"boss": "water"});
					Preloader.tracker.trackEvent("level-7", "boss-kill", null);

					add(new Fanfare(8, 3));
					fanfare = true;
				}
			}
		}
		
	}

}