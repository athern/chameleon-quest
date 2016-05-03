package com.chameleonquest.interactiveObj 
{
	import org.flixel.*;
	public class WoodBlock extends InteractiveObj
	{
		
		[Embed(source = "../../../../assets/WoodBlock.png")]
		protected var img:Class;
		
		public function WoodBlock(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(img);
		}
		
	}

}