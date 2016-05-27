package com.chameleonquest.Objects 
{
	import com.chameleonquest.PlayState;
	import org.flixel.*;
	
	public class FuseSegment extends FlxSprite
	{
		
		
		[Embed(source = "../../../../assets/fuse-end.png")]public var fuseend:Class;
		
		[Embed(source = "../../../../assets/fuse-segment.png")]public var fusesegment:Class;
		
		[Embed(source = "../../../../assets/fuse-segment-turn.png")]public var fuseturn:Class;
		
		public var source:TNT;
		public var variant:int;
		
		public function FuseSegment(X:int, Y:int, trigger:TNT, type:int=0, r:int=0) 
		{
			super(X, Y);
			angle = r;
			variant = type;
			source = trigger;
			var current:PlayState = FlxG.state as PlayState;
			if (type == 0)
			{
				loadGraphic(fusesegment);
			}
			if (type == 1)
			{
				loadGraphic(fuseturn);
			}
			if (type == 2)
			{
				loadGraphic(fuseend);
			}
			current.bgElems.add(this);
		}
		
		
	}

}