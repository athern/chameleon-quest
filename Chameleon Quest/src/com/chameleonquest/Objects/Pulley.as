package com.chameleonquest.Objects 
{
	import adobe.utils.CustomActions;
	import com.chameleonquest.Chameleons.Chameleon;
	import org.flixel.*;
	import mx.utils.ObjectUtil;

	public class Pulley extends FlxSprite
	{
		
		public var platform1:PlatformOnChain;
		private var plat1Obj:Array;
		private var plat1Y:int;
		private var bar1Y:int;
		
		public var platform2:PlatformOnChain;
		private var plat2Obj:Array;
		private var plat2Y:int;
		private var bar2Y:int;
		
		private var VERTICAL_VEL:int = 20;
		
		public function Pulley(group:FlxGroup, X1:int, Y1:int, X2:int, Y2:int, height1:int=1, height2:int=1) 
		{
			super( -32, -32);
			platform1 = new PlatformOnChain(X1, Y1, height1);
			platform2 = new PlatformOnChain(X2, Y2, height2);
			platform1.pulley = this;
			platform2.pulley = this;
			
			plat1Obj = new Array();
			plat2Obj = new Array();
			
			// original Y position
			plat1Y = Y1;
			plat2Y = Y2;
			
			// threshold for Y movement
			bar1Y = plat1Y;
			bar2Y = plat2Y;
			
			group.add(platform1);
			group.add(platform2);
			group.add(this);
		}
		
		override public function update():void
		{
			super.update();
			var newbar1Y:int = plat1Y - 16 * (plat2Obj.length - plat1Obj.length);
			var newbar2Y:int = plat2Y - 16 * (plat1Obj.length - plat2Obj.length);
			
			if (newbar1Y != platform1.y) {
				if (newbar1Y > platform1.y) {
					platform1.y++;
				} else {
					platform1.y--;
				}
				
				bar1Y = newbar1Y;
			}
			
			if (newbar2Y != platform2.y) {
				if (newbar2Y > platform2.y) {
					platform2.y++;
				} else {
					platform2.y--;
				}
				
				bar2Y = newbar2Y;
			}
			
			// TODO: the separation with it's objects is still not perfect
			for (var i:int = 0; i < plat1Obj.length; i++) {
				var current:FlxSprite = plat1Obj[i] as FlxSprite;
				if (!(current.y <= platform1.y && current.x + current.width >= platform1.x && 
					current.x <= platform1.x + platform1.width))
				{
					plat1Obj.splice(i, 1);
					i--;
				}
			}
			
			for (i = 0; i < plat2Obj.length; i++) {
				current = plat2Obj[i] as FlxSprite;
				if (!(current.y <= platform2.y && current.x + current.width >= platform2.x && 
					current.x <= platform2.x + platform2.width))
				{
					plat2Obj.splice(i, 1);
					i--;
				}
			}
			
			
		}
		
		public function addWeight(weightObj:FlxSprite):void {
			if (weightObj.x + weightObj.width > platform1.x && weightObj.x < platform1.x + platform1.width && weightObj.y < platform1.y) {
				if (plat1Obj.indexOf(weightObj) == -1) {
					plat1Obj.push(weightObj);
				}
					
			} else if (weightObj.x + weightObj.width > platform2.x && weightObj.x < platform2.x + platform2.width && weightObj.y < platform2.y) {
				if (plat2Obj.indexOf(weightObj) == -1) {
					plat2Obj.push(weightObj);
				}
			}
		}
		
	}

}