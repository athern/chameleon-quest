package com.chameleonquest.Objects 
{
	import org.flixel.*;
	
	public class ChainSegment extends FlxSprite
	{
		[Embed(source = "../../../../assets/chain.png")]
		protected var img:Class;
		
		override public function ChainSegment(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(img);
			scale.x = .125;
			scale.y = .125;
			width = 16;
			height = 16;
			offset.x = 56;
			offset.y = 56;
			
		}
		
	}

}