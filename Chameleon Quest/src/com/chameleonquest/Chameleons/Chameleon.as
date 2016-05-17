package com.chameleonquest.Chameleons 
{
	import com.chameleonquest.Enemies.Enemy;
	import com.chameleonquest.PlayState;
	import com.chameleonquest.Projectiles.Projectile;
	import com.chameleonquest.Projectiles.Rock;
	import com.chameleonquest.Tongue;
    import org.flixel.*;
	import com.chameleonquest.*;
		
    public class Chameleon extends FlxSprite 
    {
		[Embed(source = "../../../../assets/greenchameleon.png")]public var greenChameleon:Class;

		static public const NORMAL:uint = 0x00;
		static public const WATER:uint = 0x01;
		static public const FIRE:uint = 0x02;
		static public const EARTH:uint = 0x03;
		static public const WIND:uint = 0x04;
		static public const ELECTRICITY:uint = 0x05;
		
		protected static const RUN_SPEED:int = 120;
		protected static const GRAVITY:int =800;
		protected static const JUMP_SPEED:int = 200;
		protected static const SHOOT_DELAY:Number = .2;
		protected static const RUN_ACCELERATION:int = 1000;
		protected static const INVULNERABILITY_TIMER:int = 60;
		
		public var tongue:Tongue;
		public var jumpPhase:int;
		protected var invulnerability:int = 0;
		public var ammo:int;
		protected var cooldown:Number;
		protected static const MAX_JUMP_HOLD:int = 15;
		
		protected var rockCache:FlxGroup = new FlxGroup();
		
		protected var type:uint;
		
		public var velocityModifiers:FlxPoint = new FlxPoint(0, 0);
		
        public function Chameleon(Xindex:int,Yfloorindex:int, indexedPoint:Boolean = true):void // X,Y: Starting coordinates
        {
			if (indexedPoint)
			{
				Xindex *= 16;
				Yfloorindex = Yfloorindex * 16 - 16;
			}
			
			super(Xindex, Yfloorindex);
			
            loadGraphic(greenChameleon, true, true, 38, 16);
			addAnimation("basic", [0]);
			addAnimation("holdingRock", [1]);
			play("basic");
			width = 20;  
			offset.x = 9;
			height = 14;
			offset.y = 2;
			drag.x = RUN_SPEED * 16;  // Drag is how quickly you slow down when you're not pushing a button.
            acceleration.y = GRAVITY; // Always try to push chameleon in the direction of gravity
            maxVelocity.x = RUN_SPEED;
            maxVelocity.y = JUMP_SPEED * 3;
			health = 3;
			ammo = 0;
			cooldown = SHOOT_DELAY;
			this.tongue = new Tongue(this);
			this.type = NORMAL;
			for (var i : int = 0; i < 20; i++)
			{
				rockCache.add(new Rock());
			}
        }
		
		public static function cloneFrom(reference:Chameleon):Chameleon
		{
			var clone:Chameleon = new Chameleon(reference.x, reference.y, false);
			clone.facing = reference.facing;
			clone.velocity.x = reference.velocity.x;
			clone.velocity.y = reference.velocity.y;
			clone.health = reference.health;
			clone.jumpPhase = reference.jumpPhase;
			
			return clone;
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
			
			if (FlxG.keys.X)
			{
				ammo = 0;
				play("basic");
			}
			
			this.handleShooting();
			
			velocityModifiers.x = 0;
			velocityModifiers.y = 0;
			
			this.cooldown += FlxG.elapsed;	// ammo cooldown
			invulnerability--;
			
            super.update();
        }
		
		public function getType():uint
		{
			return this.type;
		}
		
		protected function handleShooting():void 
		{
			if (FlxG.keys.justPressed("SPACE"))
			{
				if (cooldown > SHOOT_DELAY)
				{
					if (ammo > 0)
					{
						Preloader.logger.logAction(7, {"tongue":0, "projectile": 1});
						Preloader.tracker.trackEvent("action", "space", "projectile");
						
						this.shoot();
						ammo--;
			
						if (this.ammo == 0)
						{
							play("basic");
						}
					}
					else
					{
						Preloader.logger.logAction(7, {"tongue":1, "projectile": 0});
						Preloader.tracker.trackEvent("action", "space", "tongue");
						
						cooldown = 0;
						tongue.shoot();
					}
				}
			}
			if (FlxG.keys.justReleased("SPACE"))
			{
				if (tongue.extending)
				{
					tongue.extending = false;
				}
			}
		}
		
		protected function shoot():void
		{
			// only return a projectile if we've waited long enough from the last attack
			// TODO: once attack hits something, reset cooldown to SHOOT_DELAY
			this.cooldown = 0;
			var attack:Projectile = this.getNextAttack();
			var attackX:Number = facing == FlxObject.LEFT ? x : x + width - attack.width;
			var attackY:Number = y + height / 2 - attack.height / 2;
			attack.shoot(attackX, attackY, facing == FlxObject.LEFT ? -200 : 200, isTouching(FLOOR) ? velocity.y : 0);
			var currentState:PlayState = FlxG.state as PlayState;
			currentState.projectiles.add(attack);
		}
		
		public function assignRock():void
		{
			Preloader.logger.logAction(12, {"x": this.x, "y": this.y, "room": Main.lastRoom});
			Preloader.tracker.trackEvent("action", "rock", "(" + this.x + ", " + this.y +")");
			
			this.ammo = 3;
			play("holdingRock");
		}
		
		// returns a Projectile if the chameleon has something to shoot and hasn't shot anything recently
		public function getNextAttack():Projectile
		{
			return rockCache.getFirstAvailable() as Projectile;
		}
		
		// returns damage actually taken
		public function reactToDamage(source:Enemy=null):int {
			if (invulnerability > 0) {
				return 0;
			}
			invulnerability = INVULNERABILITY_TIMER;
			flicker(INVULNERABILITY_TIMER / 60);
			FlxG.flash(0xcc0000, .1);
			if (source != null)
			{
				if (source.x > x && source.x > x + width) {
					velocity.x = -Math.random() * 100 - 200;
				}
				if (source.x < x && source.x + source.width < x) {
					velocity.x = Math.random() * 100 + 200;
				}
				if (source.y > y) {
					velocity.y = -Math.random() * 100 - 200;
				}
				if (source.y < y) {
					velocity.y = Math.random() * 100 + 200;
				}
				return source.power;
			}
			return 1;
		}
    }

}