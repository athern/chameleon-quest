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
			scale.x = .25;
			scale.y = .25;
			width = 16;
			height = 16;
			offset.x = 24;
			offset.y = 24;
			
		}
		
	}

}