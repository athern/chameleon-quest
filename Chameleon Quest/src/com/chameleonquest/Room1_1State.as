package com.chameleonquest 
{
	/**
	 * ...
	 * @author Riley Wilk
	 */
	public class Room1_1State extends PlayState
	{
		
		[Embed(source = "../../../assets/1-1.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		
		override public function create():void
		{	
			ROOM_WIDTH = 40;
			ROOM_HEIGHT = 15;
			add(map.loadMap(new levelMap, levelTiles, 16, 16));
			add(player = new Player(0, 208));
			super.create();
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}