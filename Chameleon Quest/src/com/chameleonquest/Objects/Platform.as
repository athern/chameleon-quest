package com.chameleonquest.Objects 
{
	import org.flixel.*;
	
	public class Platform extends FlxSprite
	{
		
		[Embed(source = "../../../../assets/Platform.png")]
		public var img:Class;
		
		[Embed(source = "../../../../assets/tallerplatform.png")]
		public var img2:Class;
		
		private var i:int = 0;
		private var points:Array;
		private var waittime:int;
		private var waitleft:int = -1;
		private var speed:int = 60;
		
		public function Platform(p:Array, s:int=60, height:int=1, w:int=30) 
		{
			super(p[0].x, p[0].y);
			if (height == 1)
			{
				loadGraphic(img);
			}
			if (height == 2)
			{
				loadGraphic(img2);
			}
			points = p;
			waittime = w;
			speed = s;
			immovable = true;
		}
		
		override public function update():void
		{
			super.update();
			if (points.length > 1)
			{
				velocity.x = 0;
				velocity.y = 0;
			}
			if (points[(i + 1) % points.length].x > points[i].x && points[(i + 1) % points.length].x > x)
			{
				x += speed/30;
			}
			else if (points[(i + 1) % points.length].x < points[i].x && points[(i + 1) % points.length].x < x)
			{
				x -= speed/30;
			}
			else if (points[(i + 1) % points.length].y > points[i].y && points[(i + 1) % points.length].y > y)
			{
				velocity.y = speed;
			}
			else if (points[(i + 1) % points.length].y < points[i].y && points[(i + 1) % points.length].y < y)
			{
				velocity.y = -speed;
			}
			else if (waitleft == -1)
			{
				waitleft = waittime;
			}
			else if (waitleft > 0)
			{
				waitleft--;
			}
			if (waitleft == 0)
			{
				waitleft = -1;
				i = (i + 1) % points.length;
			}
		}
		
	}

}