package com.chameleonquest.Objects 
{
	import org.flixel.*;

	public class Firework extends FlxSprite
	{
				
		public function Firework(XIdx:int, YIdx:int, img:Class) 
		{
			super(XIdx * 16, YIdx * 16);
			loadGraphic(img, true, true, 32, 32);
			addAnimation("FIRE", [0, 13, 15, 16, 17, 18, 4, 9, 1, 2, 3, 5, 6, 7, 8, 10, 11, 12], 20);
			play("FIRE");
		}
		
	}

}