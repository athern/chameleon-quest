package com.chameleonquest.Projectiles 
{
	import org.flixel.FlxSprite;
	public class Acorn extends Projectile
	{
		[Embed(source = "../../../../assets/accorn.png")] protected var img:Class;
		
		protected static const GRAVITY:int = 800;
		public function Acorn() 
		{
			super();
			loadGraphic(img, false, true);
			this.exists = false;
			
			scale.x = .4;
			scale.y = .4;
			height = 13;
			width = 13;
			offset.x = 10;
			offset.y = 10;
			
			acceleration.y = GRAVITY;
		}
		
		override public function getDamage(Target:FlxSprite):Number
		{
			return 0;
		}
		
	}

}