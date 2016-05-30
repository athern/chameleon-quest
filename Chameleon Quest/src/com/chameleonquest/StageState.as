package com.chameleonquest 
{
	import com.chameleonquest.Rooms.*;
	import org.flixel.*;
	
	public class StageState extends FlxState
	{
		private var currIdx:int;
		private var currRoomIdx:int;
		private var arrow:FlxText;
		private var worldSelected:Boolean = false;
		private var levels:Array = new Array();
		private var worlds:Array = new Array();
		private var starRows:Array = new Array();
		private var headings:FlxText;
		
		public function StageState() {
			super();
			
			currIdx = 0;
			currRoomIdx = 0;
		}
		
		override public function create():void
		{
			// add simple bg
			add(new Background(0, 0, 1, false));
			add(new Background(16, 0, 1, false));
			
			// Title
			var levelTitle:FlxText;
			levelTitle = new FlxText(0, 0, FlxG.width, "Level Select");
			levelTitle.setFormat(null, 16, 0x000000, "center");
			this.add(levelTitle);
			
			var controlText:FlxText;
			controlText = new FlxText(0, 25, FlxG.width, "UP and DOWN to scroll\t\tSPACE to select\nM to toggle sound\t\tR+S+ENTER to reset save data");
			controlText.setFormat(null, 8, 0x000000, "center");
			add(controlText);
			
			headings = new FlxText(30, 46, FlxG.width, "LEVEL\t\t\t\t\t\t\tBEST TIME\t  RATING");
			headings.setFormat(null, 8, 0x000000, "left");
			this.add(headings);
			headings.visible = false;
			
			// Arrow select
			arrow = new FlxText(5, 58, FlxG.width, ">");
			arrow.setFormat(null, 12, 0xFF0000, "left");
			this.add(arrow);
			
			addWorld(0, "World 1 - The Meadows");
			addWorld(1, "World 2 - The Swamp");
			addWorld(2, "World 3 - The Volcano");
			
			for (var i :int = 0; i < worlds.length; i++)
			{
				worlds[i].visible = true;
			}
			
			// Levels

			addStage(0, 0, "1-1: The Quest Begins\t\t\t\t");
			addStage(0, 1, "1-2: Predators\t\t\t\t\t\t");
			addStage(0, 2, "1-3: Into The Depths\t\t\t\t");
			addStage(0, 3, "1-4: Long Way Around\t\t\t\t");
			addStage(0, 4, "1-5: All The Way Down\t\t\t\t");
			addStage(0, 5, "1-6: Powered By Buttons\t\t\t");
			addStage(0, 6, "1-7: The Water Guardian\t\t\t");
			
			addStage(1, 0, "2-1: Just Grate\t\t\t\t\t\t");
			addStage(1, 1, "2-2: Choose Your Tools\t\t\t\t");
			addStage(1, 2, "2-3: Rise From The Depths\t\t\t");
			addStage(1, 3, "2-4: Enemy At The Gate\t\t\t\t");
			addStage(1, 4, "2-5: Putting It All Together\t\t\t");
			addStage(1, 5, "2-6: Stairway to (Heaven?)\t\t\t");
			addStage(1, 6, "2-7: The Fire Guardian\t\t\t\t");
			
			addStage(2, 0, "3-1: You Have To Burn The Ropes\t");
			addStage(2, 1, "3-2: Chameleona Jones\t\t\t\t");
			addStage(2, 2, "3-3: Shifty Business\t\t\t\t\t");
			addStage(2, 3, "3-4: Light The Fuse\t\t\t\t\t");
			addStage(2, 4, "3-5: We Have Liftoff\t\t\t\t\t");
			addStage(2, 5, "3-6: Pinball Wizard\t\t\t\t\t");
			addStage(2, 6, "3-7: The Earth Guardian\t\t\t");
			
		}
		
		override public function update():void
		{
			
			if (FlxG.keys.justPressed("M"))
			{
				FlxG.mute = !FlxG.mute;
			}
			// Start the play state
			if (FlxG.keys.justPressed("UP"))
			{
				if (currIdx > 0) 
				{
					currIdx--;
					arrow.y = 58 + currIdx * 25;
				}
			} 
			else if (FlxG.keys.justPressed("DOWN"))
			{
				if ((worldSelected && currIdx < 6 && currIdx + currRoomIdx * 7 < Main.bestRoom)
						|| (!worldSelected && currIdx < 2 && (currIdx + 1) * 7 <= Main.bestRoom))
				{
					currIdx++;
					arrow.y = 58 + currIdx * 25;
				}
			}
			
			
			if (FlxG.keys.justPressed("SPACE"))
			{
				if (worldSelected)
				{
					FlxG.flash(0x000000, 0.75);
					FlxG.fade(0xff000000, 0.5, onFade);
				}
				else
				{
					currRoomIdx = currIdx;
					currIdx = 0;
					arrow.y = 58;
					toLevelMenu();
					worldSelected = true;
					FlxG.flash(0xff000000, .2);
					
				}
			}
			
			if (FlxG.keys.justPressed("ESCAPE") && worldSelected)
			{
				currIdx = 0;
				arrow.y = 58;
				toWorldMenu();
				worldSelected = false;
				FlxG.flash(0x000000, .2);
			}
			
			if (FlxG.keys.pressed("R") && FlxG.keys.pressed("S") && FlxG.keys.pressed("ENTER"))
			{
				Main.resetSaveData();
				Main.saveGame();
				FlxG.switchState(new MenuState());
			}
			
			
			
			super.update();
		}
		
		private function onFade():void
		{
			FlxG.switchState(Main.getStage(currRoomIdx*7+currIdx+1));
		}
		
		private function toLevelMenu():void
		{
			for (var i : int = 0; i < levels.length; i++)
			{
				if (currRoomIdx * 7 <= i && i < currRoomIdx * 7 + 7)
				{
					levels[i].visible = true;
					starRows[i].visible = true;
				}
				else
				{
					levels[i].visible = false;
					starRows[i].visible = false;
				}
			}
			for (var j : int = 0; j < worlds.length; j++)
			{
				worlds[j].visible = false;
			}
			headings.visible = true;
		}
		
		private function toWorldMenu():void
		{
			for (var i : int = 0; i < levels.length; i++)
			{
				levels[i].visible = false;
				starRows[i].visible = false;
			}
			for (var j :int = 0; j < worlds.length; j++)
			{
				worlds[j].visible = true;
			}
			headings.visible = false;
		}
		
		private function addStage(x:int, y:int, text:String):void {
			var stage:FlxText;
			if (Main.bestTimes[x * 7 + y + 1] < Number.MAX_VALUE)
			{
				text = text + (Main.bestTimes[x * 7 + y + 1] as Number).toPrecision(5);
			}
			text = text + "\n PAR TIME: " + Main.parTimes[x * 7 + y] + "\t\tACE TIME: " + Main.aceTimes[x * 7 + y]
			starRows.push(new FlxGroup());
			this.add(starRows[x*7+y] as FlxGroup);
			(starRows[x*7+y] as FlxGroup).visible = false;
			for (var stars:int = 0; stars < 3; stars++)
			{
				(starRows[x*7+y] as FlxGroup).add(new Star(260 + 13 * stars, 60 + y * 25, Main.stars[x * 7 + y + 1] > stars));
			}
			stage = new FlxText(15, 60 + y * 25, FlxG.width, text);
			if (Main.bestRoom >= x * 7 + y)
			{
				stage.setFormat(null, 8, 0x000000, "left");
			}
			else
			{
				stage.setFormat(null, 8, 0x555555, "left");
			}
			this.add(stage);
			stage.visible = false;
			levels.push(stage);
		}
		
		private function addWorld(y:int, text:String):void {
			var starsForThisArea:int = 0;
			for (var i :int = y * 7; i < (y + 1) * 7; i++)
			{
				starsForThisArea += Main.stars[i+1];
			}
			var stage:FlxText = new FlxText(15, 60 + y * 25, FlxG.width, text + "\t\t\tStars: " + starsForThisArea + "/21");
			if (Main.bestRoom >= y * 7)
			{
				stage.setFormat(null, 8, 0x000000, "left");
			}
			else
			{
				stage.setFormat(null, 8, 0x555555, "left");
			}
			this.add(stage);
			stage.visible = false;
			worlds.push(stage);
		}
	}

}