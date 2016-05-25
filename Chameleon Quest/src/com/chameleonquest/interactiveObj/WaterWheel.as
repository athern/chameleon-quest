package com.chameleonquest.interactiveObj 
{
	import com.chameleonquest.Objects.StoneGate;
	import org.flixel.*;
	import com.chameleonquest.Projectiles.*;
	
	public class WaterWheel extends InteractiveObj
	{
		
		[Embed(source = "../../../../assets/water-wheel.png")]public var wheelImg:Class;
		
		public function WaterWheel(Xindex:int, Yindex:int, obj:FlxSprite, fun:Function) 
		{
			super(Xindex * 16+12, Yindex * 16);
			loadGraphic(wheelImg, true, true, 48, 48);
			controlledObj = obj;
			callback = fun;
			immovable = true;
			FlxG.visualDebug = true;
			width = 22;
			offset.x = 12;
		}
		
		override public function hit(bullet:Projectile):void {
			angle += 5;
			callback(controlledObj);
		}
		
		override public function update():void {
			super.update();
			if (controlledObj is StoneGate && (controlledObj as StoneGate).isFalling())
			{
				angle--;
			}
		}
	}

}