package com.chameleonquest.Objects 
{
	import com.chameleonquest.PlayState;
	import org.flixel.*;

	public class PlatformOnChain extends Platform
	{
		
		private var chain:Array;
		private var lastY:int;
		
		public var pulley:Pulley;
		
		public function PlatformOnChain(X:int, Y:int, height:int=1) 
		{
			super(new Array(new FlxPoint(X, Y)), 0, height);
			chain = new Array;
			lastY = Y;
			for (var i:int = Y-16; i >= 0; i -= 16) {
				chain.push(new ChainSegment(X+16, i, this));
			}
			var current:PlayState = FlxG.state as PlayState;
			for (var j:int = 0; j < chain.length; j++) {
				current.bgElems.add(chain[j]);
			}
		}
		
		override public function update():void
		{
			super.update();
			var delta:int = y - lastY;
			for (var i:int = 0; i < chain.length; i++)
			{
				chain[i].y += delta;
			}
			if (chain[chain.length - 1].y > 0)
			{
				var nowVisible:ChainSegment = new ChainSegment(chain[0].x+16, chain[chain.length - 1].y - 16, this);
				chain.push(nowVisible);
				var current:PlayState = FlxG.state as PlayState;
				current.bgElems.add(nowVisible);
			}
			lastY = y;
		}
		
	}

}