package com.chameleonquest.Projectiles 
{
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
			height = 16;
			offset.x = 8;
			offset.y = 8;
			this.exists = false;
		}
		
		override public function getDamage(Target:FlxSprite):int
		{
			return 1; // todo
		}
	}

}