package com.chameleonquest 
{
	import org.flixel.*;
	import com.chameleonquest.Rooms.*;
	
	public class IntroState extends FlxState
	{
		
		override public function create():void
		{	
			
			// add simple bg
			add(new Background(0, 0, 1, true));
			add(new Background(16, 0, 1, true));
			
			
			// Start Text
			var startTxt:FlxText;
			startTxt = new FlxText(15, 40, FlxG.width-30, "The chameleon kingdom has fallen into the grasp of a tyrant. " +
			"Legend speaks of a mighty hero who could vanquish the guardians of the elemental orbs, tame their powers, and restore peace to the kingdom. " +
			"Armed with only your wits and your tongue, you set out upon your quest...\n\nPress \'SPACE\' To Venture Forth");
			startTxt.setFormat(null, 12, 0x000000, "center");
			this.add(startTxt);
			
			FlxG.bgColor = 0xFFFFFFFF;
			
			
		}
		
		override public function update():void
		{
			// Start the play state
			if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.flash(0x000000, 0.75);
				FlxG.fade(0xff000000, 0.5, onFade);
			}            
			super.update();
		}
		
		private function onFade():void
		{
			FlxG.switchState(new Room1_1State());
		}
		
	}

}