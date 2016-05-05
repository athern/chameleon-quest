package com.chameleonquest.Enemies 
{
	import org.flixel.FlxSprite;

	public class Snake extends HorizontallyPatrollingEnemy
	{
		[Embed(source = "../../../../assets/greensnake.png")]public var greenSnake:Class;
		
		protected static const GRAVITY:int = 800;
		protected static const DEATH_ANIMATION_LENGTH:int = 30;
		
		protected var dying:int = -1;
		
		
		public function Snake(MinX:Number, MaxX:Number, Y:Number) 
		{
			speed = 60;
			super(MinX, MaxX, Y);
			this.loadSprites();
			acceleration.y = GRAVITY;
			addAnimation("idle", [0, 2], 3, true);
			addAnimation("death", [1], 1, false);
			width = 32;  
			height = 10;
			offset.y = 6;
		}
		
		public function loadSprites():void
		{
			loadGraphic(greenSnake, true, true, 32, 16);
			addAnimation("idle", [0, 2], 3, true);
			addAnimation("death", [1], 1, false);
			width = 32;  
			height = 10;
			offset.y = 6;
		}
		
		public override function update():void
		{
			if (dying > 0)
			{
				dying--;
			}
			if (dying == 0)
			{
				this.kill();
			}
			if (this.health == 0)
			{
				play("death");
				health = 1;
				dying = DEATH_ANIMATION_LENGTH;
				velocity.x = 0;
				this.flicker(1);
			}
			else
			{
				play("idle");
			}
			super.update();
		}
		
	}

}