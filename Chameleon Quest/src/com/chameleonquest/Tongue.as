package com.chameleonquest 
{
	import com.chameleonquest.Chameleons.Player;
	import com.chameleonquest.interactiveObj.InteractiveObj;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	public class Tongue extends FlxSprite
	{
		[Embed(source = "../../../assets/tongue.png")]public var tongue:Class;
		public static const SPEED:int = 120;
		public static const OFFSET:int = 5;
		protected static const GRAVITY:int =800;
		
		private var player:Player;
		private var extending:Boolean;
		private var hasRock:Boolean;
		public var grabbedObject:InteractiveObj;
		public var grabbedFacing:uint;
		
		public function Tongue(player:Player)
		{
			super();
			loadGraphic(tongue, false, true);
			this.player = player;
			immovable = true;
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
					this.extending = (this.facing == LEFT && this.x > (player.x - this.width)) || (this.facing == RIGHT && this.x < (player.x + player.width));
				}
				else if ((this.facing == LEFT && this.x >= player.x - OFFSET) || (this.facing == RIGHT && this.x <= (player.x + player.width - this.width + OFFSET)))
				{
					cleanup();
				}
				
				this.velocity.x = player.velocity.x + (this.extending ? 1 : -1) * (player.facing == RIGHT ? SPEED : -SPEED)
				this.velocity.y = player.velocity.y;
				if (grabbedObject != null)
				{
					/*
					if ((grabbedObject.isTouching(RIGHT) && this.velocity.x > 0) || (grabbedObject.isTouching(LEFT) && this.velocity.x < 0)
						|| (player.facing != grabbedFacing))
					{
						grabbedObject.velocity.x = 0;
						grabbedObject.velocity.y = 0;
						grabbedObject = null;
					}
					else
					{*/
						grabbedObject.velocity.x = 0;
						grabbedObject.velocity.y = 0;
						if (player.facing == RIGHT)
						{
							if (grabbedObject.x > x + 15)
							{
								grabbedObject.velocity.x = velocity.x;
							}
						}
						else
						{
							if (grabbedObject.x > x - 8)
							{
								grabbedObject.velocity.x = velocity.x;
							}
						}
					//}
				}
				super.update();
			}
		}
		
		public function cleanup():void
		{
			if (this.hasRock)
			{
				player.assignRock();
			}
			if (grabbedObject != null)
			{
				grabbedObject.velocity.x = 0;
				grabbedObject.velocity.y = 0;
				grabbedObject = null;
			}
			this.kill();
		}
		
		public function pickupRock():void
		{
			// TODO: switch to tongue + rock sprite
			this.hasRock = true;
		}
		
		// Sets the projectile to x,y moving in velocity x,y direction
		public function shoot():void
		{
			var newX:Number = player.facing == LEFT ? player.x - OFFSET : player.x + player.width - this.width + OFFSET;
			var newY:Number = player.y;
			super.reset(newX, newY);
			this.solid = true;
			this.facing = player.facing;
			this.velocity.x = player.velocity.x + (player.facing == RIGHT ? SPEED : -SPEED);
			this.velocity.y = player.velocity.y;
			this.extending = true;
			this.hasRock = false;
			grabbedObject = null;
		}
	}
}