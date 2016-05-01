package com.chameleonquest 
{
	import org.flixel.*;
	
	public class Room1_2State extends PlayState
	{
		
		[Embed(source = "../../../assets/mapCSV_1-2_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{	
			ID = 2;
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			add(map.loadMap(new levelMap, levelTiles, 16, 16));
			add(player = new Player(0, 449));
			elems.add(new Platform(new Array(new FlxPoint(40, 160), new FlxPoint(19 * 16, 160)), 60));
			add(elems);
			Main.lastRoom = 2;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				FlxG.switchState(new Room1_1State());
			}
			if (player.x > map.width - 32) {
				player.velocity.y = 0;
			}
			if (player.x > map.width - 16) {
				FlxG.switchState(new Room1_2State());
			}
		}
		
	}

}