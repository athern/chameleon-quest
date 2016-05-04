package com.chameleonquest.Projectiles 
{
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.*;

	public class Poison extends Projectile
	{
		
		public function Poison() 
		{
			super();
			this.exists = false;
		}
		
		override public function getDamage(Target:FlxSprite):int
		{
			return 2;
		}
	}

}