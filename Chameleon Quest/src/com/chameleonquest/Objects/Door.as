package com.chameleonquest.Objects 
{
	import org.flixel.*;
	
	public class Door extends FlxSprite
	{
		
		[Embed(source = "../../../../assets/closeddoor.png")]protected var closed:Class;
		[Embed(source = "../../../../assets/opendoor.png")]protected var open:Class;
		
		public function Door(Xindex:int, Yfloorindex:int, isOpen:Boolean) 
		{
			super(Xindex * 16 + 8, Yfloorindex * 16 - 36);
			if (isOpen)
			{
				loadGraphic(open);
				width = 2;
				height = 2;
				immovable = true;
				offset.x = 7;
				offset.y = 27;
				x += 7;
				y += 27;
				FlxG.visualDebug = true;
			}
			else
			{
				loadGraphic(closed);
			}
			scale.x = 2;
			scale.y = 2;
		}
		
	}

}