package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import org.flixel.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	import com.chameleonquest.Enemies.*;

	
	public class Room1_5State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-5_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		public var turtles:Array;
		
		public var unstackedturtles:Array;
		
		override public function create():void
		{	
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 45;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			if (Main.lastRoom == 6)
			{
				Preloader.logger.logLevelStart(1, {"src": 6});
				Preloader.tracker.trackPageview("/level-5");
				Preloader.tracker.trackEvent("level-5", "level-enter", null, 6);
				
				player = new Chameleon(0, 29);
				
				new Pulley(elems, 16 * 3, 16 * 10, 16 * 19, 16 * 17, 2);
			}
			else
			{
				Preloader.logger.logLevelStart(1, {"src": 4});
				Preloader.tracker.trackPageview("/level-5");
				Preloader.tracker.trackEvent("level-5", "level-enter", null, 4);
				
				player = new Chameleon(0, 14);
			}
			bgElems.add(new Pile(10, 15));
			bgElems.add(new Pile(2, 29));
			new Pulley(elems, 16 * 3, 16 * 25, 16 * 19, 16 * 17, 2);
			turtles = new Array;
			for (var i:int = 0; i < 50; i++)
			{
				turtles.push(new Turtle(16 * 15, 16 * 44 - 16 * i));
			}
			enemies.add(new PoisonSnake(16, 15 * 16));
			enemies.add(new PoisonSnake(16, 19 * 16));
			enemies.add(new PoisonSnake(16, 23 * 16));
			
			for (var j:int = 0; j < 50; j++)
			{
				enemies.add(turtles[j]);
			}
			
			Main.lastRoom = 5;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			for (var i:int = 0; i < turtles.length-1; i++)
			{
				var cur:Turtle = turtles[i] as Turtle;
				var next:Turtle = turtles[i + 1] as Turtle;
				if (cur.x != 16 * 15)
				{
					turtles.splice(i, 1);
					var replacement:Turtle = new Turtle(16 * 15, 0);
					turtles.push(replacement);
					enemies.add(replacement);
				}
				if (cur.x == next.x && cur.y - next.y < 16)
				{
					next.y = cur.y - 16;
				}
			}
			
			if (player.x < 0 && player.y > 20 * 16) {
				Preloader.logger.logLevelEnd({"dest": 6, "time": playtime});
				Preloader.tracker.trackPageview("/level-5-end");
				Preloader.tracker.trackEvent("level-5", "level-end", null, int(Math.round(playtime)));
				
				FlxG.switchState(new LevelCompleteState(playtime));
			} else if (player.x < 0 && player.y > 13 * 16) {
				Preloader.logger.logLevelEnd({"dest": 4, "time": playtime});
				FlxG.switchState(new Room1_4State());
			}
		}
		
	}

}