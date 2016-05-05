package com.chameleonquest.Rooms 
{
	import com.chameleonquest.interactiveObj.Button;
	import com.chameleonquest.interactiveObj.WoodBlock;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room1_1State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-1_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{	
			ROOM_WIDTH = 45;
			ROOM_HEIGHT = 15;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			
			Spikes.addSpikeRow(17, ROOM_HEIGHT-1, 3, enemies);
			Spikes.addSpikeRow(27, ROOM_HEIGHT-1, 4, enemies);
			// add rock pile
			bgElems.add(new Pile(5, ROOM_HEIGHT-1));
			
			if (Main.lastRoom == 2) {
				player = new Player(ROOM_WIDTH-3, ROOM_HEIGHT-1);
				player.facing = FlxObject.LEFT;
			}
			else {
				player = new Player(0, ROOM_HEIGHT-1);
			}
			
			intrELems.add(new WoodBlock(43, 14));
			
			Main.lastRoom = 1;
			
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
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