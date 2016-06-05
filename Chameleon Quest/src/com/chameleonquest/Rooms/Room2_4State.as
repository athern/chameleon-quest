package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.WaterWheel;
	import org.flixel.*;
	import com.chameleonquest.Enemies.*;
	import com.chameleonquest.*;
	import com.chameleonquest.Objects.*;
	
	public class Room2_4State extends PlayState
	{
		
		[Embed(source = "../../../../assets/mapCSV_2-4_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		override public function create():void
		{
			ROOM_WIDTH = 30;
			ROOM_HEIGHT = 30;
			map.loadMap(new levelMap, levelTiles, 16, 16);
				
			player = new Chameleon(26, 6);
			player.facing = FlxObject.LEFT;
			bgElems.add(new Door(26, 6, false));
			elems.add(new Door(2, 6, true));
			
			var gate:StoneGate = new StoneGate(11, 6, -1);
			elems.add(gate);
			enemies.add(new Boar(5 * 16, 26 * 16, 4 * 16, 1));
			enemies.add(new Snake(4 * 16, 11 * 16, 8 * 16, FlxObject.RIGHT));
			
			intrELems.add(new WaterWheel(13, 7, gate, StoneGate.gradualLift));
			
			bgElems.add(new WaterFountain(16, 6));
			
			Main.lastRoom = 11;
			super.create();
		}
		
	}

}