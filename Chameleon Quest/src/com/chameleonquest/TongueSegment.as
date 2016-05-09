package com.chameleonquest 
{
	import org.flixel.FlxSprite;
	public class TongueSegment extends FlxSprite
	{
		
		[Embed(source = "../../../assets/tonguesegment.png")]
		protected var img:Class;
		
		override public function TongueSegment(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(img, false, true);
			exists = false;
		}
		
	}

}