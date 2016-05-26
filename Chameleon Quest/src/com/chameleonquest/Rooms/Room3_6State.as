package com.chameleonquest.Rooms 
{
	import com.chameleonquest.interactiveObj.WoodBlock;
	import org.flixel.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Objects.*;
	import com.chameleonquest.Enemies.Spikes;
	
	public class Room3_6State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_3-6_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 45;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Chameleon(0, 29);
			Preloader.logger.logLevelStart(20, {"src": 19});
			Preloader.tracker.trackPageview("/level-20");
			Preloader.tracker.trackEvent("level-20", "level-enter", null, 19);
			bgElems.add(new Torch(6, 12));
			bgElems.add(new Pile(24, 31));
			intrELems.add(new WoodBlock(16, 28));
			intrELems.add(new WoodBlock(8, 22));
			elems.add(new PlatformOnRope(11 * 16, 15 * 16));
			FlxG.visualDebug = true;
			
			Main.lastRoom = 20;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16) {
				Preloader.logger.logLevelEnd({"dest": 21, "time": playtime});
				Preloader.tracker.trackPageview("/level-20-end");
				Preloader.tracker.trackEvent("level-20", "level-end", null, int(Math.round(playtime)));
				FlxG.switchState(new LevelCompleteState(playtime));
			}
		}
		
	}

}