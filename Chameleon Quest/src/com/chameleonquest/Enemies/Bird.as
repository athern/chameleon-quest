package com.chameleonquest.Enemies 
{
	public class Bird extends HorizontallyPatrollingEnemy
	{
		[Embed(source = "../../../../assets/bird.png")]public var bird:Class;
		
		public function Bird(MinX:Number, MaxX:Number, Y:Number) 
		{
			super(MinX, MaxX, Y, 80);
			loadGraphic(bird, true, true, 32, 21);
			addAnimation("idle", [0, 1, 2, 3], 4, true);
			addAnimation("death", [0]);
			play("idle");
			width = 32;
			height = 21;
			immovable = true;
		}
		
		public override function update():void
		{
			super.update();
		}
	}

}