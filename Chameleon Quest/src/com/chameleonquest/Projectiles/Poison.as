package com.chameleonquest.Projectiles 
{
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.*;

	public class Poison extends Projectile
	{
		[Embed(source = "../../../../assets/venom.png")]
		protected var img:Class;
		public function Poison() 
		{
			super();
			loadGraphic(img, true, true, 32, 16);
			addAnimation("shooting", [0, 1, 2], 4, true);
			play("shooting");
			scale.x = .5;
			scale.y = .5;
			width = 16;
			height = 8;
			offset.x = 8;
			offset.y = 4;
			this.exists = false;
		}
		
		override public function getDamage(Target:FlxSprite):Number
		{
			return 2;
		}
	}

}