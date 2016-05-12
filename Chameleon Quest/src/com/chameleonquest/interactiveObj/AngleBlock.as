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
			var xOff:int = 2;
			var yOff:int = 2;
			if (r == 0)
			{
				yOff = 6;
			}
			if (r == 180)
			{
				xOff = 6;
			}
			if (r == 270)
			{
				xOff = 6;
				yOff = 6;
			}
			super(Xindex * 16 + xOff, Yindex * 16 + yOff);
			loadGraphic(img);
			angle = r;
			width = 8;
			height = 8;
			offset.x = xOff;
			offset.y = yOff;
			immovable = true;
			speed = 0;
		}
		
		override public function hit(bullet:Projectile):void
		{
			if (bullet is Rock)
			{
				if (angle == 90 && bullet.facing == LEFT)
				{
					bullet.shoot(x, y + 5, 0, 200);
				}
				if (angle == 0 && bullet.facing == LEFT)
				{
					bullet.shoot(x, y - 5, 0, -200);
				}
				if (angle == 180 && bullet.facing == RIGHT)
				{
					bullet.shoot(x - 4, y + 5, 0, 200);
				}
				if (angle == 270 && bullet.facing == RIGHT)
				{
					bullet.shoot(x - 4, y - 5, 0, -200);
				}
				if (angle == 0 && bullet.facing == DOWN)
				{
					bullet.shoot(x + 5, y - 4, 200, 0);
				}
				if (angle == 90 && bullet.facing == UP)
				{
					bullet.shoot(x + 5, y, 200, 0);
				}
				if (angle == 180 && bullet.facing == UP)
				{
					bullet.shoot(x - 5, y, -200, 0);
				}
				if (angle == 270 && bullet.facing == DOWN)
				{
					bullet.shoot(x - 5, y - 4, -200, 0);
				}
			}
		}
		
		public static function rotate(block:AngleBlock):void
		{
			InteractiveObj.rotate(block);
			if (block.angle == 0)
			{
				block.offset.x -= 4;
				block.x -= 4;
			}
			if (block.angle == 90)
			{
				block.y -= 4;
				block.offset.y -= 4;
			}
			if (block.angle == 180)
			{
				block.offset.x += 4;
				block.x += 4;
			}
			if (block.angle == 270)
			{
				block.offset.y += 4;
				block.y += 4;
			}
		}
		
		public override function update():void
		{
			super.update();
		}
		
		
		
	}

}