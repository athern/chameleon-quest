package com.chameleonquest 
{
	import org.flixel.*;

	
	public class HeartBar extends FlxGroup
	{
		private var hearts:Array;
		private var currIdx:int;
				
		public function HeartBar() 
		{
			super();
			hearts = [new Heart(0, 0), new Heart(16, 0), new Heart(32, 0)];
			this.add(hearts[0]);
			this.add(hearts[1]);
			this.add(hearts[2]);
			
			currIdx = 2;
		}
		
		// Decreases the hearts. Returns true if there is still live hearts.
		public function hit(damage:int):Boolean {
			for (var i:int = 0; i < damage; i++) {
				if (currIdx >= 0) {
					hearts[currIdx].hit();
					if (hearts[currIdx].isEmpty()) {
						currIdx--;
					}
				}
			}
			return !isEmpty();
		}
		
		public function isEmpty():Boolean {
			return currIdx < 0;
		}
	}

}