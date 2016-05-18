package com.chameleonquest.Enemies 
{
	import com.chameleonquest.PlayState;
	import com.chameleonquest.Projectiles.Fireball;
	import com.chameleonquest.Projectiles.Projectile;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	public class BossDragon extends HorizontallyPatrollingEnemy
	{
		
		[Embed(source = "../../../../assets/dragon.png")]
		protected var img:Class;
		protected static const SHOOT_DELAY:Number = 2; // perhaps this can be decresed on damage to speed up firing
		private var cooldown:Number;
		private var ammoCache:FlxGroup = new FlxGroup();
		
		public function BossDragon(MinX:Number, MaxX:Number, Y:Number) 
		{
			super(MinX, MaxX, Y, 50);
			loadGraphic(img, false, true);
			cooldown = 0;			
			immovable = true;
			
			for (var i : int = 0; i < 50; i++)
			{
				var dracarys:Fireball = new Fireball(50);
				dracarys.angle = 90; // rotate it so it's facing down!
				ammoCache.add(dracarys);
			}
			
			(FlxG.state as PlayState).enemyProjectiles.add(ammoCache);
			
			health = 3;
		}
		
		override public function update():void 
		{
			super.update();
			
			var attack:Projectile;
			if (cooldown > SHOOT_DELAY && (attack = ammoCache.getFirstAvailable() as Projectile)) 
			{
				var attackX:Number = this.facing == LEFT ? this.x - attack.width : this.x + this.width;
				var attackY:Number = this.y + this.height / 2;
				attack.shoot(attackX, attackY, 0, 300);
				cooldown = 0;
			}
			
			cooldown += FlxG.elapsed;	// ammo cooldown
		}
	}

}