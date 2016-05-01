package com.chameleonquest 
{
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		
		override public function create():void
		{			
			// Title
			var title:FlxText;
			title = new FlxText(0, (FlxG.width / 2) - 80, FlxG.width, "Chameleon Quest");
			title.setFormat(null, 18, 0x000000, "center");
			this.add(title);
			
			// Start Text
			var startTxt:FlxText;
			startTxt = new FlxText(0, (FlxG.width / 2) - 40, FlxG.width, "Press \"SPACE\" to Start!");
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
			FlxG.switchState(new StageState());
		}
		
	}

}