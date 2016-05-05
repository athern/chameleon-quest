package com.chameleonquest.Enemies 
{

	public class HorizontallyPatrollingEnemy extends Enemy
	{
		
		protected var minX:Number;
		protected var maxX:Number;
		protected var speed:int=50;
		
		public function HorizontallyPatrollingEnemy(MinX:Number, MaxX:Number, Y:Number) 
		{
			super((MaxX + MinX) / 2, Y);
			this.minX = MinX;
			this.maxX = MaxX;
			health = 1;
			power = 2;
            maxVelocity.x = speed;
			
			this.facing = LEFT;
			velocity.x = -speed;
		}
		
		public override function update():void
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
			
			super.update();
		}
		
	}

}