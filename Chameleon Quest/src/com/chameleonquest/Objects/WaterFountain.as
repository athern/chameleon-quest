package com.chameleonquest.Objects 
{
	import org.flixel.*;

	public class WaterFountain extends FlxSprite
	{
		[Embed(source = "../../../../assets/fountain.png")]public var torchImg:Class;
		
		public function WaterFountain(Xindex:int, Yfloorindex:int) 
		{
			super(Xindex*16, Yfloorindex*16-16);
			loadGraphic(torchImg, true, true, 64, 83);
			scale.x = 0.5;
			scale.y = 0.5;
			width = 32;  
			offset.x = 16;
			height = 64;
			offset.y = 14;
			
			immovable = true;
			
			addAnimation("play", [0, 1, 2], 3);
			
			play("play");
		}
	}

}