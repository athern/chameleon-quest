package com.chameleonquest.Chameleons 
{
	import com.chameleonquest.Projectiles.Projectile;
	import com.chameleonquest.Projectiles.WaterStream;
	import org.flixel.FlxG;

	public class WaterChameleon extends Chameleon
	{
		[Embed(source = "../../../../assets/bluechameleon.png")]public var blueChameleon:Class;
		
		public function WaterChameleon(Xindex:int,Yfloorindex:int, indexedPoint:Boolean = true) 
		{
			super(Xindex, Yfloorindex, indexedPoint);
            loadGraphic(blueChameleon, true, true, 38, 16);			
			width = 20;  
			offset.x = 9;
			height = 14;
			offset.y = 2;
			
			this.tongue = null;
			this.type = Chameleon.WATER;
		}
		
		public static function cloneFrom(reference:Chameleon):Chameleon
		{
			var clone:Chameleon = new WaterChameleon(reference.x, reference.y, false);
			clone.facing = reference.facing;
			clone.velocity.x = reference.velocity.x;
			clone.velocity.y = reference.velocity.y;
			clone.health = reference.health;
			
			return clone;
		}
		
		override public function getNextAttack():Projectile 
		{
			return new WaterStream();
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