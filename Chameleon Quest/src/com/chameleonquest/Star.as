package com.chameleonquest 
{
	import org.flixel.*;
	
	public class Star extends FlxSprite
	{
		
		[Embed(source = "../../../assets/star.png")]
		protected var img:Class;
		
		[Embed(source = "../../../assets/unearnedstar.png")]
		protected var img2:Class;
		
		public function Star(X:int, Y:int, earned:Boolean) 
		{
			var imgToUse:Class;
			if (earned) {
				imgToUse = img;
			}
			else {
				imgToUse = img2;
			}
			super(X, Y, imgToUse);
		}
		
	}

}