package com.chameleonquest.Enemies 
{
	import org.flixel.*;
	
	public class Spikes extends Enemy
	{
		[Embed(source = "../../../../assets/spike.png")]public var spikeImg:Class;
		
		public function Spikes(Xindex:int, Yindex:int, damage:int=2) 
		{
			super(16 * Xindex, 16 * Yindex + 8);
			if (damage == 2)
			{
				loadGraphic(spikeImg, true, true, 16, 8);
			}
			power = damage;
			immovable = true;
		}
		
		public static function addSpikeRow(leftX:int, Y:int, count:int, group:FlxGroup, damage:int=2):void
		{
			while (count > 0)
			{
				count--;
				group.add(new Spikes(leftX + count, Y, damage));
			}
		}
		
		override public function hurt(damage:Number):void 
		{
		}
	}

}