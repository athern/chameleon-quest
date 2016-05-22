package com.chameleonquest 
{
	import org.flixel.*;

	public class Heart extends FlxSprite
	{
		[Embed(source = "../../../assets/hearts.png")]public var heartsImg:Class;
		
		private var state:Array;
		private var currIdx:int;
		
		public function Heart(X:int, Y:int):void 
		{
			super(X, Y);
            loadGraphic(heartsImg, true, true, 16, 16);
			
			addAnimation("HALF", [0]);
			addAnimation("FULL", [1]);
			addAnimation("EMPTY", [2]);
			
			state = ["EMPTY", "HALF", "FULL"];
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			
			currIdx = 2;
			play(state[currIdx]);
			
		}
		
		public function hit():void {
			if (currIdx > 0) {
				currIdx--;
				play(state[currIdx]);
			}
		}
		
		public function isEmpty():Boolean {
			return currIdx == 0;
		}
	}

}