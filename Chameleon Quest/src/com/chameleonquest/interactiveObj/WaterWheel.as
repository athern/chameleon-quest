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
			super(Xindex * 16, Yindex * 16);
			loadGraphic(wheelImg, true, true, 48, 48);
			controlledObj = obj;
			callback = fun;
			immovable = true;
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