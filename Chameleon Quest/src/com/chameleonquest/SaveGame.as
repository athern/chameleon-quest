package com.chameleonquest 
{
	public class SaveGame 
	{
		private const SAVE_NAME:String = "com.chameleonquest";
		private var save:FlxSaveWrapper;
		
		public function SaveGame() 
		{
			save = new FlxSaveWrapper();
			save.init(SAVE_NAME, setupSaveFile, loadGame);
		}
		
		// loads game from save file
		public function loadGame():void
		{
			trace("SaveGame - loadGame()");
			Main.bestRoom = bestRoom;
			Main.bestTimes = bestTimes;
			Main.stars = stars;			
		}
		
		// sets defaults to save file
		public function setupSaveFile():void
		{
			trace("SaveGame - setupSaveFile()");
			bestRoom = 0;
			bestTimes = new Array();
			stars = new Array();
			for (var i:int = 0; i < 35; i++)
			{
				bestTimes.push(Number.MAX_VALUE);
				stars.push(0);
			}
		}
		
		// saves current progress
		public function saveGameProgress():void
		{			
			trace("SaveGame - saveGameProgress()");
			bestRoom = Main.bestRoom;
			bestTimes = Main.bestTimes;
			stars = Main.stars;
		}
		
		public function get bestRoom():int
		{
			return save.data.bestRoom;
		}
		
		public function set bestRoom(newBestRoom:int):void
		{
			save.data.bestRoom = newBestRoom;
			save.updateLocalCopy();
		}
		
		public function get bestTimes():Array
		{
			return save.data.bestTimes;
		}
		
		public function set bestTimes(newBestTimes:Array):void
		{
			save.data.bestTimes = newBestTimes;
			save.updateLocalCopy();
		}
		
		public function get stars():Array
		{
			return save.data.stars;
		}
		
		public function set stars(newStars:Array):void
		{
			save.data.stars = newStars;
			save.updateLocalCopy();
		}
	}

}