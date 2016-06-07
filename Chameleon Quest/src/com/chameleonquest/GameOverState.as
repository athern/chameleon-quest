package com.chameleonquest 
{
	import com.chameleonquest.Rooms.*;
	import org.flixel.*;

	public class GameOverState extends FlxState
	{
		
		private var hint:Array = ["Drag wooden block with your tongue",
									"Pick up rock with your tongue",
									"Birds and spikes are baaaddd",
									"Careful with that venom",
									"Turtles make good counter-weight",
									"Rock bounces off triangle block",
									"Turtles have soft under bellies",
									"Fountain = water element",
									"To pass the grate, be the water!",
									"Going up!",
									"Gates are waterwheel-operated",
									"Gates are also timed",
									"Make your own stairway to heaven",
									"Open both gates to unleash the geyser",
									"Black spikes are instant-kill",
									"Big boulder are bad for chameleon",
									"Charged fireball travel longer",
									"Use fire to light fuse",
									"Going up with the explosion!",
									"Careful stacking the blocks"];
		
		override public function create():void
		{			
			// gameover count
			Preloader.goCnt++;
			
			Preloader.logger.logLevelStart(99, {"src": Main.lastRoom});
			Preloader.tracker.trackPageview(Preloader.flag + "/go-screen");
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
			
			if (Preloader.goCnt >= 2) {
				Preloader.logger.logAction(50, {"room": Main.lastRoom, "goCount" : Preloader.goCnt});
				Preloader.tracker.trackEvent("hint", "source", "level-" + Main.lastRoom, Main.lastRoom);
				
				var hintHead:FlxText;
				hintHead = new FlxText(0, (FlxG.width / 2), FlxG.width, "Hint:");
				hintHead.setFormat(null, 12, 0xFF0000, "center");
				this.add(hintHead);
				
				var hintTxt:FlxText;
				hintTxt = new FlxText(0, (FlxG.width / 2) + 20, FlxG.width, hint[Main.lastRoom - 1]);
				hintTxt.setFormat(null, 12, 0x000000, "center");
				this.add(hintTxt);
			}
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
			FlxG.switchState(Main.getStage(Main.lastRoom));
		
		}
	}

}