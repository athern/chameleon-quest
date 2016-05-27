package com.chameleonquest.Enemies 
{

	public class HorizontallyPatrollingEnemy extends Enemy
	{
		
		protected var minX:Number;
		protected var maxX:Number;
		public var speed:int;
		
		protected var hittingWall:int;
		
		public function HorizontallyPatrollingEnemy(MinX:Number, MaxX:Number, Y:Number, s:int, startLoc:uint = 0) 
		{
			var startX:Number;
			if (startLoc == LEFT)
			{
				startX = MinX;
			}
			else if (startLoc == RIGHT)
			{
				startX = MaxX;
			}
			else
			{
				startX = (MinX + MaxX) / 2;
			}
			super(startX, Y);
			this.minX = MinX;
			this.maxX = MaxX;
			health = 1;
			power = 2;
			
			this.facing = LEFT;
			velocity.x = -s;
			speed = s;
		}
		
		public override function update():void
		{
			if (angle != 180)
			{
				if (Math.abs(velocity.x) < speed)
				{
					velocity.x = facing == LEFT ? -speed : speed;
				}
			
				if ((this.x <= this.minX) || (facing == LEFT && hittingWall >= 10))
				{
					this.facing = RIGHT;
					velocity.x = speed;
				}
				else if ((this.x >= this.maxX) || (facing == RIGHT && hittingWall >= 10))
				{
					this.facing = LEFT;
					velocity.x = -speed;
				}
				
				if ((facing == LEFT && isTouching(LEFT)) || (facing == RIGHT && isTouching(RIGHT)))
				{
					hittingWall++;
				}
				else
				{
					hittingWall = 0;
				}
			}
			else
			{
				velocity.x = 0;
			}
			
			super.update();
		}
		
	}

}