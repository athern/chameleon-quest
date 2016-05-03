package com.chameleonquest.Enemies 
{
	public class Bird extends Enemy
	{
		protected static const FLY_SPEED:int = 50;
		
		private var minX:Number;
		private var maxX:Number;
		
		public function Bird(MinX:Number, MaxX:Number, Y:Number) 
		{
			super((MaxX + MinX) / 2, Y);
			this.minX = MinX;
			this.maxX = MaxX;
			health = 1;
			power = 2;
            maxVelocity.x = FLY_SPEED;
            maxVelocity.y = 0;
			
			this.facing = LEFT;
			velocity.x = -FLY_SPEED;
		}
		
		public override function update():void
		{
			if (this.x < this.minX || (velocity.x < 0 && this.isTouching(LEFT)))
			{
				this.facing = RIGHT;
				velocity.x = FLY_SPEED;
			}
			else if (this.x > this.maxX || (velocity.x > 0 && this.isTouching(RIGHT)))
			{
				this.facing = LEFT;
				velocity.x = -FLY_SPEED;
			}
			
			super.update();
		}
	}

}