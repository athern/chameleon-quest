package com.chameleonquest.Chameleons 
{
	import com.chameleonquest.Projectiles.Gust;
	import com.chameleonquest.Projectiles.Projectile;
	import org.flixel.FlxG;
	public class WindChameleon extends Chameleon
	{
		[Embed(source = "../../../../assets/whitechameleon.png")]public var whiteChameleon:Class;
		private var doubleJump:Boolean;
		private var jumpCount = 0;
		
		public function WindChameleon(Xindex:int,Yfloorindex:int, indexedPoint:Boolean = true) 
		{
			super(Xindex, Yfloorindex, indexedPoint);
            loadGraphic(whiteChameleon, true, true, 38, 16);			
			width = 20;  
			offset.x = 9;
			height = 14;
			offset.y = 2;
			
			this.tongue = null;
			this.type = Chameleon.WIND;
			this.doubleJump = false;
			this.jumpCount = 0;
		}
		
		public static function cloneFrom(reference:Chameleon):Chameleon
		{
			var clone:Chameleon = new WindChameleon(reference.x, reference.y, false);
			clone.facing = reference.facing;
			clone.velocity.x = reference.velocity.x;
			clone.velocity.y = reference.velocity.y;
			clone.health = reference.health;
			clone.jumpPhase = reference.jumpPhase;
			
			return clone;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (!FlxG.keys.UP && acceleration.y > 0 && jumpCount < 2)
			{
				// currently jumping, enable double jumping
				doubleJump = true;
				jumpCount++;
			}
			else if (isTouching(FLOOR))
			{
				// on the ground, reset double jump capabilities
				doubleJump = false;
				jumpCount = 0;
			}
			
			if(FlxG.keys.UP && doubleJump)
            {
				// jump again!
				jumpPhase = 0;
				acceleration.y = 0;
				doubleJump = false;
				jumpCount++;
            }
		}
		
		override public function getNextAttack():Projectile 
		{
			return new Gust();
		}
		
		override protected function handleShooting():void 
		{
			if (FlxG.keys.SPACE)
			{
				if (this.cooldown > SHOOT_DELAY)
				{
					this.shoot();
				}
			}
		}
		
	}

}