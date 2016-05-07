package com.chameleonquest.Objects 
{
	import adobe.utils.CustomActions;
	import com.chameleonquest.Chameleons.Player;
	import org.flixel.*;
	import mx.utils.ObjectUtil;

	public class Pulley extends FlxGroup
	{
		
		private var platform1:PlatformOnChain;
		private var plat1Obj:Array;
		private var plat1Y:int;
		private var bar1Y:int;
		
		private var platform2:PlatformOnChain;
		private var plat2Obj:Array;
		private var plat2Y:int;
		private var bar2Y:int;
		
		private var VERTICAL_VEL:int = 20;
		
		public function Pulley(X1:int, Y1:int, X2:int, Y2:int) 
		{
			super();
			platform1 = new PlatformOnChain(X1, Y1);
			platform2 = new PlatformOnChain(X2, Y2);
			
			plat1Obj = new Array();
			plat2Obj = new Array();
			
			// original Y position
			plat1Y = Y1;
			plat2Y = Y2;
			
			// threshold for Y movement
			bar1Y = plat1Y;
			bar2Y = plat2Y;
						
			this.add(platform1);
			this.add(platform2);
		}
		
		override public function update():void
		{
			
			if (platform1.velocity.y > 0 && platform1.y >= bar1Y) {
				platform1.velocity.y = 0;
			} else if (platform1.velocity.y < 0 && platform1.y <= bar1Y) {
				platform1.velocity.y = 0;
			}
			
			if (platform2.velocity.y > 0 && platform2.y >= bar2Y) {
				platform2.velocity.y = 0;
			} else if (platform2.velocity.y < 0 && platform2.y <= bar2Y) {
				platform2.velocity.y = 0;
			}
			
			var newbar1Y:int = plat1Y - 16 * (plat2Obj.length - plat1Obj.length);
			var newbar2Y:int = plat2Y - 16 * (plat1Obj.length - plat2Obj.length);
			
			if (newbar1Y != bar1Y) {
				if (newbar1Y > bar1Y) {
					platform1.velocity.y = VERTICAL_VEL;
				} else {
					platform1.velocity.y = -1 * VERTICAL_VEL;
				}
				
				bar1Y = newbar1Y;
			}
			
			if (newbar2Y != bar2Y) {
				if (newbar2Y > bar2Y) {
					platform2.velocity.y = VERTICAL_VEL;
				} else {
					platform2.velocity.y = -1 * VERTICAL_VEL;
				}
				
				bar2Y = newbar2Y
			}
			
			// TODO: the separation with it's objects is still not perfect
			for (var i:int = 0; i < plat1Obj.length; i++) {
				if (FlxObject.separate(platform1, plat1Obj[i]) && platform1.y > (plat1Obj[i] as FlxSprite).y) {
					plat1Obj.splice(i, 1);
					i--;
				}
			}
			
			for (i = 0; i < plat2Obj.length; i++) {
				if (FlxObject.separate(platform2, plat2Obj[i]) && platform2.y > (plat2Obj[i] as FlxSprite).y) {
					plat2Obj.splice(i, 1);
					i--;
				}
			}
			
			super.update()
		}
		
		public function addWeight(weightObj:FlxSprite, p:PlatformOnChain):void {
			if (p.justTouched(FlxObject.UP)) {
				if (weightObj.x > platform1.x && weightObj.x < platform1.x + platform1.width) {
					if (plat1Obj.indexOf(weightObj) == -1) {
						plat1Obj.push(weightObj);
					}
					
				} else if (weightObj.x > platform2.x && weightObj.x < platform2.x + platform2.width) {
					if (plat2Obj.indexOf(weightObj) == -1) {
						plat2Obj.push(weightObj);
					}
				}
			}
		}
		
	}

}