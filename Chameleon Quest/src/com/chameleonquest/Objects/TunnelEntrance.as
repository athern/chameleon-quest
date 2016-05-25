package com.chameleonquest.Objects 
{
	import org.flixel.FlxSprite;
	public class TunnelEntrance extends FlxSprite
	{
		private var open:Boolean;
		
		public function TunnelEntrance(X:Number, Y:Number) 
		{
			super(X, Y);
			
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