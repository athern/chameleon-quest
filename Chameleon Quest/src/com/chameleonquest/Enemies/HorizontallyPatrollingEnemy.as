package com.chameleonquest.Enemies 
{

	public class HorizontallyPatrollingEnemy extends Enemy
	{
		
		protected var minX:Number;
		protected var maxX:Number;
		protected var speed:int;
		
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
			if (velocity.x == 0)
			{
				if (facing == LEFT)
				{
					velocity.x = speed;
					facing = RIGHT;
				}
				else
				{
					velocity.x = -speed;
					facing = LEFT;
				}
			}
			if (Math.abs(velocity.x) < speed)
			{
					velocity.x = facing == LEFT ? -speed : speed;
			}
			
			if (this.x <= this.minX)
			{
				this.facing = RIGHT;
				velocity.x = speed;
			}
			else if (this.x >= this.maxX)
			{
				this.facing = LEFT;
				velocity.x = -speed;
			}
			
			super.update();
		}
		
	}

}