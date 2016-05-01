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
            loadGraphic(heartsImg, true, true, 128, 128);
			scale.x = 0.125;
			scale.y = 0.125;
			width = 16;  
			offset.x = 48;
			height = 16;
			offset.y = 48;
			
			addAnimation("HALF", [0]);
			addAnimation("FULL", [1]);
			addAnimation("EMPTY", [2]);
			
			state = ["EMPTY", "FULL"];
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			
			currIdx = 1;
			play(state[currIdx]);
			
		}
		
		override public function update():void
		{
			super.update();
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