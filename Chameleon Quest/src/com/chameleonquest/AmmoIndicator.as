package com.chameleonquest 
{
	import org.flixel.FlxSprite;
	public class AmmoIndicator extends FlxSprite
	{
		[Embed(source = "../../../assets/ammoindicator.png")]
		public var img:Class;
		
		[Embed(source = "../../../assets/tongueend.png")]
		public var tongueimg:Class;
		
		[Embed(source = "../../../assets/rock.png")]
		public var rockimg:Class;
		
		public var currentindicator:FlxSprite;
		
		public function AmmoIndicator() 
		{
			super(320 - 32, 8, img);
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			currentindicator = new FlxSprite(x + 3, y + 9, tongueimg);
			currentindicator.scrollFactor.x = 0;
			currentindicator.scrollFactor.y = 0;
		}
		
		public function showRock():void
		{
			currentindicator.loadGraphic(rockimg);
			currentindicator.x = x + 7;
			currentindicator.y = y + 12;
		}
		
		public function showTongue():void
		{
			currentindicator.loadGraphic(tongueimg);
			currentindicator.x = x + 3;
			currentindicator.y = y + 9;
		}
		
	}

}