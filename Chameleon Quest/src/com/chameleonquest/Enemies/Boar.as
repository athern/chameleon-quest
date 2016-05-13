package com.chameleonquest.Enemies 
{
	import com.chameleonquest.PlayState;
	import org.flixel.*;

	public class Boar extends HorizontallyPatrollingEnemy
	{
		[Embed(source = "../../../../assets/boar.png")]public var img:Class;
		
		protected static const GRAVITY:int = 800;
		protected static const CHARGE_DELAY:Number = 2;
		
		private var cooldown:Number;
		private var isCharging:Boolean;
		
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
			
			
			cooldown = CHARGE_DELAY;
			isCharging = false;
		}
		
		public function loadSprites():void
		{
			loadGraphic(img, true, true, 32, 24);
		}
		
		public override function update():void
		{
			var currState:PlayState = FlxG.state as PlayState;
			var player:FlxSprite = currState.player;
			
			cooldown -= FlxG.elapsed;
			if (cooldown < 0 && !isCharging && player.y < this.y + 64 && player.y > this.y - 64 && 
			((player.x > this.x && this.facing == FlxObject.RIGHT) || 
			(player.x < this.x && this.facing == FlxObject.LEFT))) {
				play("charge");
				speed = 150;
				isCharging = true;
			}
			
			if (isCharging) {
				if (isTouching(RIGHT) || isTouching(LEFT)) {
					play("idle");
					isCharging = false;
					cooldown = CHARGE_DELAY;
					speed = 50;
				}
			}
			super.update();
			
			
		}
		
	}

}