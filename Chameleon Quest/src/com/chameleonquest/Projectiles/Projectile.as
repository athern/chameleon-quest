package com.chameleonquest.Projectiles 
{
	import org.flixel.*;

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
				if (this.isTouching(ANY) || 
					this.x < (FlxG.camera.bounds.left  - this.width)|| 
					this.x > FlxG.camera.bounds.right || 
					this.y < (FlxG.camera.bounds.top - this.height) || 
					this.y > FlxG.camera.bounds.bottom)
				{
					this.kill();
				}
				
				if (Math.abs(velocity.x) >= Math.abs(velocity.y))
				{
					this.facing = velocity.x >= 0 ? RIGHT : LEFT;
				}
				else
				{
					this.facing = velocity.y >= 0 ? DOWN : UP;
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
			if (Math.abs(velocity.x) >= Math.abs(velocity.y))
			{
				this.facing = VelocityX >= 0 ? RIGHT : LEFT;
			}
			else
			{
				this.facing = VelocityY >= 0 ? DOWN : UP;
			}
		}
		
	}
	
}