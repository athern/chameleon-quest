package com.chameleonquest 
{
	import org.flixel.*;

	
	public class HeartBar extends FlxGroup
	{
		private var hearts:Array;
		
		public function HeartBar() 
		{
			super();
			hearts = [new Heart(0, 0), new Heart(16, 0), new Heart(32, 0)];
			this.add(hearts[0]);
			this.add(hearts[1]);
			this.add(hearts[2]);
		}
		
	}

}