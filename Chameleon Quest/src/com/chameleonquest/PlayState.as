package com.chameleonquest 
{
	import org.flixel.*;
	
    public class PlayState extends FlxState
    {
		
		[Embed(source = "../../../assets/mapCSV_Group1_Map1.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		[Embed(source = "../../../assets/tileset1.png")]
		public var levelTiles:Class;
	
		public var map:FlxTilemap = new FlxTilemap;
		public var player:Player;
		
        override public function create():void
		{
			add(map.loadMap(new levelMap, levelTiles, 16, 16));
			add(player = new Player(17, 17));
			super.create();
		}
		
		override public function update():void
		{
			FlxG.collide(player, map);
			super.update();
		}
    }

}