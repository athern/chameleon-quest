package com.chameleonquest.Objects 
{
	import org.flixel.*;
	
	public class StoneGate extends FlxSprite
	{
		
		[Embed(source = "../../../../assets/stonegate.png")]
		protected var img:Class;
		
		protected var clock:int;
		
		protected var lifted:Boolean;
		
		protected var startY:int;
		
		protected var countdown:int;
		
		public function StoneGate(Xindex:int, Yfloorindex:int, dropclock:int=-1) 
		{
			super(Xindex * 16, Yfloorindex * 16 - 48, img);
			clock = dropclock;
			startY = Yfloorindex * 16 - 48;
			immovable = true;
		}
		
		public static function lift(gate:StoneGate):void
		{
			gate.lifted = true;
			gate.countdown = gate.clock;
		}
		
		override public function update():void
		{
			
			if (lifted == true && y > startY - 48)
			{
				y -= .4;
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
				y += .1;
			}
			
			super.update();
		}
		
	}

}