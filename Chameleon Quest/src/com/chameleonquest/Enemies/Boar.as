package com.chameleonquest.Enemies 
{
	import com.chameleonquest.PlayState;
	import org.flixel.*;

	public class Boar extends HorizontallyPatrollingEnemy
	{
		[Embed(source = "../../../../assets/boar.png")]public var greenSnake:Class;
		
		protected static const GRAVITY:int = 800;
		protected static const CHARGE_DELAY:Number = 2;
		
		private var cooldown:Number;
		private var isCharging:Boolean;
		
		private var player:FlxSprite;
		
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
			play("idle");
			
			var currState:PlayState = FlxG.state as PlayState;
			player = currState.player;
			cooldown = CHARGE_DELAY;
			isCharging = false;
		}
		
		public function loadSprites():void
		{
			loadGraphic(greenSnake, true, true, 32, 24);
		}
		
		public override function update():void
		{
			if ((player.x < this.x + 32 && player.x > this.x && this.facing == FlxObject.RIGHT) || 
			(player.x > this.x - 32 && player.x < this.x && this.facing == FlxObject.LEFT)) {
				play("charge");
				velocity.x = 0;
				speed = 0;
				isCharging = true;
			}
			
			if (isCharging) {
				cooldown -= FlxG.elapsed;
				if (cooldown < 0) {
					play("idle");
					isCharging = false;
					cooldown = CHARGE_DELAY;
					velocity.x = -50;
					speed = 50;
				}
			}
			super.update();
		}
		
	}

}