package com.chameleonquest.Objects 
{
	import org.flixel.*;

	public class RopeSegment extends FlxSprite
	{
		[Embed(source = "../../../../assets/rope.png")]
		protected var img:Class;
		
		protected var obj:FlxSprite;
		
		override public function RopeSegment(X:int, Y:int, hangingObj:FlxSprite) 
		{
			super(X, Y, img);
			obj = hangingObj;
		}
		
		public function triggerDrop():void
		{
			if (obj is PlatformOnRope)
			{
				(obj as PlatformOnRope).drop(this);
			}
		}
		
	}

}