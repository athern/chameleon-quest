package com.chameleonquest.Rooms 
{
	import com.chameleonquest.*;
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Enemies.Bird;
	import com.chameleonquest.Enemies.PoisonSnake;
	import com.chameleonquest.Enemies.Snake;
	import org.flixel.*;
	import com.chameleonquest.Objects.*;
	import com.chameleonquest.interactiveObj.*;
	
	public class Room1_6State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-6_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			if (Main.lastRoom == 7)
			{
				Preloader.logger.logLevelStart(1, {"src": 7});
				Preloader.tracker.trackPageview("/level-6");
				Preloader.tracker.trackEvent("level-6", "level-enter", null, 7);
				
				player = new Chameleon(0, ROOM_HEIGHT - 1);
			}
			else
			{
				Preloader.logger.logLevelStart(1, {"src": 5});
				Preloader.tracker.trackPageview("/level-6");
				Preloader.tracker.trackEvent("level-6", "level-enter", null, 5);
				
				player = new Chameleon(ROOM_WIDTH - 1, 14);
				player.facing = FlxObject.LEFT;
			}
			
			bgElems.add(new Pile(16, 11));
			bgElems.add(new Pile(6, 21));
			bgElems.add(new Pile(17, 29));
			enemies.add(new Bird(4 * 16, 22 * 16, 152));
			enemies.add(new Snake(9 * 16, 11 * 16, 6 * 16));
			enemies.add(new PoisonSnake(26 * 16, 27 * 16));
			var rotatingBlock:AngleBlock = new AngleBlock(1, 8, 180);
			var patrollingBlock:AngleBlock = new AngleBlock(14, 18, 0);
			patrollingBlock.patrol(14 * 16+4, 20 * 16, 20);
			var gate1:StoneGate = new StoneGate(8, 21, -1);
			var gate2:StoneGate = new StoneGate(7, 29, -1);
			elems.add(gate1);
			elems.add(gate2);
			intrELems.add(rotatingBlock);
			intrELems.add(patrollingBlock);
			intrELems.add(new AngleBlock(1, 10, 90));
			intrELems.add(new AngleBlock(28, 18, 180));
			intrELems.add(new AngleBlock(28, 28, 270));
			intrELems.add(new Button(1, 5, gate1, StoneGate.lift, 100, 180, Button.RED));
			intrELems.add(new Button(1, 21, rotatingBlock, AngleBlock.rotate, 20, 0, Button.RED));
			intrELems.add(new Button(15, 15, gate2, StoneGate.lift, 100, 180, Button.RED));
			intrELems.add(new Button(14, 20, patrollingBlock, InteractiveObj.stopOrStart, 20, 270, Button.RED));
			elems.add(new Platform(new Array(new FlxPoint(3*16, 11*16), new FlxPoint(3*16, 18*16)), 60));
			elems.add(new Platform(new Array(new FlxPoint(10*16, 21*16), new FlxPoint(10*16, 26*16)), 50));
			
			
			Main.lastRoom = 6;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				Preloader.logger.logLevelEnd({"dest": 7, "time": playtime});
				Preloader.tracker.trackPageview("/level-6-end");
				Preloader.tracker.trackEvent("level-6", "level-end", null, int(Math.round(playtime)));
				
				FlxG.switchState(new LevelCompleteState(playtime, 90, 30));
			}
			else if (player.x > ROOM_WIDTH * 16 - 16) {
				player.x = ROOM_WIDTH * 16 - 16;
			}
		}
		
	}

}