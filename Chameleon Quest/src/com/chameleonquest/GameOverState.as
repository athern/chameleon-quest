package com.chameleonquest 
{
	import com.chameleonquest.Rooms.*;
	import org.flixel.*;

	public class GameOverState extends FlxState
	{
		
		private var hint:Array = ["Hold SPACE while facing a block and you can pull it to you",
									"Firing rocks with SPACE can kill snakes and knock turtles out of the way",
									"Killing one bird with one stone is still a pretty good deal",
									"Not only do purple snakes shoot poison, they also take two rocks to kill",
									"Turtles make good counter-weight",
									"Rocks bounce off angled blocks",
									"Turtles have soft under bellies",
									"You can change into water form when near a fountain",
									"To pass the grate, be the water!",
									"Going up!",
									"Gates can be waterwheel-operated",
									"Some gates are also timed",
									"Make your own stairway to heaven",
									"Open both gates to unleash the geyser",
									"Black spikes are made of... obsidian? The point is, they kill you",
									"You might have to pre-charge a jump shot to avoid getting squashed",
									"Charged fireballs travel faster and further",
									"Use fire to light fuses",
									"The box will shoot up with the explosion",
									"A wood block is sturdy enough to support a boulder if you place it right",
									"Dirt shakes around the tunnel the worm will emerge from next!"];
		
		override public function create():void
		{			
			// gameover count
			Preloader.goCnt++;
			
			Preloader.logger.logLevelStart(99, {"src": Main.lastRoom});
			Preloader.tracker.trackPageview(Preloader.flag + "/go-screen");
			Preloader.tracker.trackEvent("game-over", "source", null, Main.lastRoom);
				
			// game over text
			var goText:FlxText;
			goText = new FlxText(0, (FlxG.width / 2) - 100, FlxG.width, "You Have Been Slain");
			goText.setFormat(null, 18, 0x000000, "center");
			this.add(goText);
			
			// continue Text
			var continueTxt:FlxText;
			continueTxt = new FlxText(0, (FlxG.width / 2) - 60, FlxG.width, "Press \"SPACE\" to Try Again!\n\nPress \"ESC\" to return to Level Select");
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
            if (FlxG.keys.justPressed("ESCAPE"))
			{
				FlxG.flash(0x000000, 0.5);
				FlxG.switchState(new StageState());
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