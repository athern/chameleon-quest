package com.chameleonquest.Enemies 
{
	import com.chameleonquest.Objects.TunnelEntrance;
	import com.chameleonquest.PlayState;
	import com.chameleonquest.Projectiles.Projectile;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	public class BossSandworm extends Enemy
	{
		[Embed(source = "../../../../assets/worm.png")] protected var sandworm:Class;
		private static const SPEED:Number = 100;
		private static const OFFSET:Number = 5;
		private var SURFACE_TIME:Number = 4;
		private var surfaceCooldown:Number;
		private var currentTunnel:TunnelEntrance;
		private var emerged:Boolean;
		
		private static const SPRITE_WIDTH:Number = 64;
		private static const SPRITE_HEIGHT:Number = 72.5;
		private static const X_OFFSET:Number = 95;
		private static const Y_OFFSET:Number = 100;
		
		public function BossSandworm(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(sandworm, true, true, 256, 282);
			addAnimation("basic", [0, 1, 3, 6, 7], 10, true);
			play("basic");
			scale.x = 0.25;
			scale.y = 0.25;
			width = SPRITE_WIDTH;
			height = SPRITE_HEIGHT;
			offset.x = X_OFFSET;
			offset.y = Y_OFFSET;
			
			health = 3;
			surfaceCooldown = SURFACE_TIME;
			emerged = false;
			immovable = true;
			
			exists = false;
		}
		
		override public function update():void 
		{
			super.update();
			
			var currentState:PlayState = FlxG.state as PlayState;
			this.facing = (angle == 0 && currentState.player.x < this.x) || (angle != 0 && this.y < currentState.player.y) ? RIGHT : LEFT;
			
			if (this.health > 0)
			{
				// handle moving up and down
				if (emerged && surfaceCooldown < SURFACE_TIME && 
					((this.angle == 0 && velocity.y < 0 && (currentTunnel.y - this.y) > (this.height - 2 * OFFSET)) ||
					(this.angle != 0 && velocity.x < 0 && (currentTunnel.x - this.x) > (this.height - OFFSET))))
				{
					// stop moving up!
					velocity.y = 0;
					velocity.x = 0;
				}
				else if (emerged && surfaceCooldown > SURFACE_TIME && ((this.angle == 0 && velocity.y == 0) || (this.angle != 0 && velocity.x == 0)))
				{
					if (angle == 0)
					{
						velocity.y = SPEED;
					}
					else
					{
						velocity.x = SPEED;
					}
				}
				else if (emerged && surfaceCooldown > SURFACE_TIME && 
						((angle == 0 && velocity.y > 0 && (this.y - OFFSET) > currentTunnel.y) || (angle != 0 && velocity.x > 0 && currentTunnel.x < (this.x - OFFSET))))
				{
					// stop moving down!
					velocity.y = 0;
					velocity.x = 0;
					exists = false;
					currentTunnel = null;
					emerged = false;
				}
			}
			
			surfaceCooldown += FlxG.elapsed;
		}
		
		override public function hitWith(bullet:Projectile):void
		{
			// the sandworm is immune to all but giant boulders
		}
		
		public function crush():void
		{
			if (emerged)
			{
				velocity.y = angle == 0 ? SPEED * 2 : 0;
				velocity.x = angle == 0 ? 0 : SPEED * 2;
				currentTunnel.collapse();
				hurt(1);
			}
		}
		
		public function emergeFrom(tunnel:TunnelEntrance):void
		{
			// TODO
			var newX:Number = tunnel.x + OFFSET;//tunnel.isSideways ? tunnel.x - (tunnel.height / 2) : tunnel.x;
			var newY:Number = tunnel.isSideways ? tunnel.y - (tunnel.width - this.width / 4) : tunnel.y;
			reset(newX, newY);
			
			this.angle = tunnel.isSideways ? -90 : 0;
			this.width = tunnel.isSideways ? SPRITE_HEIGHT : SPRITE_WIDTH;
			this.height = tunnel.isSideways ? SPRITE_WIDTH : SPRITE_HEIGHT;
			offset.x = tunnel.isSideways ? Y_OFFSET : X_OFFSET;
			offset.y = tunnel.isSideways ? X_OFFSET : Y_OFFSET;
			
			currentTunnel = tunnel;
			surfaceCooldown = 0;
			velocity.y = this.angle == 0 ? -SPEED : 0;
			velocity.x = this.angle == 0 ? 0 : -SPEED;
			emerged = true;
		}
	}

}