package com.chameleonquest.Objects 
{
	import org.flixel.*;

	public class Fanfare extends FlxGroup
	{
		[Embed(source = "../../../../assets/firework-blue.png")]public var blueImg:Class;
		[Embed(source = "../../../../assets/firework-green.png")]public var greenImg:Class;
		[Embed(source = "../../../../assets/firework-pink.png")]public var pinkImg:Class;
		[Embed(source = "../../../../assets/firework-purple.png")]public var purpleImg:Class;
		[Embed(source = "../../../../assets/firework-red.png")]public var redImg:Class;
		[Embed(source = "../../../../assets/firework-yellow.png")]public var yellowImg:Class;
		
		public var blue:Firework;
		public var green:Firework;
		public var pink:Firework;
		public var purple:Firework;
		public var red:Firework;
		public var yellow:Firework;
		
		public var fire:Array;
		public var currIdx:int;
		
		private var FR_DELAY:int = 10;
		
		public function Fanfare(XIdx:int, YIdx:int) 
		{
			super();
			
			purple = new Firework(XIdx + 1, YIdx + 5, purpleImg);
			pink = new Firework(XIdx + 3, YIdx + 3, pinkImg);
			red = new Firework(XIdx + 5, YIdx + 1, redImg);
			yellow = new Firework(XIdx + 7, YIdx + 1, yellowImg);
			green = new Firework(XIdx + 9, YIdx + 3, greenImg);
			blue = new Firework(XIdx + 11, YIdx + 5, blueImg);

			fire = [purple, pink, red, yellow, green, blue];
			currIdx = 0;
			
			var congrats:FlxText;
			congrats = new FlxText(XIdx * 16, (YIdx + 5) * 16, 14 * 16, "VICTORY");
			congrats.setFormat(null, 16, 0x000000, "center");
			this.add(congrats);
			
		}
		
		override public function update():void
		{
			super.update();
			if (currIdx < fire.length && FR_DELAY <= 0) {
				FR_DELAY = 10;
				this.add(fire[currIdx]);
				currIdx++;
			}
			FR_DELAY -= FlxG.elapsed;
		}
		
	}

}