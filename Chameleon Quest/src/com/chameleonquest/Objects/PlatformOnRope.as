package com.chameleonquest.Objects 
{

	import com.chameleonquest.PlayState;
	import org.flixel.*;
	
	public class PlatformOnRope extends Platform
	{
		
		private var chain:FlxGroup;
		
		public function PlatformOnRope(X:int, Y:int, height:int=1) 
		{
			super(new Array(new FlxPoint(X, Y)), 0, height);
			chain = new FlxGroup();
			for (var i:int = Y; i >= 0; i -= 32) {
				chain.add(new RopeSegment(X+8, i-32, this));
			}
			var current:PlayState = FlxG.state as PlayState;
			current.bgElems.add(chain);
		}
		
		public function drop(broken:RopeSegment):void
		{
			this.immovable = false;
			acceleration.y = 400;
			for (var i :int = 0; i < chain.members.length; i++)
			{
				if (chain.members[i] != null && (chain.members[i] as RopeSegment).y > broken.y)
				{
					(chain.members[i] as RopeSegment).kill();
				}
			}
		}
		
	}

}