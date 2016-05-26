package com.chameleonquest.Objects 
{
	import org.flixel.FlxSprite;
	public class TunnelEntrance extends FlxSprite
	{
		[Embed(source = "../../../../assets/turtle.png")]public var pileImg:Class;
		private var open:Boolean;
		private var sideways:Boolean;
		
		public function TunnelEntrance(X:Number, Y:Number, sideways:Boolean = false) 
		{
			super(X, Y);
			loadGraphic(pileImg, true, true, 128, 36);
			
			if (sideways)
			{
				angle = -90;
				height = 128;  
				width = 15;
				offset.x = 40;
			}
			else
			{
				width = 128;  
				height = 15;
			}
			
			this.sideways = sideways;			
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
		
		public function get isSideways():Boolean
		{
			return this.sideways;
		}
	}

}