package com.chameleonquest.Enemies 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Nicole Atherly
	 */
	public class Snake extends FlxSprite
	{
		[Embed(source = "../../../../assets/spritesheet_enemies.png")]public var greenSnake:Class;
		
		protected static const GRAVITY:int = 800;
		protected static const RUN_SPEED:int = 60;
		
		public function Snake(X:Number, Y:Number) 
		{
			super(X, Y);
			
			this.scale.x = 0.3;
			this.scale.y = 0.3;
			loadGraphic(greenSnake, true, true, 128, 138);
			addAnimation("idle", [16], 1, false);
			addAnimation("death", [24], 1, false);
			width = 40;  
			offset.x = 45;
			height = 15;
			offset.y = 68;
			acceleration.y = GRAVITY;
			maxVelocity.x = RUN_SPEED;
			drag.x = RUN_SPEED * 16;
			drag.y = RUN_SPEED * 16;
			health = 1;
		}
		
		public override function update():void
		{
			if (this.health == 0)
			{
				play("death");
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