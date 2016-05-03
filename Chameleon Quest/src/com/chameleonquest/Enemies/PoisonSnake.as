package com.chameleonquest.Enemies 
{
	import com.chameleonquest.Projectiles.Poison;
	import com.chameleonquest.Projectiles.Projectile;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxRect;

	public class PoisonSnake extends Snake
	{
		[Embed(source = "../../../../assets/spritesheet_enemies.png")]public var purpleSnake:Class;
		
		protected static const GRAVITY:int = 800;
		protected static const RUN_SPEED:int = 60;
		protected static const SHOOT_DELAY:Number = 2;
		
		protected var ammo:FlxGroup;
		
		private var cooldown:Number;
		
		public function PoisonSnake(X:Number, Y:Number, MapBounds:FlxRect) 
		{
			super(X, Y);
			health = 2;
			power = 2;
			
			ammo = new FlxGroup;
			ammo.add(new Poison(MapBounds));
			ammo.add(new Poison(MapBounds));
			ammo.add(new Poison(MapBounds));
			
			cooldown = SHOOT_DELAY;
			this.facing = RIGHT;
		}
		
		public override function loadSprites():void
		{
			loadGraphic(purpleSnake, true, true, 128, 138);
			addAnimation("idle", [0], 1, false);
			addAnimation("death", [8], 1, false);	
			width = 40;  
			offset.x = 45;
			height = 15;
			offset.y = 73;		
		}
		
		public override function update():void
		{
			if (this.health == 0)
			{
				play("death");
				this.flicker(1);
			}
			else
			{
				play("idle");
			}
			
			var attack:Projectile;
			if (cooldown > SHOOT_DELAY && (attack = this.ammo.getFirstAvailable() as Projectile)) 
			{
				var attackX:Number = this.facing == RIGHT ? this.x - attack.width : this.x + this.width;
				var attackY:Number = this.y + this.height / 2 - attack.height / 2;
				attack.shoot(attackX, attackY, this.facing == RIGHT ? -200 : 200, 0);
				cooldown = 0;
			}
			
			cooldown += FlxG.elapsed;	// ammo cooldown
			
			super.update();
		}
		
		public function getAmmo():FlxGroup
		{
			return this.ammo;
		}
	}

}