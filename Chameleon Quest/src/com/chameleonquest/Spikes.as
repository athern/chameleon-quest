package com.chameleonquest 
{
	import org.flixel.*;
	
	public class Spikes extends FlxSprite
	{
		[Embed(source = "../../../assets/spike.png")]public var spikeImg:Class;
		
		public function Spikes(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(spikeImg, true, true, 128, 64);
			scale.x = 0.125;
			scale.y = 0.125;
			width = 16;  
			offset.x = 56;
			height = 8;
			offset.y = 28;
			
			immovable = true;
		}
		
	}

}