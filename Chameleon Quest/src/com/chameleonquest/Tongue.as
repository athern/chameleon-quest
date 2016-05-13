package com.chameleonquest 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.interactiveObj.InteractiveObj;
	import org.flixel.*;
	
	public class Tongue extends FlxSprite
	{
		[Embed(source = "../../../assets/tongueend.png")]public var tongue:Class;
		public static const SPEED:int = 120;
		public static const OFFSET:int = 5;
		protected static const GRAVITY:int =800;
		
		private var player:Chameleon;
		public var extending:Boolean;
		private var hasRock:Boolean;
		public var grabbedObject:InteractiveObj;
		
		private var segments:Array;
		private var segmentCache:FlxGroup;
		
		private var extended:int;
		
		public function Tongue(player:Chameleon)
		{
			super();
			loadGraphic(tongue, false, true);
			this.player = player;
			segments = new Array;
			segments.push(this);
			segmentCache = new FlxGroup();
			height = 8;
			for (var i:int = 0; i < 50; i++)
			{
				segmentCache.add(new TongueSegment( -16, -16));
			}
		}
		
		override public function update():void 
		{
			
			if (!this.alive && this.finished)
			{
				this.exists = false;
			}
			else
			{
				if (this.facing != player.facing) 
				{
					cleanup();
				}
				
				if ((this.facing == LEFT && this.isTouching(LEFT)) || (this.facing == RIGHT && this.isTouching(RIGHT)))
				{
					this.extending = false;
				}
				
				if (this.extending)
				{
					this.extending = (this.facing == LEFT && this.x > (player.x - this.width) - 64) || (this.facing == RIGHT && this.x < (player.x + player.width) + 64);
				}
				else if ((this.facing == LEFT && this.x >= player.x - OFFSET) || (this.facing == RIGHT && this.x <= (player.x + player.width - this.width + OFFSET)))
				{
					cleanup();
				}
				if (this.extending)
				{
					extended += 2;
				}
				else
				{
					extended -= 2;
				}
				if (grabbedObject != null)
				{
					grabbedObject.velocity.x = 0;
					grabbedObject.velocity.y = 0;
					if (player.facing == RIGHT)
					{
						if (grabbedObject.x >= x + 15 && !(this.extending))
						{
							grabbedObject.velocity.x = -SPEED;
						}
					}
					else
					{
						if (grabbedObject.x + grabbedObject.width >= x && !(this.extending))
						{
							grabbedObject.velocity.x = SPEED;
						}
					}
				}
				
				super.update();
				
			}
		}
		
		public function alignWithPlayer():void
		{
			y = player.y;
			if (player.facing == RIGHT)
			{
				x = player.x + player.width + extended;
			}
			else
			{
				x = player.x - 16 - extended;
			}
			
			for (var i:int = 1; i < segments.length; i++)
			{
				segments[i].y = y;
				if (player.facing == RIGHT)
				{
					segments[i].x = x - 16 * i;
					if (segments[i].x < player.x)
					{
						segments[i].kill();
						segments.splice(i, 1);
						i--;
					}
				}
				if (player.facing == LEFT)
				{
					segments[i].x = x + 16 * i;
					if (segments[i].x + segments[i].width > player.x + player.width)
					{
						segments[i].kill();
						segments.splice(i, 1);
						i--;
					}
				}
			}
			if ((player.facing == RIGHT && segments[segments.length - 1].x > player.x + player.width)
				|| (player.facing == LEFT && segments[segments.length - 1].x + 16 < player.x))
			{
				var nowVisible:TongueSegment = segmentCache.getFirstAvailable() as TongueSegment;
				nowVisible.reset(segments[segments.length - 1].x - ((player.facing == RIGHT) ? 16 : -16), segments[0].y);
				segments.push(nowVisible);
				var current:PlayState = FlxG.state as PlayState;
				current.bgElems.add(nowVisible);
			}
		}
		
		public function cleanup():void
		{
			if (grabbedObject != null)
			{
				grabbedObject.velocity.x = 0;
				grabbedObject.velocity.y = 0;
				grabbedObject = null;
			}
			for (var i :int = 1; i < segments.length; i++)
			{
				segments[i].kill();
				segments.splice(i, 1);
				i--;
			}
			extended = 0;
			this.kill();
			
		}
		
		public function pickupRock():void
		{
			player.assignRock();
			extending = false;
		}
		
		// Sets the projectile to x,y moving in velocity x,y direction
		public function shoot():void
		{
			extended = 0;
			for (var i :int = 1; i < segments.length; i++)
			{
				segments[i].kill();
				segments.splice(i, 1);
				i--;
			}
			var newX:Number = player.facing == LEFT ? player.x - OFFSET : player.x + player.width + OFFSET;
			var newY:Number = player.y;
			super.reset(newX, newY);
			this.solid = true;
			this.facing = player.facing;
			this.extending = true;
			this.hasRock = false;
			grabbedObject = null;
		}
	}
}