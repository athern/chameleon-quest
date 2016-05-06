package com.chameleonquest.interactiveObj 
{
	import org.flixel.*;
	import com.chameleonquest.Projectiles.*;

	public class InteractiveObj extends FlxSprite
	{
		
		public function InteractiveObj(X:int, Y:int) 
		{
			super(X, Y);
		}
		
		public function hit(bullet:Projectile):void {
			// placeholder for override
		}
		
		override public function update():void {
			super.update();
		}
		
	}

}