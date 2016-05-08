package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Player;
	import org.flixel.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	import com.chameleonquest.Enemies.*;

	
	public class Room1_5State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-5_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		public var pull:Pulley;
		
		public var turtles:Array;
		
		public var unstackedturtles:Array;
		
		override public function create():void
		{	
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 45;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			if (Main.lastRoom == 6)
			{
				player = new Player(0, 29);
			}
			else
			{
				player = new Player(0, 14);
			}
			bgElems.add(new Pile(6, 15));
			
			pull = new Pulley(16 * 3, 16 * 25, 16 * 13, 16 * 15);
			turtles = new Array;
			unstackedturtles = new Array;
			for (var i:int = 0; i < 100; i++)
			{
				turtles.push(new Turtle(16 * 9, 16 * 29 - 16 * i));
			}
			
			for (var j:int = 0; j < 100; j++)
			{
				enemies.add(turtles[j]);
			}
			
			Main.lastRoom = 5;
			super.create();
			
			add(pull);
		}
		
		override public function update():void
		{
			super.update();
			FlxG.collide(player, pull, pull.addWeight);
			FlxG.collide(enemies, pull);
			for (var i:int = 0; i < turtles.length-1; i++)
			{
				var cur:Turtle = turtles[i] as Turtle;
				var next:Turtle = turtles[i + 1] as Turtle;
				if (cur.x != 16 * 9)
				{
					unstackedturtles.push(cur);
					turtles.splice(i, 1);
					var replacement:Turtle = new Turtle(16 * 9, 0);
					turtles.push(replacement);
					enemies.add(replacement);
				}
				if (cur.x == next.x && cur.y - next.y < 16)
				{
					next.y = cur.y - 16;
				}
			}
			for (var j:int = 0; j < unstackedturtles.length; j++)
			{
				cur = unstackedturtles[j] as Turtle;
				if (cur.x + cur.width >= pull.platform2.x && cur.isTouching(FlxObject.FLOOR))
				{
					pull.addWeight(cur, pull.platform2);
				}
			}
			
			if (player.x < 0 && player.y > 20*16) {
				FlxG.switchState(new Room1_6State());
			} else if (player.x < 0 && player.y > 13 * 16) {
				FlxG.switchState(new Room1_4State());
			}
		}
		
	}

}