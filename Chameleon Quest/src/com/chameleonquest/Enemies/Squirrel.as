package com.chameleonquest.Enemies 
{
	import com.chameleonquest.PlayState;
	import com.chameleonquest.Projectiles.Acorn;
	import com.chameleonquest.Projectiles.Projectile;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	public class Squirrel extends Enemy
	{
		[Embed(source = "../../../../assets/squirrel.png")]public var squirrelSprite:Class;
		protected static const GRAVITY:int = 0;
		protected static const SHOOT_DELAY:Number = 2;
		private var cooldown:Number;
		private var ammoCache:FlxGroup = new FlxGroup();
		
		public function Squirrel(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(squirrelSprite, true, true, 64, 64);
			scale.x = .5;
			scale.y = .5;
			height = 32;
			width = 32;
			offset.x = 16;
			offset.y = 16;
			
			addAnimation("holdingAcorn", [0]);
			addAnimation("idle", [1]);
			
			play("holdingAcorn");
			
			health = 1;
			cooldown = SHOOT_DELAY;
			immovable = true;
			acceleration.y = GRAVITY;
			for (var i : int = 0; i < 20; i++)
			{
				ammoCache.add(new Acorn());
			}
			var currentState : PlayState = FlxG.state as PlayState;
			currentState.enemyProjectiles.add(ammoCache);
			
			facing = RIGHT;
		}
		
		public override function update():void
		{
			super.update();
			var attack:Projectile;
			if (cooldown >= SHOOT_DELAY / 2)
			{
				play("holdingAcorn");
			}
			if (cooldown > SHOOT_DELAY && (attack = ammoCache.getFirstAvailable() as Projectile)) 
			{
				var attackX:Number = this.facing == RIGHT ? this.x - attack.width : this.x + this.width;
				var attackY:Number = this.y + this.height / 2;
				attack.shoot(attackX, attackY, this.facing == RIGHT ? -100 : 100, 0);
				cooldown = 0;
				play("idle");
			}
			
			cooldown += FlxG.elapsed;	// ammo cooldown
		}
		
	}

}