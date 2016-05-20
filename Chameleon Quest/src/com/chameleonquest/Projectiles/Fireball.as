package com.chameleonquest.Projectiles 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	public class Fireball extends Projectile
	{
		[Embed(source = "../../../../assets/fireball.png")] protected var fireSprite:Class;
		private var startingX:Number;
		private var maxDistance:Number;
		
		public function Fireball(maxDistance:Number) 
		{
			super();
			loadGraphic(fireSprite, true, true, 32, 32);
			addAnimation("shooting", [0, 1, 2], 4, true);
			play("shooting");
			scale.x = .5;
			scale.y = .5;
			width = 16;
			height = 12;
			offset.x = 8;
			offset.y = 10;
			this.exists = false;
			
			this.maxDistance = maxDistance;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (this.x > (this.startingX + this.maxDistance))
			{
				this.kill();
			}
		}
		
		override public function shoot(X:int, Y:int, VelocityX:int, VelocityY:int):void 
		{
			super.shoot(X, Y, VelocityX, VelocityY);
			
			this.startingX = X;
		}
		
		override public function getDamage(Target:FlxSprite):Number
		{
			return 2;
		}
	}

}