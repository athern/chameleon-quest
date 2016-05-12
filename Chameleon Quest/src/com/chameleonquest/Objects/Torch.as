package com.chameleonquest.Objects 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import org.flixel.*;

	public class Torch extends FlxSprite implements ElementSource
	{
		[Embed(source = "../../../../assets/torch.png")]public var torchImg:Class;
		
		public function Torch(Xindex:int, Yfloorindex:int) 
		{
			super(Xindex*16, Yfloorindex*16-16);
			loadGraphic(torchImg, true, true, 128, 128);
			scale.x = 0.25;
			scale.y = 0.25;
			width = 32;  
			offset.x = 48;
			height = 32;
			offset.y = 48;
			
			immovable = true;
			
			addAnimation("LIT", [1, 2], 3);
			addAnimation("OFF", [0]);
			
			play("LIT");
		}
	
		public function getElementType():uint
		{
			return Chameleon.FIRE;
		}
	}

}