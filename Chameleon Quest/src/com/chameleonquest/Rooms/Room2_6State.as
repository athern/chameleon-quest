package com.chameleonquest.Rooms 
{

	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.WaterWheel;
	import com.chameleonquest.interactiveObj.WoodBlock;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room2_6State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_2-6_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 45;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			
			Preloader.logger.logLevelStart(13, {"src": 12});
			Preloader.tracker.trackPageview("/level-13");
			Preloader.tracker.trackEvent("level-13", "level-enter", null, 12);
				
			player = new Chameleon(0, ROOM_HEIGHT - 4);
			player.facing = FlxObject.RIGHT;
											
			grates.add(new Grate(16, ROOM_HEIGHT - 9));
			grates.add(new Grate(17, ROOM_HEIGHT - 9));
			grates.add(new Grate(18, ROOM_HEIGHT - 9));
			grates.add(new Grate(18, ROOM_HEIGHT - 10));
			grates.add(new Grate(19, ROOM_HEIGHT - 10));
			grates.add(new Grate(20, ROOM_HEIGHT - 10));
			grates.add(new Grate(20, ROOM_HEIGHT - 11));
			grates.add(new Grate(21, ROOM_HEIGHT - 11));
			grates.add(new Grate(22, ROOM_HEIGHT - 11));
			
			bgElems.add(grates);
			
			bgElems.add(new WaterFountain(30, ROOM_HEIGHT - 5));
			bgElems.add(new Pile(19, ROOM_HEIGHT - 3));
			
			intrELems.add(new WoodBlock(21, 26));
			
			new Pulley(elems, 16 * 25, 16 * 16, 16 * 30, 16 * 13);
			elems.add(new Platform(new Array(new FlxPoint(35*16, 24*16), new FlxPoint(35*16, 20*16)), 60));
			
			var gate:StoneGate = new StoneGate(35, 15, 400, 480);
			elems.add(gate);
			intrELems.add(new WaterWheel(41, 15, gate, StoneGate.gradualLift));
			
			enemies.add(new Turtle(16 * 26, 16 * 15));
			enemies.add(new Bird(15 * 16, 22 * 16, 16 * 16));
			enemies.add(new Bird(26 * 16, 36 * 16, 18 * 16));
			Main.lastRoom = 13;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16) {
				Preloader.logger.logLevelEnd({"dest": 14, "time": playtime});
				Preloader.tracker.trackPageview("/level-13-end");
				Preloader.tracker.trackEvent("level-13", "level-end", null, int(Math.round(playtime)));
				FlxG.switchState(new LevelCompleteState(playtime, 30, 80));
				
				
			}
		}
		
	}

}