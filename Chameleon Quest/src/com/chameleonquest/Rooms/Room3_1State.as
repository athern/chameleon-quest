package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.WaterWheel;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;

	public class Room3_1State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_3-1_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Chameleon(0, ROOM_HEIGHT - 9);
			Preloader.logger.logLevelStart(15, {"src": 14});
			Preloader.tracker.trackPageview("/level-15");
			Preloader.tracker.trackEvent("level-15", "level-enter", null, 14);
			// add spikes
			Spikes.addSpikeRow(5, ROOM_HEIGHT - 1, 2, enemies);
			Spikes.addSpikeRow(15, ROOM_HEIGHT -3, 13, enemies);
			
			// add rope platform
			elems.add(new PlatformOnRope(16 * 5, 16 * 19));
			elems.add(new PlatformOnRope(16 * 18, 16 * 19));
			elems.add(new PlatformOnRope(16 * 23, 16 * 19));
						
			// add torch
			bgElems.add(new Torch(2, (ROOM_HEIGHT - 11)));
			Main.lastRoom = 15;						
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16) {
				Preloader.logger.logLevelEnd({"dest": 16, "time": playtime});
				Preloader.tracker.trackPageview("/level-15-end");
				Preloader.tracker.trackEvent("level-15", "level-end", null, int(Math.round(playtime)));
				FlxG.switchState(new LevelCompleteState(playtime, 60, 20));
			}
		}
		
	}

}