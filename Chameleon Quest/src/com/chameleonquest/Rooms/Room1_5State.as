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
		
		//public var pull:Pulley;
		
		override public function create():void
		{	
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
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
			elems.add(new PlatformOnChain(16 * 13, 16 * 15));
			//elems.add(new PlatformOnChain(16 * 3, 16 * 15));
			
			//pull = new Pulley(16 * 13, 16 * 15, 16 * 3, 16 * 15);
			//elems.add(pull);
			
			Main.lastRoom = 5;
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			//FlxG.collide(player, pull, pull.addWeight);
						
			if (player.x < 0 && player.y > 20*16) {
				FlxG.switchState(new Room1_6State());
			} else if (player.x < 0 && player.y > 13 * 16) {
				FlxG.switchState(new Room1_4State());
			}
		}
		
	}

}