package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	
	public class Room3_2State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_3-2_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 45;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Chameleon(0, 3);
			Preloader.logger.logLevelStart(16, {"src": 15});
			Preloader.tracker.trackPageview("/level-16");
			Preloader.tracker.trackEvent("level-16", "level-enter", null, 15);
			// add spikes
			Spikes.addSpikeRow(19, ROOM_HEIGHT - 1, 8, enemies);
			Main.lastRoom = 16;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16) {
				Preloader.logger.logLevelEnd({"dest": 17, "time": playtime});
				Preloader.tracker.trackPageview("/level-16-end");
				Preloader.tracker.trackEvent("level-16", "level-end", null, int(Math.round(playtime)));
				FlxG.switchState(new LevelCompleteState(playtime));
			}
		}
		
	}

}