package com.chameleonquest 
{
	import com.chameleonquest.Enemies.Enemy;
	import com.chameleonquest.Projectiles.Projectile;
	import com.chameleonquest.Projectiles.Rock;
    import org.flixel.*;

    public class Player extends FlxSprite 
    {
		[Embed(source = "../../../assets/greenchameleon.png")]public var greenChameleon:Class;
		
		protected static const NORMAL:uint = 0x00;
		protected static const WATER:uint = 0x01;
		protected static const FIRE:uint = 0x02;
		protected static const EARTH:uint = 0x03;
		protected static const WIND:uint = 0x04;
		protected static const ELECTRICITY:uint = 0x05;
		
		protected static const RUN_SPEED:int = 120;
		protected static const GRAVITY:int =800;
		protected static const JUMP_SPEED:int = 200;
		protected static const SHOOT_DELAY:Number = .4;
		protected static const RUN_ACCELERATION:int = 1000;
		
		public var tongue:Tongue;
		protected var jumpPhase:int;
		protected var invulnerability:int = 0;
		protected var hasRock:Boolean;
		protected var cooldown:Number;
		protected static const MAX_JUMP_HOLD:int = 15;
		
		private var type:uint;
		
		public var velocityModifiers:FlxPoint = new FlxPoint(0, 0);
		
        public function Player(Xindex:int,Yfloorindex:int):void // X,Y: Starting coordinates
        {
            super(Xindex*16, Yfloorindex*16-16);
            loadGraphic(greenChameleon, true, true, 38, 16);
			width = 20;  
			offset.x = 9;
			height = 14;
			offset.y = 2;
			drag.x = RUN_SPEED * 16;  // Drag is how quickly you slow down when you're not pushing a button.
            acceleration.y = GRAVITY; // Always try to push chameleon in the direction of gravity
            maxVelocity.x = RUN_SPEED;
            maxVelocity.y = JUMP_SPEED * 3;
			health = 3;
			
			cooldown = SHOOT_DELAY;
			
			this.tongue = new Tongue(this);
			this.type = NORMAL;
        }
		
		override public function update():void
		{
			
			if(FlxG.keys.UP && jumpPhase == 0)
            {
				jumpPhase = 1;
                velocity.y = -JUMP_SPEED;
            }
			else if (FlxG.keys.UP && jumpPhase > 0 && jumpPhase < MAX_JUMP_HOLD) 
			{
				acceleration.y = 0;
				jumpPhase++;
			}
			else if (jumpPhase > 0)
			{
				acceleration.y = GRAVITY;
				jumpPhase = -1;
			}
			else if (isTouching(FLOOR) && !FlxG.keys.UP) {
				jumpPhase = 0;
				acceleration.y = 0;
			}
			else {
				if(velocityModifiers.y != 0) {
					velocity.y = velocityModifiers.y;
				}
				acceleration.y = GRAVITY;
			}
			
			if (FlxG.keys.LEFT)
            {
                facing = LEFT;
				acceleration.x = -RUN_ACCELERATION;
            }
            else if (FlxG.keys.RIGHT)
            {
                facing = RIGHT;
				acceleration.x = RUN_ACCELERATION;            
            }
			else
			{
				if(velocityModifiers.x != 0) {
					velocity.x = velocityModifiers.x;
				}
				acceleration.x = 0;
			}
			
			
			velocityModifiers.x = 0;
			velocityModifiers.y = 0;
			
			this.cooldown += FlxG.elapsed;	// ammo cooldown
			invulnerability--;
            super.update();
        }
		
		public function assignRock():void
		{
			// TODO: change to holding rock sprite
			this.hasRock = true;
		}
		
		// returns a Projectile if the chameleon has something to shoot and hasn't shot anything recently
		public function getNextAttack():Projectile
		{
			if (this.cooldown > SHOOT_DELAY && 
				(this.type != NORMAL || this.hasRock))
			{
				// only return a projectile if we've waited long enough from the last attack
				// TODO: once attack hits something, reset cooldown to SHOOT_DELAY
				this.cooldown = 0;
				if (this.hasRock)
				{
					this.hasRock = false;
					return new Rock();
				}
			}
			
			return null;
		}
		
		//returns damage actually taken
		public function reactToDamage(source:Enemy):int {
			if (invulnerability > 0) {
				return 0;
			}
			invulnerability = 30;
			
			if (source.x > x) {
				velocity.x -= Math.random() * 100 + 200;
			}
			if (source.x < x) {
				velocity.x += Math.random() * 100 + 200;
			}
			if (source.y > y) {
				velocity.y -= Math.random() * 100 + 200;
			}
			if (source.y < y) {
				velocity.y += Math.random() * 100 + 200;
			}
			return source.power;
		}
    }

}