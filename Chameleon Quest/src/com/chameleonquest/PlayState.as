package com.chameleonquest 
{
	import org.flixel.*;
	
    public class PlayState extends FlxState
    {
		
		[Embed(source = "../../../assets/tile-16.png")]
		public var levelTiles:Class;
		
		public var ROOM_WIDTH:int;
		public var ROOM_HEIGHT:int;
	
		public var map:FlxTilemap = new FlxTilemap;
		public var player:Player;
		
        override public function create():void
		{
			FlxG.camera.setBounds(0, 0, 16*ROOM_WIDTH, 16*ROOM_HEIGHT, true);
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