package com.chameleonquest.Enemies 
{
	import org.flixel.*;
	public class GeyserSegment extends Enemy
	{
		
		[Embed(source = "../../../../assets/geyserbody.png")]
		protected var img:Class;
		
		override public function GeyserSegment(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(img, true, false, 32, 32);
			addAnimation("shooting", [0, 1, 2], 10);
			play("shooting");
			exists = false;
			immovable = true;
		}
		
	}

}