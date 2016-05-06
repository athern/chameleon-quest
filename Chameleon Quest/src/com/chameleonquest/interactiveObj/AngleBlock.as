package com.chameleonquest.interactiveObj 
{
	import com.chameleonquest.Projectiles.Projectile;
	import com.chameleonquest.Projectiles.Rock;
	import org.flixel.*;
	
	public class AngleBlock extends InteractiveObj
	{
		[Embed(source="../../../../assets/angleblock.png")]
		protected var img:Class;
		
		public function AngleBlock(Xindex:int, Yindex:int, r:int) 
		{
			super(Xindex * 16 + 4, Yindex * 16 + 4);
			loadGraphic(img);
			angle = r;
			width = 8;
			height = 8;
			offset.x = 4;
			offset.y = 4;
			immovable = true;
		}
		
		override public function hit(bullet:Projectile):void
		{
			if (angle == 90 && bullet.facing == LEFT)
			{
				bullet.shoot(x-2, y + 5, 0, 200);
			}
			if (angle == 0 && bullet.facing == LEFT)
			{
				bullet.shoot(x - 2, y - 5, 0, -200);
			}
			if (angle == 180 && bullet.facing == RIGHT)
			{
				bullet.shoot(x - 2, y + 5, 0, 200);
			}
			if (angle == 270 && bullet.facing == RIGHT)
			{
				bullet.shoot(x - 2, y - 5, 0, -200);
			}
			if (angle == 0 && bullet.facing == DOWN)
			{
				bullet.shoot(x + 5, y - 2, 200, 0);
			}
			if (angle == 90 && bullet.facing == UP)
			{
				bullet.shoot(x + 5, y - 2, 200, 0);
			}
			if (angle == 180 && bullet.facing == UP)
			{
				bullet.shoot(x - 5, y - 2, -200, 0);
			}
			if (angle == 270 && bullet.facing == DOWN)
			{
				bullet.shoot(x - 5, y - 2, -200, 0);
			}
		}
		
	}

}