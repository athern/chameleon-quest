package com.chameleonquest.Projectiles 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;

	public class Rock extends Projectile
	{
		[Embed(source = "../../../../assets/rock.png")]public var greenChameleon:Class;
		
		public function Rock() 
		{
			super();
            loadGraphic(greenChameleon, false, true);
			this.exists = false;
		}
		
		override public function getDamage(Target:FlxSprite):int
		{
			return 1;
		}
	}

}