package com.chameleonquest.Objects 
{
	import org.flixel.FlxSprite;
	public class TunnelDirt extends FlxSprite
	{
		[Embed(source = "../../../../assets/dirt.png")] public var dirt:Class;
		public static const SPRITE_WIDTH:Number = 65;
		public static const SPRITE_HEIGHT:Number = 48;
		
		public function TunnelDirt(X:Number, Y:Number, sideways:Boolean)
		{
			super(X, Y);
			loadGraphic(dirt, false, true);
			scale.x = 0.5;
			scale.y = 0.5;
			width = SPRITE_WIDTH;
			height = SPRITE_HEIGHT;
			offset.x = SPRITE_WIDTH / 2;
			offset.y = SPRITE_HEIGHT / 2;
		
			if (sideways)
			{
				this.angle = -90.
			}
		}
		
	}

}