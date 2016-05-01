package com.chameleonquest 
{
    import org.flixel.*;
	
	

    public class Player extends FlxSprite 
    {
		[Embed(source = "../../../assets/greenchameleon.png")]public var greenChameleon:Class;
		
		protected static const RUN_SPEED:int = 120;
		protected static const GRAVITY:int =800;
		protected static const JUMP_SPEED:int = 200;
		protected static const MAX_JUMP_HOLD:int = 15;
		
		public var velocityModifiers:FlxPoint = new FlxPoint(0, 0);
		
		protected var jumpPhase:int;
		
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
            super.update();
             
        }
		
    }

}