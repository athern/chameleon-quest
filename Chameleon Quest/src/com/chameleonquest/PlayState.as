package com.chameleonquest 
{
	import org.flixel.*;
	
    public class PlayState extends FlxState
    {
		
		[Embed(source = "../../../assets/1-1.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		[Embed(source = "../../../assets/tile-16.png")]
		public var levelTiles:Class;
	
		public var map:FlxTilemap = new FlxTilemap;
		public var player:Player;
		
        override public function create():void
		{
			
			add(map.loadMap(new levelMap, levelTiles, 16, 16));
			add(player = new Player(17, 17));
			FlxG.camera.setBounds(0, 0, 16*40, 16*15, true);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			FlxG.collide(player, map);
		}
    }

}