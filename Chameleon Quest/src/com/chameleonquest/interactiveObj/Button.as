package com.chameleonquest.interactiveObj 
{
	import org.flixel.*;
	
	public class Button extends InteractiveObj
	{
		
		[Embed(source = "../../../../assets/button.png")]public var buttonImg:Class;
		
		private var isHit:Boolean;
		private var timer:int;
		private var count:int = 0;
		
		public function Button(Xindex:int, Yindex:int, t:int=-1, r:int = 0) 
		{
			
			super(Xindex * 16, Yindex * 16);
			loadGraphic(buttonImg, true, true, 128, 128);
			scale.x = 0.125;
			scale.y = 0.125;
			width = 16;  
			offset.x = 56;
			height = 6;
			offset.y = 62;
			timer = t;
			angle = r;
			if (r == 0)
			{
				y -= 10;
			}
			if (r == 180)
			{
				y += 6;
			}
			immovable = true;
			addAnimation("DOWN", [0]);
			addAnimation("UP", [1]);
			
			isHit = false;
			
			play("UP");
		}
		
		// hit the button
		override public function hit():void {
			if (!isHit) {
				isHit = true;
				height = 4;
				offset.y = 66
				this.y += 4
				play("DOWN");
				count = timer;
			}
			
		}
		
		override public function update():void {
			super.update();
			if (count > 0)
			{
				count--;
				if (count == 0) {
					offset.y = 62;
					this.y -= 4;
					play("UP");
					isHit = false;
				}
			}
		}
		
	}

}