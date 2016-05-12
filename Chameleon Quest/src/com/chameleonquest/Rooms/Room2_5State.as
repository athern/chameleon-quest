package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.WaterWheel;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room2_5State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_2-5_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			
			if (Main.lastRoom == 13)
			{
				Preloader.logger.logLevelStart(12, {"src": 11});
				Preloader.tracker.trackPageview("/level-12");
				Preloader.tracker.trackEvent("level-12", "level-enter", null, 11);
				
				player = new Chameleon(ROOM_WIDTH - 1, 3);
				player.facing = FlxObject.LEFT;
			}
			else
			{
				Preloader.logger.logLevelStart(12, {"src": 13});
				Preloader.tracker.trackPageview("/level-12");
				Preloader.tracker.trackEvent("level-12", "level-enter", null, 13);
				
				player = new Chameleon(ROOM_WIDTH - 1, ROOM_HEIGHT - 1);
				player.facing = FlxObject.LEFT;
			}
			
			
			
			bgElems.add(new Pile(26, 24));
			var gate:StoneGate = new StoneGate(25, 1, 100, 480);
			elems.add(gate);
			bgElems.add(new WaterFountain(26, 13));
			
			intrELems.add(new WaterWheel(13, 6, gate, StoneGate.gradualLift));
			
			Main.lastRoom = 12;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16 && player.y > ROOM_HEIGHT - 3) {
				Preloader.logger.logLevelEnd({"dest": 11, "time": playtime});
				Preloader.tracker.trackPageview("/level-12-end");
				Preloader.tracker.trackEvent("level-12", "level-end", null, playtime * 100);
				
				FlxG.switchState(new Room2_4State());
			}
		}
		
	}

}