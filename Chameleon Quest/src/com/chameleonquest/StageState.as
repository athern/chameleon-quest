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
			new Room1_7State(),
			new Room2_1State(),
			new Room2_2State(),
			new Room2_3State(),
			new Room2_4State(),
			new Room2_5State(),
			new Room3_1State(),
			new Room3_2State()
			]
			
			var room2:Array = [
			new Room2_1State(),
			new Room2_2State(),
			new Room2_3State(),
			new Room2_4State(),
			new Room2_5State()
			]
			
			var room3:Array = [
			new Room3_1State(),
			new Room3_2State()
			]
			
			
			
			stages = [
			room1, 
			room2, 
			room3
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
			levelTitle.setFormat(null, 12, 0x000000, "center");
			this.add(levelTitle);
			
			// Arrow select
			arrow = new FlxText(15, 30, FlxG.width, ">");
			arrow.setFormat(null, 12, 0xFF0000, "left");
			this.add(arrow);
			
			// Levels
			addStage(0, 0, "1-1");
			addStage(0, 1, "1-2");
			addStage(0, 2, "1-3");
			addStage(0, 3, "1-4");
			addStage(0, 4, "1-5");
			addStage(0, 5, "1-6");
			addStage(0, 6, "1-7");
			
			addStage(0, 7, "2-1");
			addStage(0, 8, "2-2");
			addStage(0, 9, "2-3");
			addStage(0, 10, "2-4");
			addStage(0, 11, "2-5");
			
			//addStage(0, 12, "3-1");
			//addStage(0, 13, "3-2");
			
		}
		
		override public function update():void
		{
			// Start the play state
			if (FlxG.keys.justPressed("UP"))
			{
				if (currIdx > 0) 
				{
					currIdx--;
					arrow.y = 30 + currIdx * 15;
				}
			} 
			else if (FlxG.keys.justPressed("DOWN"))
			{
				if (currIdx < stages[currRoomIdx].length - 1)
				{
					currIdx++;
					arrow.y = 30 + currIdx * 15;
				}
			}
			else if (FlxG.keys.justPressed("LEFT"))
			{
				if (currRoomIdx > 0)
				{
					currRoomIdx--;
					arrow.x = 15 + currRoomIdx * 50;
					
					if (stages[currRoomIdx].length <= currIdx) {
						currIdx = stages[currRoomIdx].length - 1;
						arrow.y = 30 + currIdx * 15;
					}
				}
			}
			else if (FlxG.keys.justPressed("RIGHT"))
			{
				if (currRoomIdx < stages.length - 1)
				{
					currRoomIdx++;
					arrow.x = 15 + currRoomIdx * 50;
					
					if (stages[currRoomIdx].length <= currIdx) {
						currIdx = stages[currRoomIdx].length - 1;
						arrow.y = 30 + currIdx * 15;
					}
				}
			}
			
			
			if (FlxG.keys.pressed("SPACE"))
			{
				FlxG.flash(0x000000, 0.75);
				FlxG.fade(0xff000000, 0.5, onFade);
			}
			
			super.update();
		}
		
		private function onFade():void
		{
			FlxG.switchState(stages[currRoomIdx][currIdx]);
		}
		
		private function addStage(x:int, y:int, text:String):void {
			var stage:FlxText;
			if (Main.bestTimes[x * 7 + y + 1] < Number.MAX_VALUE)
			{
				text = text + " : " + (Main.bestTimes[x * 7 + y + 1] as Number).toPrecision(5) + " ";
			}
			for (var stars:int = Main.stars[x * 7 + y + 1]; stars > 0; stars--)
			{
				text += "*";
			}
			stage = new FlxText(30 + x*50, 30 + y*15, FlxG.width, text);
			stage.setFormat(null, 10, 0x000000, "left");
			this.add(stage);
		}
	}

}