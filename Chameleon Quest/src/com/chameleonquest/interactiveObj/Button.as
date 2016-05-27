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
		[Embed(source = "../../../../assets/big-red-button.png")]public var bigRedImg:Class;
		
		static public const RED:uint = 0x00;
		static public const BLUE:uint = 0x01;
		static public const GREEN:uint = 0x02;
		static public const YELLOW:uint = 0x03;
		static public const BIGRED:uint = 0x04;
		
		private var isHit:Boolean;
		private var timer:int;
		private var count:int = 0;
		

		
		public function Button(Xindex:int, Yindex:int, obj:FlxSprite, fun:Function, t:int=-1, r:int = 0, type:uint=RED) 
		{
			
			super(Xindex * 16, Yindex * 16);
			loadButtonSprite(type);
			timer = t;
			angle = r;
			immovable = true;
			addAnimation("DOWN", [0]);
			addAnimation("UP", [1]);
			
			controlledObj = obj;
			callback = fun;
			
			isHit = false;
			immovable = true;
			
			play("UP");
		}
		
		private function loadButtonSprite(type:uint):void {
			if (type == RED) {
				loadGraphic(redImg, true, true, 16, 16);
			} else if (type == BLUE) {
				loadGraphic(blueImg, true, true, 16, 16);
			} else if (type == GREEN) {
				loadGraphic(greenImg, true, true, 16, 16);
			} else if (type == YELLOW) {
				loadGraphic(yellowImg, true, true, 16, 16);
			} else if (type == BIGRED) {
				loadGraphic(bigRedImg, true, true, 128, 128);
				scale.x = .5;
				scale.y = .5;
				width = 64;
				height = 32;
				offset.x = 32;
				offset.y = 64;
			}
			
		}
		
		// hit the button
		override public function hit(bullet:Projectile):void {
			if (!isHit && width == 16) {
				activate();
			}
			
		}
		
		public function activate():void {
			isHit = true;
			play("DOWN");
			count = timer;
			callback(controlledObj);
		}
		
		override public function update():void {
			super.update();
			if (count > 0)
			{
				count--;
				if (count == 0) {
					play("UP");
					isHit = false;
				}
			}
		}
		
	}

}