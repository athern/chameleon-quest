package com.chameleonquest.Projectiles 
{
	import org.flixel.FlxSprite;
	public class Fireball extends Projectile
	{
		[Embed(source = "../../../../assets/fireball.png")] protected var fireSprite:Class;
		
		public function Fireball() 
		{
			super();
			loadGraphic(fireSprite, true, true, 32, 32);
			addAnimation("shooting", [0, 1, 2], 4, true);
			play("shooting");
			scale.x = .5;
			scale.y = .5;
			width = 16;
			height = 16;
			offset.x = 8;
			offset.y = 8;
			this.exists = false;
		}
		
		override public function getDamage(Target:FlxSprite):int
		{
			return 2;
		}
	}

}