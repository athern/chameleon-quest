package com.chameleonquest 
{
	import com.chameleonquest.Rooms.*;
	import org.flixel.*;
	
	public class StageState extends FlxState
	{
		private var currIdx:int;
		private var stages:Array;
		private var arrow:FlxText;
		
		public function StageState() {
			super();
			
			currIdx = 0;
			stages = [
			new Room1_1State(), 
			new Room1_2State(),
			new Room1_3State(),
			new Room1_4State(),
			new Room1_5State(),
			new Room1_6State(),
			new Room3_1State(),
			new Room3_2State()
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
			arrow.setFormat(null, 12, 0x000000, "left");
			this.add(arrow);
			
			// Levels
			var stage1:FlxText;
			stage1 = new FlxText(30, 30, FlxG.width, "1-1");
			stage1.setFormat(null, 12, 0x000000, "left");
			this.add(stage1);
			
			var stage2:FlxText;
			stage2 = new FlxText(30, 50, FlxG.width, "1-2");
			stage2.setFormat(null, 12, 0x000000, "left");
			this.add(stage2);
			
			var stage3:FlxText;
			stage3 = new FlxText(30, 70, FlxG.width, "1-3");
			stage3.setFormat(null, 12, 0x000000, "left");
			this.add(stage3);
			
			var stage4:FlxText;
			stage4 = new FlxText(30, 90, FlxG.width, "1-4");
			stage4.setFormat(null, 12, 0x000000, "left");
			this.add(stage4);
			
			var stage5:FlxText;
			stage5 = new FlxText(30, 110, FlxG.width, "1-5");
			stage5.setFormat(null, 12, 0x000000, "left");
			this.add(stage5);	
			
			var stage6:FlxText;
			stage6 = new FlxText(30, 130, FlxG.width, "1-6");
			stage6.setFormat(null, 12, 0x000000, "left");
			this.add(stage6);
			
			var stage7:FlxText;
			stage7 = new FlxText(30, 150, FlxG.width, "3-1");
			stage7.setFormat(null, 12, 0x000000, "left");
			this.add(stage7);
			
			var stage8:FlxText;
			stage8 = new FlxText(30, 170, FlxG.width, "3-2");
			stage8.setFormat(null, 12, 0x000000, "left");
			this.add(stage8);
		}
		
		override public function update():void
		{
			// Start the play state
			if (FlxG.keys.justPressed("UP"))
			{
				if (currIdx > 0) 
				{
					currIdx--;
					arrow.y = 30 + currIdx * 20;
				}
			} 
			else if (FlxG.keys.justPressed("DOWN"))
			{
				if (currIdx < stages.length - 1)
				{
					currIdx++;
					arrow.y = 30 + currIdx * 20;
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
			FlxG.switchState(stages[currIdx]);
		}
	}

}