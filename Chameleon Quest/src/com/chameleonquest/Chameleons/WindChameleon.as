package com.chameleonquest.Chameleons 
{
	import com.chameleonquest.Projectiles.Gust;
	import com.chameleonquest.Projectiles.Projectile;
	import org.flixel.FlxG;
	public class WindChameleon extends Chameleon
	{
		[Embed(source = "../../../../assets/whitechameleon.png")]public var whiteChameleon:Class;
		
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