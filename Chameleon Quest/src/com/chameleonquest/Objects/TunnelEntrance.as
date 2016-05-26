package com.chameleonquest.Objects 
{
	import org.flixel.FlxSprite;
	public class TunnelEntrance extends FlxSprite
	{
		[Embed(source = "../../../../assets/turtle.png")]public var pileImg:Class;
		private var open:Boolean;
		
		public function TunnelEntrance(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(pileImg, true, true, 128, 36);
			width = 128;  
			height = 36;
			
			open = true;
		}
		
		public function collapse():void
		{
			// no longer allow the sandworm to emerge from here
			open = false; 
			
			// play collapse animation
		}
		
		public function get isOpen():Boolean
		{
			return this.open;
		}
	}

}