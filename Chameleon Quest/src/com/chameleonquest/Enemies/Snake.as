package com.chameleonquest.Enemies 
{
	import org.flixel.FlxSprite;

	public class Snake extends HorizontallyPatrollingEnemy
	{
		[Embed(source = "../../../../assets/greensnake.png")]public var greenSnake:Class;
		
		protected static const GRAVITY:int = 800;
		
		
		public function Snake(MinX:Number, MaxX:Number, Y:Number) 
		{
			super(MinX, MaxX, Y, 50);
			this.loadSprites();
			acceleration.y = GRAVITY;
			addAnimation("idle", [0, 2], 3, true);
			addAnimation("death", [1], 1, false);
			width = 32;  
			height = 10;
			offset.y = 6;
			play("idle");
		}
		
		public function loadSprites():void
		{
			loadGraphic(greenSnake, true, true, 32, 16);
		}
		
		public override function update():void
		{
			super.update();
		}
		
	}

}