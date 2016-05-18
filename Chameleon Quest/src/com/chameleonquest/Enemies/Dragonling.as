package com.chameleonquest.Enemies 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.PlayState;
	import org.flixel.FlxG;
	public class Dragonling extends Enemy
	{
		protected static const GRAVITY:int =800;
		protected static const JUMP_SPEED:int = 200;
		protected static const SPEED:int = 50;
		protected static const MAX_JUMP_HOLD:int = 15;
		
		private const OFFSET:Number = 25;
		
		private var jumpPhase:int;
		
		public function Dragonling(X:int, Y:int) 
		{
			super(X, Y);
			// TODO: sprites
			
			health = 1;
		}
		
		override public function update():void 
		{
			super.update();
			
			var player:Chameleon = (FlxG.state as PlayState).player;
			this.velocity.x = player.x < this.x ? -SPEED : SPEED;
			this.facing == this.velocity.x < 0 ? LEFT : RIGHT;
			
			var pY:Number = player.y + player.height;
			var mY:Number = this.y + this.height;
			
 			if ((player.jumpPhase == 0 && (this.y + this.height) - (player.y + player.height) > OFFSET) || // player is higher than us
				this.isTouching(LEFT) || this.isTouching(RIGHT)) // we're up against a wall
			{
				this.tryJump();
			}
			
			// handle jumping behavior
			if (jumpPhase > 0 && jumpPhase < MAX_JUMP_HOLD) 
			{
				acceleration.y = 0;
				jumpPhase++;
			}
			else if (jumpPhase > 0)
			{
				acceleration.y = GRAVITY;
				jumpPhase = -1;
			}
			else if (this.isTouching(FLOOR) && jumpPhase == -1)
			{
				jumpPhase = 0;
			}
			else {
				acceleration.y = GRAVITY;
			}
		}
		
		private function tryJump():void
		{
			if(jumpPhase == 0)
            {
				jumpPhase = 1;
				velocity.y = -JUMP_SPEED;
            }
		}
	}

}