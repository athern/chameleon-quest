package com.chameleonquest.Rooms 
{
	import org.flixel.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room1_5State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_1-5_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{	
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Player(0, 14, this.map.getBounds());
			bgElems.add(new Pile(5, 15));
			
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
		}
		
	}

}