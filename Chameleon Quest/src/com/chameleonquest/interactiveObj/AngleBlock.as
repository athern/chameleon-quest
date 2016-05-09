package com.chameleonquest.interactiveObj 
{
	import com.chameleonquest.Projectiles.Projectile;
	import com.chameleonquest.Projectiles.Rock;
	import org.flixel.*;
	
	public class AngleBlock extends InteractiveObj
	{
		[Embed(source="../../../../assets/angleblock.png")]
		protected var img:Class;
		
		protected var minX:Number;
		protected var maxX:Number;
		protected var speed:int;
		
		protected var patrolling:Boolean;
		
		public function AngleBlock(Xindex:int, Yindex:int, r:int) 
		{
			super(Xindex * 16 + 4, Yindex * 16 + 4);
			loadGraphic(img);
			angle = r;
			width = 8;
			height = 8;
			offset.x = 4;
			offset.y = 4;
			immovable = true;
			speed = 0;
		}
		
		override public function hit(bullet:Projectile):void
		{
			if (bullet is Rock)
			{
				if (angle == 90 && bullet.facing == LEFT)
				{
					bullet.shoot(x-2, y + 5, 0, 200);
				}
				if (angle == 0 && bullet.facing == LEFT)
				{
					bullet.shoot(x - 2, y - 5, 0, -200);
				}
				if (angle == 180 && bullet.facing == RIGHT)
				{
					bullet.shoot(x - 2, y + 5, 0, 200);
				}
				if (angle == 270 && bullet.facing == RIGHT)
				{
					bullet.shoot(x - 2, y - 5, 0, -200);
				}
				if (angle == 0 && bullet.facing == DOWN)
				{
					bullet.shoot(x + 5, y - 2, 200, 0);
				}
				if (angle == 90 && bullet.facing == UP)
				{
					bullet.shoot(x + 5, y - 2, 200, 0);
				}
				if (angle == 180 && bullet.facing == UP)
				{
					bullet.shoot(x - 5, y - 2, -200, 0);
				}
				if (angle == 270 && bullet.facing == DOWN)
				{
					bullet.shoot(x - 5, y - 2, -200, 0);
				}
			}
		}
		
		public static function rotate(block:AngleBlock):void
		{
			block.angle = (block.angle + 90) % 360;
		}
		
		public override function update():void
		{
			if (this.patrolling == true)
			{
				if (this.x <= this.minX || (velocity.x < 0 && this.isTouching(LEFT)))
				{
					this.facing = RIGHT;
					velocity.x = speed;
				}
				else if (this.x >= this.maxX || (velocity.x > 0 && this.isTouching(RIGHT)))
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
		
		public static function stopOrStart(block:AngleBlock):void
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
		
	}

}