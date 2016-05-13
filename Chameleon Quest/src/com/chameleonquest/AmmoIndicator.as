package com.chameleonquest 
{
	import org.flixel.*;
	public class AmmoIndicator extends FlxSprite
	{
		[Embed(source = "../../../assets/ammoindicator.png")]
		public var img:Class;
		
		[Embed(source = "../../../assets/tongueend.png")]
		public var tongueimg:Class;
		
		[Embed(source = "../../../assets/rock.png")]
		public var rockimg:Class;
		
		[Embed(source = "../../../assets/water-stream-head.png")]
		public var waterimg:Class;
		
		public var currentindicator:FlxSprite;
		
		public function AmmoIndicator() 
		{
			super(8, 8, img);
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			currentindicator = new FlxSprite(x + 3, y + 9, tongueimg);
			currentindicator.scrollFactor.x = 0;
			currentindicator.scrollFactor.y = 0;
		}
		
		public function showRock(ammo:int):void
		{
			currentindicator.loadGraphic(rockimg);
			currentindicator.scale.x = 1;
			currentindicator.scale.y = 1;
			currentindicator.x = x + 7;
			currentindicator.y = y + 12;
			
		}
		
		public function showTongue():void
		{
			currentindicator.loadGraphic(tongueimg, true, false, 16, 16);
			currentindicator.scale.x = 1;
			currentindicator.scale.y = 1;
			currentindicator.x = x + 3;
			currentindicator.y = y + 9;
		}
		
		public function showWater():void
		{
			currentindicator.loadGraphic(waterimg);
			currentindicator.scale.x = .5;
			currentindicator.scale.y = .5;
			currentindicator.x = x-4;
			currentindicator.y = y;
		}
		
	}

}