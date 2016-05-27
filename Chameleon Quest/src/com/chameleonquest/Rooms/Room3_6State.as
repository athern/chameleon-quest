package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Enemies.Bird;
	import com.chameleonquest.interactiveObj.*;
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
			Preloader.tracker.trackPageview(Preloader.flag + "/level-20");
			Preloader.tracker.trackEvent("level-20", "level-enter", null, 19);
			bgElems.add(new Torch(6, 12));
			bgElems.add(new Pile(24, 31));
			intrELems.add(new WoodBlock(16, 28));
			intrELems.add(new WoodBlock(8, 22));
			elems.add(new PlatformOnRope(11 * 16, 15 * 16));
			var blockGate:StoneGate = new StoneGate(16, 21, 100, 480, StoneGate.YELLOW);
			intrELems.add(new Button(18, 23, blockGate, StoneGate.lift, 80, 90, Button.YELLOW));
			elems.add(blockGate);
			var boulderGate:StoneGate = new StoneGate(4, 4, -1, 200, StoneGate.BLUE, 270);
			intrELems.add(new Button(28, 23, boulderGate, StoneGate.lift, -1, 270, Button.BLUE));
			elems.add(boulderGate);
			var endGate:StoneGate = new StoneGate(14, 12, -1, 480, StoneGate.RED);
			intrELems.add(new Button(25, 34, endGate, StoneGate.lift, -1, 0, Button.BIGRED));
			elems.add(endGate);
			elems.add(new Boulder(16, -48));
			enemies.add(new Bird(8 * 16, 18 * 16, 33 * 16));
			
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
				Preloader.tracker.trackPageview(Preloader.flag + "/level-20-end");
				Preloader.tracker.trackEvent("level-20", "level-end", null, int(Math.round(playtime)));
				FlxG.switchState(new LevelCompleteState(playtime));
			}
		}
		
	}

}