package com.chameleonquest.interactiveObj 
{
	import org.flixel.*;
	import com.chameleonquest.Projectiles.*;
	
	public class WaterWheel extends InteractiveObj
	{
		
		[Embed(source = "../../../../assets/water-wheel.png")]public var wheelImg:Class;
		
		public function WaterWheel(Xindex:int, Yindex:int, obj:FlxSprite, fun:Function) 
		{
			super(Xindex * 16, Yindex * 16);
			loadGraphic(wheelImg, true, true, 128, 128);
			scale.x = 0.375;
			scale.y = 0.375;
			width = 48;  
			offset.x = 40;
			height = 48;
			offset.y = 40;
			controlledObj = obj;
			callback = fun;
			immovable = true;
		}
		
		override public function hit(bullet:Projectile):void {
			angle += 5;
			callback(controlledObj);
		}
	}

}