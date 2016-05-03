package com.chameleonquest 
{
	import org.flixel.*;
	
	public class Button extends FlxSprite
	{
		
		[Embed(source = "../../../assets/button.png")]public var buttonImg:Class;
		
		private var isHit:Boolean;
		
		public function Button(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(buttonImg, true, true, 128, 128);
			scale.x = 0.125;
			scale.y = 0.125;
			width = 16;  
			offset.x = 56;
			height = 6;
			offset.y = 62;
			
			immovable = true;
			
			addAnimation("DOWN", [0]);
			addAnimation("UP", [1]);
			
			isHit = false;
			
			play("UP");
		}
		
		// hit the button
		public function hit():void {
			if (!isHit) {
				isHit = true;
				height = 4;
				offset.y = 66
				this.y += 4
				play("DOWN");
			}
			
		}
		
	}

}