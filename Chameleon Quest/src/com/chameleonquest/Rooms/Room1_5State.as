package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.Button;
	import org.flixel.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	import com.chameleonquest.Enemies.*;

	
	public class Room1_5State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-5_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		public var turtles:Array = new Array();
		
		override public function create():void
		{	
			ROOM_WIDTH = 35;
			ROOM_HEIGHT = 23;
			map.loadMap(new levelMap, levelTiles, 16, 16);
				
			player = new Chameleon(5, 12);
			bgElems.add(new Pile(25, 7));
			bgElems.add(new Pile(16, 21));
			bgElems.add(new Door(5, 12, false));
			elems.add(new Door(4, 19, true));
			var gate:StoneGate = new StoneGate(12, 21, -1, 240, StoneGate.RED);
			elems.add(gate);
			intrELems.add(new Button(21, 20, gate, StoneGate.lift, 100, 270));
			new Pulley(elems, 16 * 18, 16 * 17, 16 * 31, 16 * 9, 2);
			for (var i:int = 0; i < 24; i++)
			{
				turtles.push(new Turtle(16 * 29, 16 * 23 - 16 * i));
				enemies.add(turtles[turtles.length - 1]);
			}
			
			Main.lastRoom = 5;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			for (var i:int = 0; i < turtles.length; i++)
			{
				var cur:Turtle = turtles[i] as Turtle;
				var next:Turtle = turtles[i + 1] as Turtle;
				if (cur.x != 16 * 29)
				{
					turtles.splice(i, 1);
					var replacement:Turtle = new Turtle(16 * 29, turtles[turtles.length - 1].y - 16);
					turtles.push(replacement);
					enemies.add(replacement);
				}
				else if (next != null && cur.y - next.y < 16)
				{
					next.y = cur.y - 16;
					next.velocity.y = 0;
				}
			}
		}
		
	}

}