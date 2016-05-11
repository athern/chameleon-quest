package com.chameleonquest.Objects 
{
	import org.flixel.*;
	
	public class Platform extends FlxSprite
	{
		
		[Embed(source = "../../../../assets/Platform.png")]
		public var img:Class;
		
		[Embed(source = "../../../../assets/tallerplatform.png")]
		public var img2:Class;
		
		public function Platform(p:Array, s:int, height:int=1) 
		{
			super(p[0].x - 24, p[0].y - 8);
			if (height == 1)
			{
				loadGraphic(img);
			}
			if (height == 2)
			{
				loadGraphic(img2);
			}
			if (p.length > 1)
			{
				followPath(new FlxPath(p), s, PATH_YOYO);
			}
			immovable = true;
		}
		
	}

}