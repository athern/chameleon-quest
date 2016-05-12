package com.chameleonquest.Enemies 
{
	import org.flixel.FlxSprite;

	public class Snake extends HorizontallyPatrollingEnemy
	{
		[Embed(source = "../../../../assets/greensnake-2.png")]public var greenSnake:Class;
		
		protected static const GRAVITY:int = 800;
		
		
		public function Snake(MinX:Number, MaxX:Number, Y:Number, startLoc:uint=0) 
		{
			super(MinX, MaxX, Y + 2, 50, startLoc);
			this.loadSprites();
			acceleration.y = GRAVITY;
			addAnimation("idle", [0, 1, 2, 3], 3, true);
			addAnimation("death", [1], 1, false);
			width = 32;  
			height = 30;
			//offset.y = 6;
			play("idle");
		}
		
		public function loadSprites():void
		{
			loadGraphic(greenSnake, true, true, 32, 30);
		}
		
		public override function update():void
		{
			super.update();
		}
		
	}

}