package com.chameleonquest.Projectiles 
{
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;

	public class Poison extends Projectile
	{
		
		public function Poison(MapBounds:FlxRect) 
		{
			super();
			this.exists = false;
			this.mapBounds = MapBounds;
		}
		
		override public function getDamage(Target:FlxSprite):int
		{
			return 2;
		}
	}

}