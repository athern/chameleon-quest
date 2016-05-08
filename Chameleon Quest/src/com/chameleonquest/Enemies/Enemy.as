package com.chameleonquest.Enemies 
{
	import org.flixel.*;
	import com.chameleonquest.Projectiles.*;
	
	public class Enemy extends FlxSprite
	{
		public var power:int;
		
		protected static const DEATH_ANIMATION_LENGTH:int = 30;
		
		protected var dying:int = -1;
		
		public function Enemy(X:int, Y:int) {
			super(X, Y);
		}
		
		override public function update():void
		{
			super.update();
			if (dying > 0)
			{
				dying--;
			}
			if (dying == 0)
			{
				this.kill();
			}
			
		}
		
		override public function hurt(damage:Number):void
		{
			health -= damage;
			if (health > 0)
			{
				flicker(.25);
			}
			else if (dying == -1)
			{
				play("death");
				dying = DEATH_ANIMATION_LENGTH;
				velocity.x = 0;
				flicker(1);
				power = 0;
			}
		}
		
		public function hitWith(bullet:Projectile):void
		{
			hurt(bullet.getDamage(this));
		}
	}

}