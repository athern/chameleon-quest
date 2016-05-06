package com.chameleonquest.interactiveObj 
{
	import com.chameleonquest.*;
	import org.flixel.*;
	public class WoodBlock extends InteractiveObj
	{
		protected static const GRAVITY:int =800;
		
		[Embed(source = "../../../../assets/woodblock.png")]
		protected var img:Class;
		
		public function WoodBlock(Xindex:int, Yfloorindex:int) 
		{
			super(Xindex*16, Yfloorindex*16-44);
			loadGraphic(img);
			acceleration.y = GRAVITY;
			width = 14;
			offset.x = 1;
			drag.x = 200;
		}
	}

}