package com.chameleonquest
{
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	import com.chameleonquest.Rooms.*;
    
	[SWF(width = "640", height = "480", backgroundColor = "#000000")] //Set the size and color of the Flash file
	[Frame(factoryClass = "com.chameleonquest.Preloader")]
 
    public class Main extends FlxGame
    {
		public static var lastRoom:int = 0;
		
		public static var bestTimes:Array = new Array();
		
		public static var stars:Array = new Array();
		
		public static var bestRoom:int = 0;
		
		private static var save:SaveGame;
		
		private static var stages:Array = [
			Room1_1State, 
			Room1_2State,
			Room1_3State,
			Room1_4State,
			Room1_5State,
			Room1_6State,
			Room1_7State,
			Room2_1State,
			Room2_2State,
			Room2_3State,
			Room2_4State,
			Room2_5State,
			Room2_6State,
			Room2_7State,
			Room3_1State,
			Room3_2State,
			Room3_3State,
			Room3_4State,
			Room3_5State,
			Room3_7State
			];
			
		public static var parTimes:Array = [30, 60, 60, 45, 30, 90, 90, 30, 50, 80, 40, 120, 80, 100, 50, 30, 70, 55, 50, 100];
		public static var aceTimes:Array = [ 8, 22, 20, 14, 10, 30, 40, 12, 20, 40, 24,  40, 30,  50, 15, 15, 30, 30, 25, 45];
		
        public function Main()
        {
			
            super(320, 240, MenuState, 2); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
			
			save = new SaveGame()
			
        }
		
		public static function saveGame():void
		{
			if (save == null) 
			{
				save = new SaveGame()
			}
			
			save.saveGameProgress();
		}
		
		public static function resetSaveData():void
		{
			bestRoom = 0;
			bestTimes = new Array();
			stars = new Array();
			for (var i:int = 0; i < 35; i++)
			{
				bestTimes.push(Number.MAX_VALUE);
				stars.push(0);
			}
			save.saveGameProgress();
		}
		
		public static function getStage(number:int):FlxState
		{
			trace(number);
			if(number <= stages.length)
				return (new stages[number-1] as FlxState);
			else
				return new MenuState();
		}
    }
	
}