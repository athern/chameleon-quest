package com.chameleonquest.Enemies 
{
	import com.chameleonquest.PlayState;
	import com.chameleonquest.Projectiles.Poison;
	import com.chameleonquest.Projectiles.Projectile;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxRect;

	public class PoisonSnake extends Snake
	{
		[Embed(source = "../../../../assets/purplesnake-2.png")]public var purpleSnake:Class;
		
		protected static const GRAVITY:int = 800;
		protected static const SHOOT_DELAY:Number = 2;
		
		private var cooldown:Number;
		
		public function PoisonSnake(X:int, Y:int) 
		{
			super(X, X, Y);
			speed = 0;
			health = 2;		
			cooldown = SHOOT_DELAY;
			this.facing = RIGHT;
		}
		
		public override function loadSprites():void
		{
			loadGraphic(purpleSnake, true, true, 32, 30);
		}
		
		public override function update():void
		{
			super.update();
			var currentState : PlayState = FlxG.state as PlayState;
			if (currentState.player.x > x)
			{
				facing = LEFT;
			}
			else
			{
				facing = RIGHT;
			}
			var attack:Projectile;
			if (cooldown > SHOOT_DELAY && (attack = new Poison())) 
			{
				var attackX:Number = this.facing == RIGHT ? this.x - attack.width : this.x + this.width;
				var attackY:Number = this.y + this.height / 2;
				attack.shoot(attackX, attackY, this.facing == RIGHT ? -200 : 200, 0);
				currentState.enemyProjectiles.add(attack);
				cooldown = 0;
			}
			
			cooldown += FlxG.elapsed;	// ammo cooldown
		}
	}

}