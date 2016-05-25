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
	
	public class Room3_4State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_3-4_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Chameleon(0, 29);
			Preloader.logger.logLevelStart(18, {"src": 17});
			Preloader.tracker.trackPageview("/level-18");
			Preloader.tracker.trackEvent("level-18", "level-enter", null, 17);
			
			Main.lastRoom = 18;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16) {
				Preloader.logger.logLevelEnd({"dest": 19, "time": playtime});
				Preloader.tracker.trackPageview("/level-18-end");
				Preloader.tracker.trackEvent("level-18", "level-end", null, int(Math.round(playtime)));
				FlxG.switchState(new LevelCompleteState(playtime));
			}
		}
		
	}

}