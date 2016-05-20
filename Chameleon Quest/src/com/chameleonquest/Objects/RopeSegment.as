package com.chameleonquest.Objects 
{
	import org.flixel.*;

	public class RopeSegment extends FlxSprite
	{
		[Embed(source = "../../../../assets/rope.png")]
		protected var img:Class;
		
		override public function RopeSegment(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(img);
			scale.x = .5;
			scale.y = .5;
			width = 32;
			height = 32;
			offset.x = 16;
			offset.y = 16;
			
		}
		
	}

}