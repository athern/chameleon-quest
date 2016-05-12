package com.chameleonquest 
{
	import com.chameleonquest.Rooms.*;
	import org.flixel.*;

	public class GameOverState extends FlxState
	{
		
		override public function create():void
		{			
			Preloader.logger.logLevelStart(99, {"src": Main.lastRoom});
			Preloader.tracker.trackPageview("/go-screen");
			Preloader.tracker.trackEvent("game-over", "source", null, Main.lastRoom);
				
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
			Preloader.logger.logAction(14, {"room": Main.lastRoom});
			Preloader.logger.logLevelEnd(null);
			Preloader.tracker.trackEvent("restart", "dest", null, Main.lastRoom);
			
			if (Main.lastRoom == 1)
			{
				FlxG.switchState(new Room1_1State());
			}
			else if (Main.lastRoom == 2)
			{
				FlxG.switchState(new Room1_2State());
			}
			else if (Main.lastRoom == 3)
			{
				FlxG.switchState(new Room1_3State());
			}
			else if (Main.lastRoom == 4)
			{
				FlxG.switchState(new Room1_4State());
			}
			else if (Main.lastRoom == 5)
			{
				FlxG.switchState(new Room1_5State());
			}
			else if (Main.lastRoom == 6)
			{
				FlxG.switchState(new Room1_6State());
			}
			else if (Main.lastRoom == 7)
			{
				FlxG.switchState(new Room1_7State());
			}
			else if (Main.lastRoom == 8)
			{
				FlxG.switchState(new Room2_1State());
			}
			else if (Main.lastRoom >= 9)
			{
				FlxG.switchState(new Room2_2State());
			}
			else
			{
				FlxG.switchState(new MenuState());
			}
		}
	}

}