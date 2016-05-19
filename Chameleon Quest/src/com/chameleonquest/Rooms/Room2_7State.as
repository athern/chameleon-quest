package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Enemies.BossDragon;
	import com.chameleonquest.Enemies.Dragonling;
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
			
			enemies.add(new Dragonling(16 * 2, 16 * 23))
											
			bgElems.add(new WaterFountain(2, 23));
			
			leftgate = new StoneGate(7, 23, -1, 20);
			rightgate = new StoneGate(42, 23, -1, 20);
			elems.add(leftgate);
			elems.add(rightgate);
			StoneGate.lift(leftgate);
			StoneGate.lift(rightgate);
			
			var gate1:StoneGate = new StoneGate(27, 27, 400, 480, StoneGate.GREY, 270);
			elems.add(gate1);
			var gate2:StoneGate = new StoneGate(23, 24, 400, 480, StoneGate.GREY, 90);
			elems.add(gate2);
			intrELems.add(new WaterWheel(10, 16, gate1, StoneGate.gradualLift));
			intrELems.add(new WaterWheel(38, 16, gate2, StoneGate.gradualLift));
			enemies.add(new BossDragon(200, 400, 140));
			Main.lastRoom = 14;
			super.create();
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
				FlxG.switchState(new LevelCompleteState(playtime, 40, 100));
				
			}
			
			if (player.x > 160 && !enteredBossChamber)
			{
				enteredBossChamber = true;
				StoneGate.drop(leftgate);
				StoneGate.drop(rightgate);
			}
		}
		
	}

}