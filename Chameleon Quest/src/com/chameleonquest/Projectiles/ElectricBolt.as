package com.chameleonquest.Projectiles 
{
	import org.flixel.FlxSprite;
	public class ElectricBolt extends Projectile
	{		
		[Embed(source = "../../../../assets/bolt.png")]public var bolt:Class;
		
		private const maxChains:int = 3; // todo
		private var chainCount:int;
		private var storedVelocityX:int;
		private var reshooting:Boolean;
		
		public function ElectricBolt() 
		{
			super();
			loadGraphic(bolt, true, true, 64, 64);
			scale.x = .5;
			scale.y = .5;
			height = 14;
			width = 32;
			offset.x = 16;
			offset.y = 24;
			this.exists = false;
			this.reshooting = false;
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		override public function getDamage(Target:FlxSprite):Number
		{
			this.reshootFrom(Target);
			return 1;
		}
		
		override public function shoot(X:int, Y:int, VelocityX:int, VelocityY:int):void 
		{
			super.shoot(X, Y, VelocityX, VelocityY);
			this.storedVelocityX = VelocityX;
			
			if (!this.reshooting)
			{
				this.chainCount = 0;
			}
			
			this.reshooting = false;
		}
		
		private function reshootFrom(target:FlxSprite):void 
		{
			if (this.chainCount > this.maxChains)
			{
				return;
			}
			
			// reshoot the electric bolt on the other side of the enemy
			var newX:Number = this.facing == RIGHT ? this.x + target.width : this.x - target.width - this.width;
			this.chainCount++;
			this.reshooting = true;
			this.shoot(newX, this.y, this.storedVelocityX * 0.75, this.velocity.y);
		}
		
	}

}