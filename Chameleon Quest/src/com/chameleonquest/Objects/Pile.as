package com.chameleonquest.Objects 
{
	import org.flixel.*;

	public class Pile extends FlxSprite
	{
		
		[Embed(source = "../../../../assets/pile.png")]public var pileImg:Class;
		
		public function Pile(Xindex:int, Yfloorindex:int) 
		{
			super(Xindex * 16, Yfloorindex * 16 - 16, pileImg);
		}
		
	}

}