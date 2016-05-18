package com.chameleonquest 
{
	import com.chameleonquest.Rooms.*;
	import org.flixel.*;
	
	public class StageState extends FlxState
	{
		private var currIdx:int;
		private var currRoomIdx:int;
		private var stages:Array;
		private var arrow:FlxText;
		private var worldSelected:Boolean = false;
		private var levels:Array = new Array();
		private var worlds:Array = new Array();
		private var headings:FlxText;
		
		public function StageState() {
			super();
			
			currIdx = 0;
			currRoomIdx = 0;
			
			var room1:Array = [
			new Room1_1State(), 
			new Room1_2State(),
			new Room1_3State(),
			new Room1_4State(),
			new Room1_5State(),
			new Room1_6State(),
			new Room1_7State()
			];
			var room2:Array = [
			new Room2_1State(),
			new Room2_2State(),
			new Room2_3State(),
			new Room2_4State(),
			new Room2_5State(),
			new Room2_6State()
			];
			
			var room3:Array = [
			new Room3_1State(),
			new Room3_2State()
			];
			
			stages = [
			room1, room2, room3
			];
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
			
			headings = new FlxText(30, 60, FlxG.width, "LEVEL                 BEST TIME      RATING");
			headings.setFormat(null, 12, 0x000000, "left");
			this.add(headings);
			headings.visible = false;
			
			// Arrow select
			arrow = new FlxText(5, 78, FlxG.width, ">");
			arrow.setFormat(null, 12, 0xFF0000, "left");
			this.add(arrow);
			
			addWorld(0, "World 1");
			addWorld(1, "World 2");
			
			for (var i :int = 0; i < worlds.length; i++)
			{
				worlds[i].visible = true;
			}
			
			// Levels

			addStage(0, 0, "1-1: The Quest Begins\t\t\t");
			addStage(0, 1, "1-2: Predators\t\t\t\t\t");
			addStage(0, 2, "1-3: Into The Depths\t\t\t");
			addStage(0, 3, "1-4: Long Way Around\t\t\t");
			addStage(0, 4, "1-5: All The Way Down\t\t\t");
			addStage(0, 5, "1-6: Powered By Buttons\t\t");
			addStage(0, 6, "1-7: The Water Guardian\t\t");
			
			addStage(1, 0, "2-1: Just Grate\t\t\t\t\t");
			addStage(1, 1, "2-2: Choose Your Tools\t\t\t");
			addStage(1, 2, "2-3: Rise From The Depths\t\t");
			addStage(1, 3, "2-4: Enemy At The Gate\t\t\t");
			addStage(1, 4, "2-5: Putting It All Together\t\t");
			addStage(1, 5, "2-6: Stairway to (Heaven?)\t\t");
			
		}
		
		override public function update():void
		{
			// Start the play state
			if (FlxG.keys.justPressed("UP"))
			{
				if (currIdx > 0) 
				{
					currIdx--;
					arrow.y = 78 + currIdx * 20;
				}
			} 
			else if (FlxG.keys.justPressed("DOWN"))
			{
				if ((worldSelected && currIdx < stages[currRoomIdx].length - 1 && currIdx + currRoomIdx * 7 < Main.bestRoom)
						|| (!worldSelected && currIdx < stages.length - 1 && (currIdx + 1) * 7 <= Main.bestRoom))
				{
					currIdx++;
					arrow.y = 78 + currIdx * 20;
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
					arrow.y = 78;
					toLevelMenu();
					worldSelected = true;
					FlxG.flash(0xff000000, .2);
					
				}
			}
			
			if (FlxG.keys.justPressed("ESCAPE") && worldSelected)
			{
				currIdx = 0;
				arrow.y = 78;
				toWorldMenu();
				worldSelected = false;
				FlxG.flash(0x000000, .2);
			}
			
			if (FlxG.keys.pressed("R") && FlxG.keys.pressed("S") && FlxG.keys.pressed("ENTER"))
			{
				Main.resetSaveData();
				Main.saveGame();
			}
			
			
			
			super.update();
		}
		
		private function onFade():void
		{
			FlxG.switchState(stages[currRoomIdx][currIdx]);
		}
		
		private function toLevelMenu():void
		{
			for (var i : int = 0; i < levels.length; i++)
			{
				if (currRoomIdx * 7 <= i && i < currRoomIdx * 7 + 7)
				{
					levels[i].visible = true;
				}
				else
				{
					levels[i].visible = false;
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
				text = text + (Main.bestTimes[x * 7 + y + 1] as Number).toPrecision(5) + " \t\t\t\t";
			}
			for (var stars:int = Main.stars[x * 7 + y + 1]; stars > 0; stars--)
			{
				text += "*";
			}
			stage = new FlxText(15, 80 + y * 20, FlxG.width, text);
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
			var stage:FlxText = new FlxText(15, 80 + y * 20, FlxG.width, text);
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