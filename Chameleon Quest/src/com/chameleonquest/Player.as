package com.chameleonquest 
{
    import org.flixel.*;
	
	

    public class Player extends FlxSprite 
    {
		[Embed(source = "../../../assets/greenchameleon.png")]public var greenChameleon:Class;
		
		protected static const RUN_SPEED:int = 80;
		protected static const GRAVITY:int =800;
		protected static const JUMP_SPEED:int = 200;
		protected static const JUMP_ACCELERATION:int = 40;
		
		protected var jumpPhase:int;
		protected var verticallyStable:int = 0;
		
        public function Player(X:int,Y:int):void // X,Y: Starting coordinates
        {
            super(X, Y);
            loadGraphic(greenChameleon, true, true, 32, 16);
			
			drag.x = RUN_SPEED * 8;  // Drag is how quickly you slow down when you're not pushing a button.
            acceleration.y = GRAVITY; // Always try to push chameleon in the direction of gravity
            maxVelocity.x = RUN_SPEED;
            maxVelocity.y = JUMP_SPEED * 3;
        }
		
		override public function update():void
		{
			if(FlxG.keys.UP && jumpPhase == 0)
            {
				jumpPhase = 1;
                velocity.y = -JUMP_SPEED;
            }
			else if (FlxG.keys.UP && jumpPhase > 0 && jumpPhase < 15) 
			{
				acceleration.y = 0;
				jumpPhase++;
			}
			else if (jumpPhase > 0)
			{
				acceleration.y = GRAVITY;
				jumpPhase = -1;
			}
			if (velocity.y == 0) 
			{
				verticallyStable++;
			}
			else 
			{
				verticallyStable = 0;
			}
			if (verticallyStable > 2 && jumpPhase == -1)
			{
				jumpPhase = 0;
				verticallyStable = 0;
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
            super.update();
            
             
        }
    }

}