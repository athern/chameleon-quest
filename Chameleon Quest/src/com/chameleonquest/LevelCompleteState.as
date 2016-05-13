package com.chameleonquest 
{
	import com.chameleonquest.Rooms.*;
	import org.flixel.*;

	public class LevelCompleteState extends FlxState
	{
		protected var t:Number;
		protected var par:Number;
		protected var ace:Number;
		
		public function LevelCompleteState(time:Number=0, parTime:Number=0, aceTime:Number=0)
		{
			super();
			t = time;
			par = parTime;
			ace = aceTime;
		}
		
		
		override public function create():void
		{			
			var goText:FlxText;
			goText = new FlxText(0, 40, FlxG.width, "Level complete!");
			goText.setFormat(null, 18, 0x000000, "center");
			this.add(goText);
			
			var timeText:FlxText;
			timeText = new FlxText(0, 80, FlxG.width, "Time: " + t.toPrecision(5));
			timeText.setFormat(null, 14, 0x000000, "center");
			this.add(timeText);
			
			// continue Text
			var continueTxt:FlxText;
			continueTxt = new FlxText(0, 120, FlxG.width, "SPACE - Continue");
			continueTxt.setFormat(null, 12, 0x000000, "center");
			this.add(continueTxt);
			
			var menuTxt:FlxText;
			menuTxt = new FlxText(0, 160, FlxG.width, "ESCAPE - Level Select");
			menuTxt.setFormat(null, 12, 0x000000, "center");
			add(menuTxt);
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
			FlxG.switchState(PlayState.getStage(Main.lastRoom + 1));
		
		}
	}

}