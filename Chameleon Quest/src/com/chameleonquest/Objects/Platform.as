package com.chameleonquest.Objects 
{
	import org.flixel.*;
	
	public class Platform extends FlxSprite
	{
		
		[Embed(source = "../../../../assets/Platform.png")]
		public var img:Class;
		
		public function Platform(p:Array, s:int) 
		{
			super(p[0].x, p[0].y, img);
			if (p.length > 1)
			{
				followPath(new FlxPath(p), s, PATH_YOYO);
			}
			immovable = true;
		}
		
	}

}