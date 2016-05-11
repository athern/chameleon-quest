package com.chameleonquest.Enemies 
{
	import org.flixel.*;

	public class Turtle extends Enemy
	{
		[Embed(source = "../../../../assets/turtle.png")]public var simpleTurtle:Class;
		
		protected static const GRAVITY:int = 800;
		protected var startX:int;
		
		public function Turtle(X:Number, Y:Number) 
		{
			super(X, Y);
			scale.x = 0.5;
			scale.y = 0.5;
			loadGraphic(simpleTurtle, true, true, 64, 36);
			addAnimation("idle", [0]);
			width = 32;
			height = 18;
			offset.x = 16;
			offset.y = 9;
			health = 1;
			power = 1;
			startX = X;
						
			this.facing = RIGHT;
			
			acceleration.y = 0;
		}
		
		public static function addTurtleStack(X:int, Y:int, count:int, group:FlxGroup):void
		{
			for (var i:int = 1; i <= count; i++) {
				group.add(new Turtle(X, Y - (count - i )* 18));
			}
		}
		
		override public function update():void
		{
			super.update();
			if (x != startX)
			{
				acceleration.y = GRAVITY;
			}
			else
			{
				acceleration.y = 0;
			}
			if (!isTouching(FLOOR))
			{
				y++;
			}
		}
	}

}