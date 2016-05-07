package com.chameleonquest.Objects 
{
	import adobe.utils.CustomActions;
	import com.chameleonquest.Player;
	import org.flixel.*;
	/**
	 * ...
	 * @author Cindy
	 */
	public class Pulley extends FlxGroup
	{
		
		private var platform1:Platform;
		private var plat1Obj:Array;
		private var platform2:Platform;
		private var plat2Obj:Array;
		
		public function Pulley(X1:int, Y1:int, X2:int, Y2:int) 
		{
			super();
			platform1 = new PlatformOnChain(X1, Y1);
			platform2 = new PlatformOnChain(X2, Y2);
			
			plat1Obj = new Array();
			plat2Obj = new Array();
			
			this.add(platform1);
			this.add(platform2);
		}
		
		public function addWeight(weightObj:FlxSprite, p:Platform):void {
			if (p == platform1) {
				if (plat1Obj.indexOf(weightObj) != -1) {
					platform1.y += 10;
					platform2.y -= 10;
				}
				
			} else if (p == platform2) {
				if (plat2Obj.indexOf(weightObj) != -1) {
					platform1.y -= 10;
					platform2.y += 10;
				}
			}
		}
		
	}

}