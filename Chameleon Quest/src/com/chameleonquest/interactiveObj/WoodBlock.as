package com.chameleonquest.interactiveObj 
{
	import com.chameleonquest.*;
	import org.flixel.*;
	public class WoodBlock extends InteractiveObj
	{
		
		[Embed(source = "../../../../assets/WoodBlock.png")]
		protected var img:Class;
		
		public function WoodBlock(Xindex:int, Yfloorindex:int) 
		{
			super(Xindex*16, Yfloorindex*16-48);
			loadGraphic(img);
		}
	}

}