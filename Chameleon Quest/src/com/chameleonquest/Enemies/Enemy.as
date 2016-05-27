package com.chameleonquest.Enemies 
{
	import org.flixel.*;
	import com.chameleonquest.Projectiles.*;
	import com.chameleonquest.*;
	
	public class Enemy extends FlxSprite
	{
		public var power:int=1;
		
		protected static const DEATH_ANIMATION_LENGTH:int = 10;
		
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
			if (health > 0 && damage > 0)
			{
				flicker(.25);
			}
			else if (health <= 0 && dying == -1)
			{
				Preloader.logger.logAction(13, {"room": Main.lastRoom, "x": this.x, "y": this.y, "type": this.toString()});
				Preloader.tracker.trackEvent("enemy", "level-" + Main.lastRoom, "(" + this.x + ", " + this.y +"), type: " + this.toString());
				
				play("death");
				dying = DEATH_ANIMATION_LENGTH;
				velocity.x = 0;
				flicker(1);
				power = 0;
				angle = 180;
			}
		}
		
		public function hitWith(bullet:Projectile):void
		{
			hurt(bullet.getDamage(this));
		}
	}

}