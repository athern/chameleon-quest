package com.chameleonquest.interactiveObj 
{
	import com.chameleonquest.*;
	import org.flixel.*;
	public class WoodBlock extends InteractiveObj
	{
		protected static const GRAVITY:int =800;
		
		[Embed(source = "../../../../assets/woodblock.png")]
		protected var img:Class;
		
		[Embed(source = "../../../../assets/large-wood-block.png")]
		protected var img2:Class;
		
		public function WoodBlock(Xindex:int, Yfloorindex:int, size:int = 1) 
		{
			super(Xindex * 16, Yfloorindex * 16 - 48);
			if (size == 1) {
				loadGraphic(img);
				width = 14;
			}
			if (size == 2) {
				loadGraphic(img2);
				width = 30;
			}
			acceleration.y = GRAVITY;
			offset.x = 1;
			drag.x = 200;
		}
	}

}