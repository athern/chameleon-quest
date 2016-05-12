package com.chameleonquest.Objects 
{
	import org.flixel.*;
	
	public class ChainSegment extends FlxSprite
	{
		[Embed(source = "../../../../assets/chain.png")]
		protected var img:Class;
		
		public var parentPlatform:PlatformOnChain;
		
		override public function ChainSegment(X:int, Y:int, platform:PlatformOnChain) 
		{
			super(X-16, Y);
			loadGraphic(img);
			scale.x = .125;
			scale.y = .125;
			width = 48;
			height = 16;
			offset.x = 40;
			offset.y = 56;
			parentPlatform = platform;
		}
		
	}

}