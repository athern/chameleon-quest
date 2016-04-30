package com.chameleonquest 
{
	import org.flixel.*;
	
	public class StageState extends FlxState
	{
		private var currIdx:int;
		private var stages:Array;
		private var arrow:FlxText;
		
		public function StageState() {
			super();
			
			currIdx = 0;
			stages = [new Room1_1State(), new Room1_2State()];
		}
		
		override public function create():void
		{
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
			stage2 = new FlxText(30, 60, FlxG.width, "1-2");
			stage2.setFormat(null, 12, 0x000000, "left");
			this.add(stage2);
			
			var stage3:FlxText;
			stage3 = new FlxText(30, 90, FlxG.width, "Water stage 1");
			stage3.setFormat(null, 12, 0xd3d3d3, "left");
			this.add(stage3);
		}
		
		override public function update():void
		{
			// Start the play state
			if (FlxG.keys.justPressed("UP"))
			{
				if (currIdx > 0) 
				{
					currIdx--;
					arrow.y = (currIdx + 1) * 30;
				}
			} 
			else if (FlxG.keys.justPressed("DOWN"))
			{
				if (currIdx < stages.length - 1)
				{
					currIdx++;
					arrow.y = (currIdx + 1) * 30;
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