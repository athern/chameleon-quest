package com.chameleonquest.Enemies 
{
	public class Turtle extends Enemy
	{
		[Embed(source = "../../../../assets/turtle.png")]public var simpleTurtle:Class;
		
		protected static const GRAVITY:int = 800;
		
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
			power = 2;
						
			this.facing = RIGHT;
			
			acceleration.y = GRAVITY;
		}
	}

}