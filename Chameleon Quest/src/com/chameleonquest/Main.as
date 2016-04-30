package com.chameleonquest
{
	import org.flixel.*; //Allows you to refer to flixel objects in your code
    
	[SWF(width = "640", height = "480", backgroundColor = "#000000")] //Set the size and color of the Flash file
	[Frame(factoryClass = "com.chameleonquest.Preloader")]
 
    public class Main extends FlxGame
    {
		public static var lastRoom:int = 0;
		
        public function Main()
        {
            super(320,240,MenuState,2); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
        }
    }
	
}