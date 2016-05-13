package com.chameleonquest.Objects 
{
	
	import com.chameleonquest.Chameleons.Chameleon;
	import org.flixel.*;
	
	public class RockGem extends FlxSprite implements ElementSource
	{
		
		[Embed(source = "../../../../assets/quartz.png")]public var pileImg:Class;
		
		public function RockGem(Xindex:int, Yfloorindex:int) 
		{
			super(Xindex*16, Yfloorindex*16-16);
			loadGraphic(pileImg, true, true, 128, 111);
			scale.x = 0.25;
			scale.y = 0.25;
			width = 32;  
			offset.x = 48;
			height = 32;
			offset.y = 40;
			
			immovable = true;
		}
		
		public function getElementType():uint
		{
			return Chameleon.EARTH;
		}
		
	}

}