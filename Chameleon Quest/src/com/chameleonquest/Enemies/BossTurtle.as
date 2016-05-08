package com.chameleonquest.Enemies 
{
	import com.chameleonquest.Projectiles.Projectile;
	import org.flixel.FlxG;
	public class BossTurtle extends HorizontallyPatrollingEnemy
	{
		[Embed(source = "../../../../assets/bossturtle.png")] protected var megaTurtle:Class;
		protected static const GRAVITY:int = 800;
		private var savedMinX:Number;
		private var savedMaxX:Number;
		private var isFlipped:Boolean;
		
		private var flipTimer:Number = 8;
		private var cooldown:Number;
		
		public function BossTurtle(MinX:Number, MaxX:Number, Y:Number) 
		{
			super(MinX, MaxX, Y, 40);
			scale.x = -.8;
			scale.y = .8;
			loadGraphic(megaTurtle, true, true, 128, 85);
			addAnimation("idle", [0, 1, 2, 3], 5, true);
			addAnimation("death", [4]);
			addAnimation("flipped", [1, 3], 5, true);
			play("idle");
			width = 102;
			height = 68;
			offset.x = 16;
			offset.y = 10;
			immovable = true;
			health = 3;
			power = 2;
			this.isFlipped = false;
			this.cooldown = 0;
		}
		
		public override function update():void
		{
			if (this.isFlipped && this.cooldown > flipTimer) {
				// flip the turtle back rightside up!
				this.flip();
			}
			
			super.update();
			
			this.cooldown += FlxG.elapsed;
		}
		
		public function flip():void
		{
			if (this.isFlipped)
			{
				this.minX = this.savedMinX;
				this.maxX = this.savedMaxX;
				
				this.angle = 0;
				this.isFlipped = false;
				
				play("idle");
			}
			else
			{
				this.savedMinX = this.minX;
				this.savedMaxX = this.maxX;
				
				this.minX = this.x;
				this.maxX = this.x;
				
				this.angle = 180;
				this.isFlipped = true;
				
				this.cooldown = 0;
				
				play("flipped"); // it may be better to have a legit flip animation or use angular velocity to spin, but this is fine for now
			}
		}
		
		public static function flipBoss(boss:BossTurtle):void
		{
			boss.flip();
		}
		
		override public function hitWith(bullet:Projectile):void
		{
			if (this.isFlipped && bullet.y < y && bullet.x > x+4 && bullet.x+bullet.width < x + width - 4)
			{
				hurt(bullet.getDamage(this));
				speed += 20;
				flipTimer -= 1.5;
				flip();
			}
		}
	}

}