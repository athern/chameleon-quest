package com.chameleonquest.Objects 
{
	import org.flixel.*;

	public class Pile extends FlxSprite
	{
		
		[Embed(source = "../../../../assets/pile.png")]public var pileImg:Class;
		
		public function Pile(Xindex:int, Yfloorindex:int) 
		{
			super(Xindex*16, Yfloorindex*16-16);
			loadGraphic(pileImg, true, true, 32, 32);
			scale.x = 0.5;
			scale.y = 0.5;
			width = 16;  
			offset.x = 8;
			height = 16;
			offset.y = 8;
			
			immovable = true;
		}
		
	}

}