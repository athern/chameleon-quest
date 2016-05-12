package com.chameleonquest.Enemies 
{

	public class HorizontallyPatrollingEnemy extends Enemy
	{
		
		protected var minX:Number;
		protected var maxX:Number;
		protected var speed:int;
		
		public function HorizontallyPatrollingEnemy(MinX:Number, MaxX:Number, Y:Number, s:int, startLoc:uint = 0) 
		{
			var startX:int;
			if (startLoc == LEFT)
			{
				startX = minX;
			}
			else if (startLoc == RIGHT)
			{
				startX = maxX;
			}
			else
			{
				startX = minX + MaxX / 2;
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
				if (Math.random() < .5)
				{
					this.facing = LEFT;
					velocity.x = -speed;
				}
				else
				{
					this.facing = RIGHT;
					velocity.x = speed;
				}
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