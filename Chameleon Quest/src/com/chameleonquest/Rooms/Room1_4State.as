package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.WoodBlock;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;

	
	public class Room1_4State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-4_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 15;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			Preloader.logger.logLevelStart(1, {"src": 3});
			Preloader.tracker.trackPageview("/level-4");
			Preloader.tracker.trackEvent("level-4", "level-enter", null, 3);
				
			player = new Chameleon(0, ROOM_HEIGHT - 1);
			
			// add rock pile
			bgElems.add(new Pile(13, ROOM_HEIGHT - 1));
			intrELems.add(new WoodBlock(24, 14));
			
			// add enemies
			enemies.add(new Bird(20 * 16, 26 * 16, (ROOM_HEIGHT - 10) * 16));
			enemies.add(new PoisonSnake(13 * 16, 16 * 2));
			//enemies.add(new PoisonSnake(new Array(new FlxPoint(13 * 16, 16 * 3))));
			
			Main.lastRoom = 4;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16) {
				Preloader.logger.logLevelEnd({"dest": 5, "time": playtime});
				Preloader.tracker.trackPageview("/level-4-end");
				Preloader.tracker.trackEvent("level-4", "level-end", null, int(Math.round(playtime)));
				
				FlxG.switchState(new LevelCompleteState(playtime, 45, 14));
			}
		}
		
	}

}