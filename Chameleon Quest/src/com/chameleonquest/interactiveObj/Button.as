package com.chameleonquest.interactiveObj 
{
	import org.flixel.*;
	import com.chameleonquest.Projectiles.*;
	
	public class Button extends InteractiveObj
	{
		
		[Embed(source = "../../../../assets/button.png")]public var redImg:Class;
		[Embed(source = "../../../../assets/button-blue.png")]public var blueImg:Class;
		[Embed(source = "../../../../assets/button-green.png")]public var greenImg:Class;
		[Embed(source = "../../../../assets/button-yellow.png")]public var yellowImg:Class;
		
		static public const RED:uint = 0x00;
		static public const BLUE:uint = 0x01;
		static public const GREEN:uint = 0x02;
		static public const YELLOW:uint = 0x03;
		
		private var isHit:Boolean;
		private var timer:int;
		private var count:int = 0;
		

		
		public function Button(Xindex:int, Yindex:int, obj:FlxSprite, fun:Function, t:int=-1, r:int = 0, type:uint=RED) 
		{
			
			super(Xindex * 16, Yindex * 16);
			loadButtonSprite(type);
			
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
			else
			{
				y += 6;
			}
			immovable = true;
			addAnimation("DOWN", [0]);
			addAnimation("UP", [1]);
			
			controlledObj = obj;
			callback = fun;
			
			isHit = false;
			immovable = true;
			
			play("UP");
		}
		
		private function loadButtonSprite(type:uint) {
			if (type == RED) {
				loadGraphic(redImg, true, true, 128, 128);
			} else if (type == BLUE) {
				loadGraphic(blueImg, true, true, 128, 128);
			} else if (type == GREEN) {
				loadGraphic(greenImg, true, true, 128, 128);
			} else if (type == YELLOW) {
				loadGraphic(yellowImg, true, true, 128, 128);
			}
			
		}
		
		// hit the button
		override public function hit(bullet:Projectile):void {
			if (!isHit) {
				isHit = true;
				//height = 4;
				//offset.y = 66;
				//this.y += 4;
				play("DOWN");
				count = timer;
				callback(controlledObj);
			}
			
		}
		
		override public function update():void {
			super.update();
			if (count > 0)
			{
				count--;
				if (count == 0) {
					//offset.y = 62;
					//this.y -= 4;
					play("UP");
					isHit = false;
				}
			}
		}
		
	}

}