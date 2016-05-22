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
			Spikes.addSpikeRow(4, ROOM_HEIGHT - 5, 3, enemies, 6);
			Spikes.addSpikeRow(15, ROOM_HEIGHT -3, 13, enemies, 6);
			
			// add rope platform
			elems.add(new PlatformOnRope(16 * 4, 16 * 18, 2));
			elems.add(new PlatformOnRope(16 * 18, 16 * 19));
			elems.add(new PlatformOnRope(16 * 23, 16 * 19));
			enemies.add(new Snake(12 * 16, 13 * 16, 10 * 16));
			enemies.add(new Snake(9 * 16, 10 * 16, 14 * 16));
			
			
						
			// add torch
			bgElems.add(new Torch(2, (ROOM_HEIGHT - 10)));
			Main.lastRoom = 15;						
			super.create();
			
			var hint:FlxText;
			hint = new FlxText(41, 17*16 + 8, 70, "C");
			hint.setFormat(null, 14, 0x555555, "left");
			hint.alpha = .5;
			this.add(hint);
			
			var chargeHint:FlxText;
			chargeHint = new FlxText(17 * 16, 3 * 16, 200, "HOLD SPACE TO CHARGE");
			chargeHint.setFormat(null, 8, 0x555555, "left");
			chargeHint.alpha = .5;
			add(chargeHint);
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