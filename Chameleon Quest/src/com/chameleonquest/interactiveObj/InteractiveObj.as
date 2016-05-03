package com.chameleonquest.interactiveObj 
{
	import org.flixel.*;

	public class InteractiveObj extends FlxSprite
	{
		
		public function InteractiveObj(X:int, Y:int) 
		{
			super(X, Y);
			immovable = true;
		}
		
		public function hit():void {
			// placeholder for override
		}
		
	}

}