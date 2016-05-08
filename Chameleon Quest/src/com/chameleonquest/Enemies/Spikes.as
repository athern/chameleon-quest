package com.chameleonquest.Enemies 
{
	import org.flixel.*;
	
	public class Spikes extends Enemy
	{
		[Embed(source = "../../../../assets/spike.png")]public var spikeImg:Class;
		
		public function Spikes(Xindex:int, Yindex:int) 
		{
			super(16*Xindex, 16*Yindex+8);
			loadGraphic(spikeImg, true, true, 128, 64);
			scale.x = 0.125;
			scale.y = 0.125;
			width = 16;  
			offset.x = 56;
			height = 8;
			offset.y = 28;
			power = 2;
			immovable = true;
		}
		
		public static function addSpikeRow(leftX:int, Y:int, count:int, group:FlxGroup):void
		{
			while (count > 0)
			{
				count--;
				group.add(new Spikes(leftX + count, Y));
				
			}
		}
		
		override public function hurt(damage:Number):void 
		{
		}
	}

}