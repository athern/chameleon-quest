package com.chameleonquest.Rooms 
{
	import com.chameleonquest.interactiveObj.WoodBlock;
	import org.flixel.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Objects.*;
	import com.chameleonquest.Enemies.Spikes;
	
	public class Room3_5State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_3-5_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 45;
			ROOM_HEIGHT = 45;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Chameleon(0, 29);
			Preloader.logger.logLevelStart(19, {"src": 18});
			Preloader.tracker.trackPageview("/level-19");
			Preloader.tracker.trackEvent("level-19", "level-enter", null, 18);
			elems.add(new TNT(30, 29, new Array(new FlxPoint(26 * 16 + 6, 27 * 16 + 6), new FlxPoint(26 * 16 + 6, 30 * 16 + 6),
					new FlxPoint(31 * 16 + 6, 30 * 16 + 6), new FlxPoint(31 * 16 + 6, 32 * 16 + 6),
					new FlxPoint(26 * 16 + 6, 32 * 16 + 6), new FlxPoint(26 * 16 + 6, 34 * 16 + 6),
					new FlxPoint(31 * 16 + 6, 34 * 16 + 6), new FlxPoint(31 * 16 + 6, 36 * 16 + 6),
					new FlxPoint(17 * 16 + 6, 36 * 16 + 6), new FlxPoint(17 * 16 + 6, 34 * 16 + 6),
					new FlxPoint(24 * 16 + 6, 34 * 16 + 6), new FlxPoint(24 * 16 + 6, 32 * 16 + 6),
					new FlxPoint(17 * 16 + 6, 32 * 16 + 6), new FlxPoint(17 * 16 + 6, 30 * 16 + 6),
					new FlxPoint(24 * 16 + 6, 30 * 16 + 6), new FlxPoint(24 * 16 + 6, 27 * 16 + 6),
					new FlxPoint(22 * 16 + 6, 27 * 16 + 6))));
			bgElems.add(new Torch(12, 29));
			intrELems.add(new WoodBlock(30, 27, 2));
			
			Spikes.addSpikeRow(14, 10, 2, enemies, 6);
			Spikes.addSpikeRow(14, 7, 3, enemies, 6, 180);
			Spikes.addSpikeRow(16, 20, 4, enemies, 6, 180);
			Spikes.addSpikeRow(13, 23, 1, enemies, 6);
			Spikes.addSpikeRow(26, 19, 2, enemies, 6);
			Spikes.addSpikeRow(19, 15, 2, enemies, 6);
			Spikes.addSpikeRow(21, 19, 2, enemies, 6);
			Spikes.addSpikeRow(13, 3, 5, enemies, 6, 180);
			
			Main.lastRoom = 19;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16) {
				Preloader.logger.logLevelEnd({"dest": 20, "time": playtime});
				Preloader.tracker.trackPageview("/level-19-end");
				Preloader.tracker.trackEvent("level-19", "level-end", null, int(Math.round(playtime)));
				FlxG.switchState(new LevelCompleteState(playtime));
			}
		}
		
	}

}