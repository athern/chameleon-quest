package com.chameleonquest.Objects 
{
	import com.chameleonquest.PlayState;
	import org.flixel.*;
	
	public class TNT extends FlxSprite
	{
		[Embed(source = "../../../../assets/tnt.png")]public var img:Class;
		
		[Embed(source = "../../../../assets/explosion-particle.png")]public var explosion:Class;
		
		
		public var fire:BurningFuse;
		
		public var fuse:Array;
		
		public function TNT(Xindex:int, Yfloorindex:int, fusePoints:Array) 
		{
			super(Xindex * 16, Yfloorindex * 16 - 32, img);
			buildFuse(fusePoints);
			
			immovable = true;
		}
		
		override public function update():void
		{
			if (fuse.length == 0)
			{
				fire.kill();
				explode();
			}
			else if (fire != null)
			{
				var currentSegment:FuseSegment = fuse[fuse.length - 1] as FuseSegment;
				if (currentSegment.variant == 1)
				{
					if (currentSegment.angle == fire.angle) {
						fire.angle = (fire.angle + 90) % 360;
						if (fire.angle == 90)
						{
							fire.x += 5;
						}
						if (fire.angle == 180)
						{
							fire.y += 5;
						}
						if (fire.angle == 270)
						{
							fire.x -= 5;
						}
						if (fire.angle == 0)
						{
							fire.y -= 5;
						}
					}
					if (currentSegment.angle == ((fire.angle + 90) % 360))
					{
						fire.angle = (fire.angle + 270) % 360;
						if (fire.angle == 90)
						{
							fire.x += 5;
						}
						if (fire.angle == 180)
						{
							fire.y += 5;
						}
						if (fire.angle == 270)
						{
							fire.x -= 5;
						}
						if (fire.angle == 0)
						{
							fire.y -= 5;
						}
					}
				}
				if (fire.angle == 0)
				{
					fire.x++;
					if (fire.x + fire.width > currentSegment.x + currentSegment.width)
					{
						currentSegment.kill();
						fuse.pop();
					}
				}
				if (fire.angle == 90)
				{
					fire.y++;
					if (fire.y + fire.height > currentSegment.y + currentSegment.height)
					{
						currentSegment.kill();
						fuse.pop();
					}
				}
				if (fire.angle == 180)
				{
					fire.x--;
					if (fire.x < currentSegment.x)
					{
						currentSegment.kill();
						fuse.pop();
					}
				}
				if (fire.angle == 270)
				{
					fire.y--;
					if (fire.y < currentSegment.y)
					{
						currentSegment.kill();
						fuse.pop();
					}
				}
			}
		}
		
		public function explode():void
		{
			var particles:FlxEmitter = new FlxEmitter(x + 16, y + 16);
			particles.makeParticles(explosion, 100);
			particles.setXSpeed(-500, 500);
			particles.setYSpeed( -500, 500);
			particles.start(true, .5);
			var current:PlayState = FlxG.state as PlayState;
			current.particles.add(particles);
			kill();
		}
		
		public function startBurning(source:FuseSegment):void
		{
				if (fire == null)
				{
					fire = new BurningFuse(source.x, source.y-2);
					var current:PlayState = FlxG.state as PlayState;
					current.bgElems.add(fire);
					fire.angle = source.angle;
				}
		}
		
		public function buildFuse(fusePoints:Array):void
		{
			var index:int = 0;
			var lastX:int = x;
			var lastY:int = y;
			fuse = new Array();
			if ((fusePoints[0] as FlxPoint).y < y)
			{
				lastX += 6;
				lastY += 2;
			}
			if ((fusePoints[0] as FlxPoint).y > y + height)
			{
				lastX += 6;
				lastY += height-2;
			}
			if ((fusePoints[0] as FlxPoint).x < x)
			{
				lastY += 6;
				lastX += 2;
			}
			if ((fusePoints[0] as FlxPoint).x > x + width)
			{
				lastY += 6;
				lastX += width-2;
			}
			
			while (index < fusePoints.length)
			{
				while (lastX != (fusePoints[index] as FlxPoint).x || lastY != (fusePoints[index] as FlxPoint).y)
				{
					if (lastX > (fusePoints[index] as FlxPoint).x)
					{
						lastX -= 4;
						if (lastX == (fusePoints[index] as FlxPoint).x)
						{
							if (index == fusePoints.length - 1)
							{
								fuse.push(new FuseSegment(lastX, lastY, this, 2));
							}
							else
							{
								if ((fusePoints[index + 1] as FlxPoint).y < lastY)
								{
									fuse.push(new FuseSegment(lastX, lastY, this, 1, 180));
								}
								else
								{
									fuse.push(new FuseSegment(lastX, lastY, this, 1, 270));
								}
							}
						}
						else
						{
							fuse.push(new FuseSegment(lastX, lastY, this));
						}
					}
					if (lastX < (fusePoints[index] as FlxPoint).x)
					{
						lastX += 4;
						if (lastX == (fusePoints[index] as FlxPoint).x)
						{
							if (index == fusePoints.length - 1)
							{
								fuse.push(new FuseSegment(lastX, lastY, this, 2, 180));
							}
							else
							{
								if ((fusePoints[index + 1] as FlxPoint).y < lastY)
								{
									fuse.push(new FuseSegment(lastX, lastY, this, 1, 90));
								}
								else
								{
									fuse.push(new FuseSegment(lastX, lastY, this, 1));
								}
							}
						}
						else
						{
							fuse.push(new FuseSegment(lastX, lastY, this, 0, 180));
						}
					}
					if (lastY < (fusePoints[index] as FlxPoint).y)
					{
						lastY += 4;
						if (lastY == (fusePoints[index] as FlxPoint).y)
						{
							if (index == fusePoints.length - 1)
							{
								fuse.push(new FuseSegment(lastX, lastY, this, 2, 270));
							}
							else
							{
								if ((fusePoints[index + 1] as FlxPoint).x < lastX)
								{
									fuse.push(new FuseSegment(lastX, lastY, this, 1, 90));
								}
								else
								{
									fuse.push(new FuseSegment(lastX, lastY, this, 1, 180));
								}
							}
						}
						else
						{
							fuse.push(new FuseSegment(lastX, lastY, this, 0, 270));
						}
					}
					if (lastY > (fusePoints[index] as FlxPoint).y)
					{
						lastY -= 4;
						if (lastY == (fusePoints[index] as FlxPoint).y)
						{
							if (index == fusePoints.length - 1)
							{
								fuse.push(new FuseSegment(lastX, lastY, this, 2, 90));
							}
							else
							{
								if ((fusePoints[index + 1] as FlxPoint).x < lastX)
								{
									fuse.push(new FuseSegment(lastX, lastY, this, 1));
								}
								else
								{
									fuse.push(new FuseSegment(lastX, lastY, this, 1, 270));
								}
							}
						}
						else
						{
							fuse.push(new FuseSegment(lastX, lastY, this, 0, 90));
						}
					}
					
				}
				index++;
			}
		}
		
	}

}