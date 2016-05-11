package com.chameleonquest.interactiveObj 
{
	import org.flixel.*;
	import com.chameleonquest.Projectiles.*;
	
	

	public class InteractiveObj extends FlxSprite
	{
		
		protected var minX:Number;
		protected var maxX:Number;
		protected var speed:int;
	
		protected var patrolling:Boolean;
		
		public function InteractiveObj(X:int, Y:int) 
		{
			super(X, Y);
		}
		
		public function hit(bullet:Projectile):void {
			// placeholder for override
		}
		
		override public function update():void {
			if (this.patrolling == true)
			{
				if (this.x <= this.minX || (velocity.x < 0 && this.isTouching(LEFT)))
				{
					this.facing = RIGHT;
					velocity.x = speed;
				}
				else if (this.x >= this.maxX || (velocity.x > 0 && this.isTouching(RIGHT)) || velocity.x == 0)
				{
					this.facing = LEFT;
					velocity.x = -speed;
				}
			}
			super.update();
		}
		
		public function patrol(min: int, max:int, s:int):void
		{
			minX = min;
			maxX = max;
			speed = s;
			patrolling = true;
		}
		
		public static function stopOrStart(block:InteractiveObj):void
		{
			if (block.patrolling == true)
			{
				block.patrolling = false;
				block.velocity.x = 0;
			}
			else
			{
				block.patrolling = true;
				if (block.facing == LEFT)
				{
					block.velocity.x = -block.speed;
				}
				else
				{
					block.velocity.x = block.speed;
				}
			}
		}
		
		public static function rotate(obj:InteractiveObj):void
		{
			obj.angle = (obj.angle + 90) % 360;
		}
		
	}

}