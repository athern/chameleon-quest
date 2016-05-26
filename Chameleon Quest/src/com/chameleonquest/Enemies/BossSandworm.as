package com.chameleonquest.Enemies 
{
	import com.chameleonquest.Objects.TunnelEntrance;
	import com.chameleonquest.Projectiles.Projectile;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	public class BossSandworm extends Enemy
	{
		[Embed(source = "../../../../assets/worm.png")] protected var sandworm:Class;
		private static const SPEED:Number = 100;
		private static const OFFSET:Number = 5;
		private var SURFACE_TIME:Number = 5;
		private var surfaceCooldown:Number;
		private var currentTunnel:TunnelEntrance;
		private var emerged:Boolean;
		
		public function BossSandworm(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(sandworm, true, true, 256, 282);
			scale.x = 0.5;
			scale.y = 0.5;
			width = 128;
			height = 135;
			offset.x = 64;
			offset.y = 73;
			
			health = 3;
			surfaceCooldown = SURFACE_TIME;
			emerged = false;
			immovable = true;
			
			exists = false;
		}
		
		override public function update():void 
		{
			super.update();
			
			// handle moving up and down
			if (emerged && surfaceCooldown < SURFACE_TIME && velocity.y < 0 && (currentTunnel.y - this.y) > (this.height - OFFSET))
			{
				velocity.y = 0;
				// stop moving up!
			}
			else if (emerged && surfaceCooldown > SURFACE_TIME && velocity.y == 0)
			{
				velocity.y = SPEED;
			}
			else if (emerged && surfaceCooldown > SURFACE_TIME && velocity.y > 0 && (this.y - OFFSET) > currentTunnel.y)
			{
				// stop moving down!
				velocity.y = 0;
				exists = false;
				currentTunnel = null;
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
				hurt(1);
				velocity.y = SPEED * 2;
				currentTunnel.collapse();
			}
		}
		
		public function emergeFrom(tunnel:TunnelEntrance):void
		{
			// TODO
			var newX:Number = tunnel.x;
			var newY:Number = tunnel.y;
			reset(newX, newY);
			
			currentTunnel = tunnel;
			surfaceCooldown = 0;
			velocity.y = -SPEED;
			emerged = true;
		}
	}

}