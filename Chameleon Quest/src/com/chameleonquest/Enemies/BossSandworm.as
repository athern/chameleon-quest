package com.chameleonquest.Enemies 
{
	import com.chameleonquest.Objects.TunnelEntrance;
	import org.flixel.FlxSprite;
	public class BossSandworm extends Enemy
	{
		private static const SPEED:Number = 100;
		private static const OFFSET:Number = 5;
		private var SURFACE_TIME:Number = 5;
		private var surfaceCooldown:Number;
		private var currentTunnel:TunnelEntrance;
		private var emerged:Boolean;
		
		public function BossSandworm(X:Number, Y:Number) 
		{
			super(X, Y);
			
			health = 3;
			surfaceCooldown = SURFACE_TIME;
			emerged = false;
			
			exists = false;
		}
		
		override public function update():void 
		{
			super.update();
			
			// handle moving up and down
			if (emerged && surfaceCooldown < SURFACE_TIME && velocity.y < 0 && (this.y - currentTunnel.y) > (this.height - OFFSET))
			{
				velocity.y = 0;
				// stop moving up!
			}
			else if (emerged && surfaceCooldown > SURFACE_TIME && velocity.y = 0)
			{
				velocity.y = SPEED;
			}
			else if (emerged && surfaceCooldown > SURFACE_TIME && velocity.y < 0 && this.y > currentTunnel.y)
			{
				// stop moving down!
				velocity.y = 0;
				exists = false;
				currentTunnel = null;
			}
		}
		
		override public function hitWith(bullet:Projectile):void
		{
			// the sandworm is immune to all but giant boulders
		}
		
		public function crush():void
		{
			if (emerged)
			{
				hurt(1);
				velocity.y = SPEED * 2;
				currentTunnel.collapse();
			}
		}
		
		public function emergeFrom(tunnel:TunnelEntrance)
		{
			// TODO
			var newX:Number = tunnel.x;
			var newY:Number = tunnel.y;
			reset(newX, newY);
			
			currentTunnel = location;
			surfaceCooldown = 0;
			velocity.y = -SPEED;
			emerged = true;
		}
	}

}