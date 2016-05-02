package com.chameleonquest.Projectiles 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Nicole Atherly
	 */
	public class Projectile extends FlxSprite 
	{		
		// Returns the amount of damage this projectile does to the target
		// Meant to be overridden
		public function getDamage(Target:FlxSprite):int { return 0; }
		
		override public function update():void
		{
			if (!this.alive && this.finished)
			{
				this.exists = false;
			}
			else
			{
				if (this.isTouching(ANY))
				{
					this.kill();
				}
				
				super.update();
			}
		}
		
		// Sets the projectile to x,y moving in velocity x,y direction
		public function shoot(X:int, Y:int, VelocityX:int, VelocityY:int):void
		{
			super.reset(X, Y);
			this.solid = true;
			this.velocity.x = VelocityX;
			this.velocity.y = VelocityY;
			this.facing = VelocityX >= 0 ? RIGHT : LEFT;
		}
		
	}
	
}