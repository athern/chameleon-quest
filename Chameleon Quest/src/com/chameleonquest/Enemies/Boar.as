package com.chameleonquest.Enemies 
{
	import org.flixel.FlxSprite;

	public class Boar extends HorizontallyPatrollingEnemy
	{
		[Embed(source = "../../../../assets/boar.png")]public var greenSnake:Class;
		
		protected static const GRAVITY:int = 800;
		
		
		public function Boar(MinX:Number, MaxX:Number, Y:Number, startLoc:uint=0) 
		{
			super(MinX, MaxX, Y + 2, 50, startLoc);
			this.loadSprites();
			acceleration.y = GRAVITY;
			addAnimation("idle", [0, 1, 2], 3, true);
			addAnimation("charge", [2, 3], 5, true);
			addAnimation("death", [0], 1, false);
			width = 32;  
			height = 24;
			//offset.y = 6;
			play("charge");
		}
		
		public function loadSprites():void
		{
			loadGraphic(greenSnake, true, true, 32, 24);
		}
		
		public override function update():void
		{
			super.update();
		}
		
	}

}