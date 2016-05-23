package com.chameleonquest.Objects 
{
	import org.flixel.*;
	
	public class Boulder extends FlxSprite
	{
		[Embed(source = "../../../../assets/boulder.png")]public var img:Class;
		public function Boulder(X:int, Y:int) 
		{
			super(X, Y, img);
			acceleration.y = 600;
			height = 48;
			width = 48;
			offset.x = 8;
			offset.y = 8;
			facing = LEFT;
		}
		
		override public function update():void {
			super.update();
			if (facing == RIGHT)
			{
				angle += 10;
			}
			if (facing == LEFT)
			{
				angle -= 10;
			}
			if (isTouching(FLOOR) && Math.abs(velocity.x) < 110)
			{
				if (facing == LEFT)
				{
					velocity.x = -110;
				}
				if (facing == RIGHT)
				{
					velocity.x = 110;
				}
			}
			if (isTouching(LEFT))
			{
				facing = RIGHT;
			}
			if (isTouching(RIGHT))
			{
				facing = LEFT;
			}
		}
		
	}

}