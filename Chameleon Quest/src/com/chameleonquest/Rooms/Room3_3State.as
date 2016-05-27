package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Enemies.PoisonSnake;
	import com.chameleonquest.Enemies.Snake;
	import com.chameleonquest.Enemies.Bird;
	import com.chameleonquest.Objects.Grate;
	import com.chameleonquest.Objects.StoneGate;
	import com.chameleonquest.interactiveObj.WaterWheel;
	import org.flixel.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Objects.*;
	
	public class Room3_3State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_3-3_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 45;
			ROOM_HEIGHT = 15;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Chameleon(0, 14);
			Preloader.logger.logLevelStart(17, {"src": 16});
			Preloader.tracker.trackPageview(Preloader.flag + "/level-17");
			Preloader.tracker.trackEvent("level-17", "level-enter", null, 16);
			elems.add(new PlatformOnRope(29 * 16, 4 * 16));
			var gate:StoneGate = new StoneGate(25, 4, 800);
			elems.add(gate);
			intrELems.add(new WaterWheel(25, 6, gate, StoneGate.gradualLift));
			bgElems.add(new Torch(11, 4));
			
			enemies.add(new Snake(27 * 16, 29 * 16, 16 * 12));
			enemies.add(new Snake(31 * 16, 32 * 16, 16 * 12));
			enemies.add(new PoisonSnake(34 * 16, 16 * 12));
			enemies.add(new Bird(16 * 6, 16 * 21, 16 * 8));
			
			bgElems.add(new WaterFountain(8, 14));
			
			grates.add(new Grate(7, 2));
			grates.add(new Grate(7, 3));
			grates.add(new Grate(7, 4));
			
			bgElems.add(grates);
			Main.lastRoom = 17;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16) {
				Preloader.logger.logLevelEnd({"dest": 18, "time": playtime});
				Preloader.tracker.trackPageview(Preloader.flag + "/level-17-end");
				Preloader.tracker.trackEvent("level-17", "level-end", null, int(Math.round(playtime)));
				FlxG.switchState(new LevelCompleteState(playtime));
			}
		}
		
	}

}