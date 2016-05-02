package com.chameleonquest 
{
	import com.chameleonquest.Enemies.Enemy;
	import com.chameleonquest.Projectiles.Projectile;
	import com.chameleonquest.Projectiles.Rock;
    import org.flixel.*;

    public class Player extends FlxSprite 
    {
		[Embed(source = "../../../assets/greenchameleon.png")]public var greenChameleon:Class;
		
		protected static const RUN_SPEED:int = 120;
		protected static const GRAVITY:int =800;
		protected static const JUMP_SPEED:int = 200;
		protected static const JUMP_ACCELERATION:int = 40;
		protected static const SHOOT_DELAY:Number = .4;
		
		protected var jumpPhase:int;
		protected var invulnerability:int = 0;
		protected var ammo:FlxGroup;
		protected var cooldown:Number;
		protected static const MAX_JUMP_HOLD:int = 15;
		
		public var velocityModifiers:FlxPoint = new FlxPoint(0, 0);
		
        public function Player(X:int,Y:int):void // X,Y: Starting coordinates
        {
            super(X, Y);
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
			
			ammo = new FlxGroup();
			ammo.add(new Rock());
			cooldown = SHOOT_DELAY;
        }
		
		override public function update():void
		{
			
			if(FlxG.keys.UP && jumpPhase == 0 && !FlxG.paused)
            {
				jumpPhase = 1;
                velocity.y = -JUMP_SPEED;
            }
			else if (FlxG.keys.UP && jumpPhase > 0 && jumpPhase < MAX_JUMP_HOLD && !FlxG.paused) 
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
				acceleration.y = GRAVITY;
			}
			
			// check for Pause
			if (FlxG.paused) {
				return;
			}
			
			if (FlxG.keys.LEFT)
            {
                facing = LEFT; 
                velocity.x = -RUN_SPEED;
            }
            else if (FlxG.keys.RIGHT)
            {
                facing = RIGHT;
                velocity.x = RUN_SPEED;              
            }
			else {
				velocity.x = 0;
			}
			velocity.y += velocityModifiers.y;
			velocity.x += velocityModifiers.x;
			velocityModifiers.x = 0;
			velocityModifiers.y = 0;
			
			this.cooldown += FlxG.elapsed;	// ammo cooldown
			invulnerability--;
            super.update();
        }
		
		// returns a Projectile if the chameleon has something to shoot and hasn't shot anything recently
		public function getAmmo():Projectile
		{
			var attack:Projectile;
			if (this.cooldown > SHOOT_DELAY && (attack = this.ammo.getFirstAvailable() as Projectile))
			{
				// only return a projectile if we've waited long enough from the last attack
				// TODO: once attack hits something, reset cooldown to SHOOT_DELAY
				this.cooldown = 0;
				return attack;
			}
			
			return null;
		}
		
		//returns damage actually taken
		public function reactToDamage(source:Enemy):int {
			if (invulnerability > 0) {
				return 0;
			}
			invulnerability = 15;
			
			if (source.x > x) {
				velocity.x -= Math.random() * 200 + 100;
			}
			if (source.x < x) {
				velocity.x += Math.random() * 200 + 100;
			}
			if (source.y > y) {
				velocity.y -= Math.random() * 200 + 100;
			}
			if (source.y < y) {
				velocity.y += Math.random() * 200 + 100;
			}
			return source.power;
		}
    }

}