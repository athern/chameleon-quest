package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.*;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room2_2State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_2-2_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		public var grates:FlxGroup = new FlxGroup();
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			
			if (Main.lastRoom == 10)
			{
				Preloader.logger.logLevelStart(9, {"src": 10});
				Preloader.tracker.trackPageview("/level-9");
				Preloader.tracker.trackEvent("level-9", "level-enter", null, 10);
				
				player = new Chameleon(1, ROOM_HEIGHT - 15);
			}
			else
			{
				Preloader.logger.logLevelStart(9, {"src": 8});
				Preloader.tracker.trackPageview("/level-9");
				Preloader.tracker.trackEvent("level-9", "level-enter", null, 8);
				
				player = new Chameleon(1, ROOM_HEIGHT - 6);			
				
			}
			
			
			player.facing = FlxObject.RIGHT;
			
			bgElems.add(new Pile(ROOM_WIDTH - 7, 8));
			
			grates.add(new Grate(ROOM_WIDTH - 4, ROOM_HEIGHT - 8));
			grates.add(new Grate(ROOM_WIDTH - 3, ROOM_HEIGHT - 8));
			grates.add(new Grate(ROOM_WIDTH - 2, ROOM_HEIGHT - 8));
			
			bgElems.add(grates);
			
			bgElems.add(new WaterFountain(6, ROOM_HEIGHT - 6));
			
			var gate:StoneGate = new StoneGate(5, 15, -1);
			elems.add(gate);
			
			if (Main.lastRoom == 10)
			{
				StoneGate.lift(gate);
			}
			
			intrELems.add(new AngleBlock(11, 7, 0));
			intrELems.add(new Button(11, 1, gate, StoneGate.lift, 100, 180));
			
			intrELems.add(new WoodBlock(15, (ROOM_HEIGHT - 6)));
			
			
			enemies.add(new PoisonSnake(11 * 16, (ROOM_HEIGHT - 14) * 16));
			enemies.add(new Bird(11 * 16, 18 * 16, (ROOM_HEIGHT - 20) * 16));
			enemies.add(new Snake((ROOM_WIDTH - 7) * 16, (ROOM_WIDTH - 6) * 16, (ROOM_HEIGHT - 18) * 16));
			
			Main.lastRoom = 9;

			super.create();
			
			var hint:FlxText;
			hint = new FlxText(8 * 16, 16 * (ROOM_HEIGHT - 10), 70, "C --> X");
			hint.setFormat(null, 14, 0x555555, "center");
			hint.alpha = .5;
			this.add(hint);
		}
		
		override public function update():void
		{
			super.update();
			
			// water grate check
			if (player.getType() != Chameleon.WATER) {
				FlxG.collide(player, grates);					
			}
			
			if (player.x < 0 && player.y > ROOM_HEIGHT - 17) {
				Preloader.logger.logLevelEnd({"dest": 10, "time": playtime});
				Preloader.tracker.trackPageview("/level-9-end");
				Preloader.tracker.trackEvent("level-9", "level-end", null, playtime * 100);
				
				FlxG.switchState(new Room2_3State());
			} else if (player.x < 0 && player.y > ROOM_HEIGHT - 6) {
				Preloader.logger.logLevelEnd({"dest": 8, "time": playtime});
				Preloader.tracker.trackPageview("/level-9-end");
				Preloader.tracker.trackEvent("level-9", "level-end", null, playtime * 100);
				
				FlxG.switchState(new Room2_1State());
			}
		}
		
	}

}