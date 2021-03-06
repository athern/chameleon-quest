package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
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
			ROOM_WIDTH = 50;
			ROOM_HEIGHT = 15;
			map.loadMap(new levelMap, levelTiles, 16, 16);
			
			Spikes.addSpikeRow(17, ROOM_HEIGHT-1, 3, enemies);
			Spikes.addSpikeRow(27, ROOM_HEIGHT - 1, 4, enemies);
			bgElems.add(new Door(2, 14, false));
			elems.add(new Door(46, 14, true));
			
				
			player = new Chameleon(2, ROOM_HEIGHT-1);
			
			intrELems.add(new WoodBlock(43, 14));
			
			Main.lastRoom = 1;
			
			super.create();
			
			var lefthelp:FlxText;
			lefthelp = new FlxText(52, 177, 70, "<- ->");
			lefthelp.setFormat(null, 14, 0x555555, "center");
			lefthelp.alpha = .5;
			this.add(lefthelp);
			
			var jumphelp:FlxText;
			jumphelp = new FlxText(72, 170, 50, "<-");
			jumphelp.setFormat(null, 14, 0x555555, "center");
			jumphelp.alpha = .5;
			jumphelp.angle = 90;
			this.add(jumphelp);
			
			var spacehelp:FlxText;
			spacehelp = new FlxText(550, 177, 100, "SPACE");
			spacehelp.setFormat(null, 14, 0x555555, "center");
			spacehelp.alpha = .5;
			this.add(spacehelp);
			
			var morehelp:FlxText;
			morehelp = new FlxText(520, 200, 150, "GRAB BLOCKS WITH TONGUE");
			morehelp.setFormat(null, 8, 0x555555, "center");
			morehelp.alpha = .5;
			add(morehelp);
			
		}
		
	}

}