package com.chameleonquest
{
	import org.flixel.*; //Allows you to refer to flixel objects in your code
    
	[SWF(width = "640", height = "480", backgroundColor = "#000000")] //Set the size and color of the Flash file
	[Frame(factoryClass = "com.chameleonquest.Preloader")]
 
    public class Main extends FlxGame
    {
		public static var lastRoom:int = 0;
		
		public static var bestTimes:Array = new Array();
		
		public static var stars:Array = new Array();
		
        public function Main()
        {
			for (var i:int = 0; i < 35; i++)
			{
				bestTimes.push(Number.MAX_VALUE);
				stars.push(0);
			}
            super(320, 240, MenuState, 2); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
        }
    }
	
}