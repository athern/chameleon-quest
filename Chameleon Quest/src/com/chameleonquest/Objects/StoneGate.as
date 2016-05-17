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
		
		protected var clock:int;
		
		protected var lifted:Boolean;
		
		protected var startY:int;
		
		protected var countdown:int;
		
		protected var speed:int;
		
		public function StoneGate(Xindex:int, Yfloorindex:int, dropclock:int=-1, droptime:int=480, type:uint=GREY) 
		{
			super(Xindex * 16, Yfloorindex * 16 - 48);
			clock = dropclock;
			startY = Yfloorindex * 16 - 48;
			immovable = true;
			speed = droptime;
			
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
			if (gate.y > gate.startY - 48)
			{
				gate.y -= .5;
			}
			gate.lifted = true;
			gate.countdown = gate.clock;
		}
		
		override public function update():void
		{
			
			if (lifted == true && y > startY - 48)
			{
				y -= 48/speed*4;
			}
			else if (lifted == true && countdown > 0)
			{
				countdown--;
			}
			else if (lifted == true && countdown == 0)
			{
				lifted = false;
			}
			else if (y < startY && lifted == false)
			{
				y += 48/speed;
			}
			
			super.update();
		}
		
		public static function drop(gate:StoneGate):void
		{
			gate.countdown = 0;
		}
		
	}

}