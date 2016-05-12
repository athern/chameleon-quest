package com.chameleonquest.Projectiles 
{
	import com.chameleonquest.Enemies.Turtle;
	import org.flixel.FlxSprite;
	public class WaterStream extends Projectile
	{
		[Embed(source = "../../../../assets/water-stream-head.png")]public var waterStreamHead:Class;
		
		public function WaterStream() 
		{
			super();
			loadGraphic(waterStreamHead, true, true, 32, 32);
			addAnimation("shooting", [0], 4, true);
			play("shooting");
			scale.x = .5;
			scale.y = .5;
			width = 16;
			height = 8;
			offset.x = 8;
			offset.y = 12;
			this.exists = false;
		}
		
		override public function getDamage(Target:FlxSprite):Number
		{
			if (Target is Turtle)
			{
				return 0;
			}
			return .1;
		}
	}

}