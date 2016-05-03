package com.chameleonquest.Objects 
{
	import com.chameleonquest.PlayState;
	import org.flixel.*;

	public class PlatformOnChain extends Platform
	{
		
		private var chain:FlxGroup;
		
		public function PlatformOnChain(X:int, Y:int) 
		{
			super(new Array(new FlxPoint(X, Y)), 0);
			chain = new FlxGroup();
			for (var i:int = 0; i < Y; i += 16) {
				chain.add(new ChainSegment(X+16, i));
			}
			var current:PlayState = FlxG.state as PlayState;
			current.bgElems.add(chain);
		}
		
	}

}