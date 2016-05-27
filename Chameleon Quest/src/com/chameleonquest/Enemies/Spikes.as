package com.chameleonquest.Enemies 
{
	import org.flixel.*;
	
	public class Spikes extends Enemy
	{
		[Embed(source = "../../../../assets/spike.png")]public var spikeImg:Class;
		
		[Embed(source = "../../../../assets/obsidianspike.png")]public var OHKOspike:Class;
		
		public function Spikes(Xindex:int, Yindex:int, damage:int=2, r:int=0) 
		{
			super(16 * Xindex, 16 * Yindex);
			if (damage == 2)
			{
				loadGraphic(spikeImg);
			}
			if (damage == 6)
			{
				loadGraphic(OHKOspike);
			}
			power = damage;
			immovable = true;
			angle = r;
			if (angle == 0)
			{
				y += 8;
			}
			if (angle == 270)
			{
				x += 8;
			}
		}
		
		public static function addSpikeRow(leftX:int, Y:int, count:int, group:FlxGroup, damage:int=2, r:int=0):void
		{
			while (count > 0)
			{
				count--;
				group.add(new Spikes(leftX + count, Y, damage, r));
			}
		}
		
		override public function hurt(damage:Number):void 
		{
		}
	}

}