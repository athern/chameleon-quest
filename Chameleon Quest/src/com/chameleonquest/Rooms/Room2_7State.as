package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Enemies.BossDragon;
	import com.chameleonquest.Enemies.Dragonling;
	import com.chameleonquest.Enemies.Enemy;
	import com.chameleonquest.Enemies.Geyser;
	import org.flixel.*;
	import com.chameleonquest.Objects.*;
	import com.chameleonquest.*;
	import com.chameleonquest.interactiveObj.*;
	
	public class Room2_7State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_2-7_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		public var enteredBossChamber:Boolean = false;
		
		private var leftgate:StoneGate;
		private var rightgate:StoneGate;
		private var gate1:StoneGate;
		private var gate2:StoneGate;
		
		private var fanfare:Boolean;
		
		private var boss:BossDragon;
		private var geysers:FlxGroup;
		
		override public function create():void
		{
			ROOM_WIDTH = 45;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			
			Preloader.logger.logLevelStart(14, {"src": 13});
			Preloader.tracker.trackPageview("/level-14");
			Preloader.tracker.trackEvent("level-14", "level-enter", null, 13);
				
			player = new Chameleon(0, 23);
			player.facing = FlxObject.RIGHT;
											
			bgElems.add(new WaterFountain(2, 23));
			
			leftgate = new StoneGate(7, 23, -1, 20);
			rightgate = new StoneGate(42, 23, -1, 20);
			elems.add(leftgate);
			elems.add(rightgate);
			StoneGate.lift(leftgate);
			StoneGate.lift(rightgate);
			
			gate1 = new StoneGate(27, 27, 1200, 480, StoneGate.GREY, 270);
			elems.add(gate1);
			gate2 = new StoneGate(23, 24, 1200, 480, StoneGate.GREY, 90);
			elems.add(gate2);
			intrELems.add(new WaterWheel(10, 16, gate1, StoneGate.gradualLift));
			intrELems.add(new WaterWheel(38, 16, gate2, StoneGate.gradualLift));
			boss = new BossDragon(240, 480, 140);
			enemies.add(boss);
			
			Main.lastRoom = 14;
			super.create();
			
			geysers = new FlxGroup();
			Geyser.initCache();
			add(geysers);
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16) {
				Preloader.logger.logLevelEnd({"dest": 15, "time": playtime});
				Preloader.tracker.trackPageview("/level-14-end");
				Preloader.tracker.trackEvent("level-14", "level-end", null, int(Math.round(playtime)));
				FlxG.switchState(new LevelCompleteState(playtime, 100, 50));
				
			}
			
			if (player.x > 160 && !enteredBossChamber)
			{
				enteredBossChamber = true;
				StoneGate.drop(leftgate);
				StoneGate.drop(rightgate);
			}
			
			FlxG.overlap(enemies, geysers, null, hurtEnemy);
			FlxG.overlap(elems, geysers, null, blockGeyser);
			
			if (gate1.isLifted && gate2.isLifted)
			{
				if (geysers.countLiving() < 1)
				{
					Geyser.init(geysers, 16 * 25 - 8, 16 * 13, 30, 2);
				}
			}
			
			if (boss.health <= 0)
			{
				StoneGate.lift(leftgate);
				StoneGate.lift(rightgate);
				if (!fanfare) {
					Preloader.logger.logAction(8, {"boss": "fire"});
					Preloader.tracker.trackEvent("level-14", "boss-kill", null);

					add(new Fanfare(18, 14));
					fanfare = true;
				}
			}
			
			if (boss.spawnDragonlings)
			{
 				var numDragonlings:int = (4 - boss.health);
				for (var i:int = 0; i < numDragonlings; i++)
				{
					if (boss.health > 0)
					{
						enemies.add(new Dragonling(16 * 2 + i * 24, 16 * 7));
					}
				}
				for (var j:int = 0; j < geysers.members.length; j++)
				{
					var next:Geyser = geysers.members[j] as Geyser;
					if (next != null)
					{
						next.fade = true;
					}
				}
				gate1.x += 24;
				gate2.x -= 24;
				gate1.clock -= 300;
				gate2.clock -= 300;
				gate1.lifted = false;
				gate2.lifted = false;
			}
		}
		
		public function hurtEnemy(victim:Enemy, geyser:Enemy):void {
			if (victim is BossDragon) {
				(victim as BossDragon).hitWithGeyser();
				
			}
			else
			{
				victim.hurt(1);
			}
		}
		
		public function blockGeyser(elem:FlxSprite, geyser:Enemy):void {
			for (var i:int = 0; i < geysers.members.length; i++)
			{
				var next:Geyser = geysers.members[i] as Geyser;
				if (next != null)
				{
					next.y = FlxG.camera.bounds.bottom + 16;
				}
			}
		}
	}

}