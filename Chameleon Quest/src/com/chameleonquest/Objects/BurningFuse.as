package com.chameleonquest.Objects 
{
	import org.flixel.*;
	
	public class BurningFuse extends FlxSprite
	{
		[Embed(source = "../../../../assets/fireball.png")]public var img:Class;
		public function BurningFuse(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(img, true, false, 32, 32);
			scale.x = .25;
			scale.y = .25;
			width = 8;
			height = 8;
			offset.x = 12;
			offset.y = 12;
			addAnimation("burn", [0, 1, 2], 10);
			play("burn");
		}
		
	}

}