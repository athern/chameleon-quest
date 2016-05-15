package com.chameleonquest.Projectiles 
{
	import org.flixel.FlxSprite;
	public class Gust extends Projectile
	{
		[Embed(source = "../../../../assets/whirlwind.png")]public var whirlwind:Class;
		
		public function Gust() 
		{
			super();
            loadGraphic(whirlwind, true, true, 64, 64);
			scale.x = 0.25;
			scale.y = 0.25;
			width = 16;
			height = 16;
			offset.x = 24;
			offset.y = 24;
			addAnimation("whirl", [0, 1, 2], 7);
			play("whirl");
			this.exists = false;
		}
		
		override public function getDamage(Target:FlxSprite):Number
		{
			return 1;
		}
	}

}