package com.chameleonquest.Chameleons 
{
	import com.chameleonquest.Projectiles.Fireball;
	import com.chameleonquest.Projectiles.Projectile;
	import org.flixel.FlxG;
	public class FireChameleon extends Chameleon
	{
		[Embed(source = "../../../../assets/redchameleon.png")]public var redChameleon:Class;
		private var charging:Boolean;
		private var chargeDistance:Number;
		private static const MIN_CHARGE_DISTANCE:Number = 50;
		private static const MAX_CHARGE_DISTANCE:Number = 200;
		
		public function FireChameleon(Xindex:int,Yfloorindex:int, indexedPoint:Boolean = true) 
		{
			super(Xindex, Yfloorindex, indexedPoint);
            loadGraphic(redChameleon, true, true, 38, 16);			
			width = 20;  
			offset.x = 9;
			height = 14;
			offset.y = 2;
			
			this.tongue = null;
			this.type = Chameleon.FIRE;
			this.charging = false;
			this.chargeDistance = 0;
		}
		
		public static function cloneFrom(reference:Chameleon):Chameleon
		{
			var clone:Chameleon = new FireChameleon(reference.x, reference.y, false);
			clone.facing = reference.facing;
			clone.velocity.x = reference.velocity.x;
			clone.velocity.y = reference.velocity.y;
			clone.health = reference.health;
			
			return clone;
		}
		
		override public function getNextAttack():Projectile 
		{
			return new Fireball(this.chargeDistance);
		}
		
		override protected function handleShooting():void 
		{
			if (FlxG.keys.SPACE)
			{
				if (!this.charging)
				{
					this.chargeDistance = MIN_CHARGE_DISTANCE;
					this.charging = true;
				}
				else if (this.chargeDistance <= MAX_CHARGE_DISTANCE)
				{
					this.chargeDistance += 5;
				}
			}
			else if (this.charging) 
			{
				if (this.cooldown > SHOOT_DELAY)
				{
					this.shoot();
				}
				
				this.charging = false;
			}
		}
		
	}

}