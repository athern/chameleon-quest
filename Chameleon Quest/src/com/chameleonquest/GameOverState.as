package com.chameleonquest 
{
	import com.chameleonquest.Rooms.Room1_1State;
	import com.chameleonquest.Rooms.Room1_2State;
	import org.flixel.*;

	public class GameOverState extends FlxState
	{
		
		override public function create():void
		{			
			// game over text
			var goText:FlxText;
			goText = new FlxText(0, (FlxG.width / 2) - 80, FlxG.width, "Game Over");
			goText.setFormat(null, 18, 0x000000, "center");
			this.add(goText);
			
			// continue Text
			var continueTxt:FlxText;
			continueTxt = new FlxText(0, (FlxG.width / 2) - 40, FlxG.width, "Press \"SPACE\" to Continue!");
			continueTxt.setFormat(null, 12, 0x000000, "center");
			this.add(continueTxt);
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
			if (Main.lastRoom == 1)
			{
				FlxG.switchState(new Room1_1State());
			}
			else if (Main.lastRoom == 2)
			{
				FlxG.switchState(new Room1_2State());
			}
			else
			{
				FlxG.switchState(new MenuState());
			}
		}
	}

}