package com.chameleonquest.Enemies 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import org.flixel.*;
	
	public class Geyser extends Enemy
	{
		[Embed(source = "../../../../assets/geyser.png")]
		private var img:Class;
		
		public var chargetime:int;
		private var age:int;
		private var fadetime:int;
		public var speed:int;
		
		public var lastY:int;
		
		public var stream:Array;
		
		public static var streamCache:FlxGroup;
		public static var cache:FlxGroup;
		
		public var group:FlxGroup;
		
		public function Geyser(X:int, Y:int, t:int = 100, s:int = 2) 
		{
			super(X, Y);
			loadGraphic(img, true, false, 32, 32, false);
			addAnimation("shooting", [0, 1, 2], 12);
			play("shooting");
			chargetime = t;
			speed = s;
			exists = false;
			stream = new Array();
			stream.push(this);
			immovable = true;
		}
		
		override public function update():void
		{
			super.update();
			age++;
			if (y <= 48)
			{
				fadetime++;
			}
			else if (age >= chargetime)
			{
				y -= speed;
			}
			if (fadetime > 50)
			{
				y += 2*speed;
			}
			
			var delta:int = y - lastY;
			for (var i:int = 1; i < stream.length; i++)
			{
				stream[i].y += delta;
			}
			if (stream[stream.length - 1].y < FlxG.camera.bounds.bottom)
			{
				var nowVisible:GeyserSegment = Geyser.grabSegment();
				nowVisible.reset(x, stream[stream.length - 1].y + 32);
				stream.push(nowVisible);
				group.add(nowVisible);
			}
			if (y > FlxG.camera.bounds.bottom)
			{
				for (var k:int = 1; k < stream.length; k++)
				{
					(stream[k] as GeyserSegment).kill();
				}
				kill();
			}
			lastY = y;
		}
		
		public static function grabSegment():GeyserSegment
		{
			Geyser.initCache();
			var result:GeyserSegment = Geyser.streamCache.getFirstAvailable() as GeyserSegment;
			while (result == null)
			{
				Geyser.streamCache.add(new GeyserSegment( -32, -32));
				result = Geyser.streamCache.getFirstAvailable() as GeyserSegment;
			}
			return result;
		}
		
		public static function init(g:FlxGroup, X:int, Y:int, t:int=100, s:int=2):Geyser
		{
			Geyser.initCache();
			var result:Geyser = Geyser.cache.getFirstAvailable() as Geyser;
			while (result == null)
			{
				Geyser.cache.add(new Geyser(-32, -32));
				result = Geyser.cache.getFirstAvailable() as Geyser;
			}
			result.reset(X, Y);
			g.add(result);
			result.lastY = Y;
			result.group = g;
			result.chargetime = t;
			result.speed = s;
			for (var i:int = Y+32; i < FlxG.camera.bounds.bottom; i += 32) {
				var next:GeyserSegment = Geyser.grabSegment();
				next.reset(result.x, i);
				result.stream.push(next);
			}
			for (var j:int = 0; j < result.stream.length; j++) {
				g.add(result.stream[j]);
			}
			return result;
		}
		
		public static function initCache():void
		{
			if (Geyser.cache == null)
			{
				Geyser.cache = new FlxGroup();
				for (var a:int = 0; a < 10; a++)
				{
					Geyser.cache.add(new Geyser(-32, -32));
				}
			}
			if (Geyser.streamCache == null)
			{
				Geyser.streamCache = new FlxGroup();
				for (var b:int = 0; b < 200; b++)
				{
					Geyser.streamCache.add(new GeyserSegment( -32, -32));
				}
			}
		}
		
		override public function reset(X:Number, Y:Number):void
		{
			super.reset(X, Y);
			age = 0;
			fadetime = 0;
			stream = new Array();
			stream.push(this);
		}
		
	}

}