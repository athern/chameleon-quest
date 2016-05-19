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
		
		public var lifted:Boolean;
		
		protected var startY:int;
		protected var startX:int;
		
		protected var countdown:int;
		
		protected var speed:int;
		
		public function StoneGate(Xindex:int, Yfloorindex:int, dropclock:int=-1, droptime:int=480, type:uint=GREY, r:int = 0) 
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
		}
		
		public static function lift(gate:StoneGate):void
		{
			gate.lifted = true;
			gate.countdown = gate.clock;
		}
		
		public static function gradualLift(gate:StoneGate):void
		{
			if (gate.y > gate.startY - 48 && gate.angle == 0)
			{
				gate.y--;
				if (gate.y <= gate.startY - 48)
				{
					gate.lifted = true;
				}
			}
			if (gate.x > gate.startX - 48 && gate.angle == 270)
			{
				gate.x--;
				if (gate.x <= gate.startX - 48)
				{
					gate.lifted = true;
				}
			}
			if (gate.x < gate.startX + 48 && gate.angle == 90)
			{
				gate.x++;
				if (gate.x >= gate.startX + 48)
				{
					gate.lifted = true;
				}
			}
			//gate.lifted = true;
			gate.countdown = gate.clock;
		}
		
		override public function update():void
		{
			
			if (lifted == true && y > startY - 48 && angle == 0)
			{
				y -= 48/speed*4;
			}
			else if (lifted == true && x > startX - 48 && angle == 270)
			{
				x -= 48 / speed * 4;
			}
			else if (lifted == true && x < startX + 48 && angle == 90)
			{
				x += 48 / speed * 4;
			}
			else if (lifted == true && countdown > 0)
			{
				countdown--;
			}
			else if (lifted == true && countdown == 0)
			{
				lifted = false;
			}
			else if (y < startY && lifted == false && angle == 0)
			{
				y += 48/speed;
			}
			else if (x < startX && !lifted && angle == 270)
			{
				x += 48 / speed;
			}
			else if (x > startX && !lifted && angle == 90)
			{
				x -= 48 / speed;
			}
			
			super.update();
		}
		
		public static function drop(gate:StoneGate):void
		{
			gate.countdown = 0;
		}
		
		public function get isLifted():Boolean
		{
			return this.lifted;
		}
	}

}