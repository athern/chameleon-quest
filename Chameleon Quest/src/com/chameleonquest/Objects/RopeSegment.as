package com.chameleonquest.Objects 
{
	import org.flixel.*;

	public class RopeSegment extends FlxSprite
	{
		[Embed(source = "../../../../assets/rope.png")]
		protected var img:Class;
		
		override public function RopeSegment(X:int, Y:int) 
		{
			super(X, Y, img);
			
		}
		
	}

}