package com.chameleonquest.Objects 
{
	import org.flixel.*;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	
	public class StoneGate extends FlxSprite
	{
		
		static public const RED:uint = 0x00;
		static public const BLUE:uint = 0x01;
		static public const GREEN:uint = 0x02;
		static public const YELLOW:uint = 0x03;
		static public const GREY:uint = 0x04;
		
		[Embed(source = "../../../../assets/stonegate.png")]
		protected var img:Class;
		
		public var clock:int;
		
		public var state:int;
		
		protected var startY:int;
		protected var startX:int;
		
		public var countdown:int;
		
		protected var speed:int;
		
		public function StoneGate(Xindex:int, Yfloorindex:int, dropclock:int=-1, droptime:int=240, type:uint=GREY, r:int = 0) 
		{
			if (r == 0)
			{
				startY = Yfloorindex * 16 - 48;
				startX = Xindex * 16;
			}
			if (r == 270)
			{
				startY = Yfloorindex * 16 - 24;
				startX = Xindex * 16 - 40;
			}
			if (r == 90)
			{
				startY = Yfloorindex * 16 - 8;
				startX = Xindex * 16 + 24;
			}
			super(startX, startY);
			clock = dropclock;
			immovable = true;
			speed = droptime;
			angle = r;
			state = 0;
			if (type == RED)
			{
				loadGraphic(img, false, false, 32, 48, true);
				pixels.colorTransform(new Rectangle(0, 0, 32, 48), new ColorTransform(1, .5, .5));
				dirty = true;
			}
			if (type == BLUE)
			{
				loadGraphic(img, false, false, 32, 48, true);
				pixels.colorTransform(new Rectangle(0, 0, 32, 48), new ColorTransform(.5, .5, 1));
				dirty = true;
			}
			if (type == GREEN)
			{
				loadGraphic(img, false, false, 32, 48, true);
				pixels.colorTransform(new Rectangle(0, 0, 32, 48), new ColorTransform(.5, 1, .5));
				dirty = true;
			}
			if (type == YELLOW)
			{
				loadGraphic(img, false, false, 32, 48, true);
				pixels.colorTransform(new Rectangle(0, 0, 32, 48), new ColorTransform(1.5, 1.5, 0));
				dirty = true;
			}
			if (type == GREY)
			{
				loadGraphic(img, false, false, 32, 48, true);
			}
			if (angle == 90 || angle == 270)
			{
				width = 48;
				height = 32;
				offset.x -= 8;
				offset.y += 8;
				x -= 8;
				y += 8;
			}
		}
		
		public static function lift(gate:StoneGate):void
		{
			gate.state = 1;
			gate.countdown = gate.clock;
		}
		
		public static function gradualLift(gate:StoneGate):void
		{
			if (gate.y > gate.startY - 48 && gate.angle == 0)
			{
				gate.y -= 2;
				if (gate.y <= gate.startY - 48)
				{
					gate.state = 2;
				}
			}
			if (gate.x - gate.offset.x > gate.startX - 48 && gate.angle == 270)
			{
				gate.x -= 2;
				if (gate.x - gate.offset.x <= gate.startX - 48)
				{
					gate.state = 2;
				}
			}
			if (gate.x - gate.offset.x < gate.startX + 48 && gate.angle == 90)
			{
				gate.x += 2;
				if (gate.x - gate.offset.x >= gate.startX + 48)
				{
					gate.state = 2;
				}
			}
			gate.countdown = gate.clock;
		}
		
		override public function update():void
		{
			super.update();
			if (state == 1 && y > startY - 48 && angle == 0)
			{
				y -= 48/speed*4;
			}
			else if (state == 1 && x - offset.x > startX - 48 && angle == 270)
			{
				x -= 48 / speed * 4;
			}
			else if (state == 1 && x - offset.x < startX + 48 && angle == 90)
			{
				x += 48 / speed * 4;
			}
			else if (state == 1)
			{
				state = 2;
			}
			else if (state == 2 && countdown > 0)
			{
				countdown--;
			}
			else if (state == 2 && countdown == 0)
			{
				state = 3;
			}
			else if (y < startY && state == 3 && angle == 0)
			{
				y += 48/speed;
			}
			else if (x - offset.x < startX && state == 3 && angle == 270)
			{
				x += 48 / speed;
			}
			else if (x - offset.x > startX && state == 3 && angle == 90)
			{
				x -= 48 / speed;
			}
			else if (state == 3)
			{
				state = 0;
			}
			
		}
		
		public static function drop(gate:StoneGate):void
		{
			gate.countdown = 0;
		}
		
		public function get isLifted():Boolean
		{
			return state == 2;
		}
		
		public function isFalling():Boolean
		{
			return state == 3;
		}
	}

}