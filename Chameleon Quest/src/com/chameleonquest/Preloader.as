package com.chameleonquest 
{
	import com.chameleonquest.Logger;
	import org.flixel.*;
	import org.flixel.system.FlxPreloader;
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	
	public class Preloader extends FlxPreloader
	{
		
		public static var tracker:GATracker;
		public static var logger:Logger;
		
		public function Preloader():void
		{
			// Google analytics
			tracker = new GATracker(this, "UA-77647600-1", "AS3", false);
			
			// Logger
			var gid:uint = 119; //INSERT TEAM GID HERE
			var gname:String = "cgs_gc_chameleon_quest_log";
			var skey:String = "b4b8c257ae5ef1df0bf399923638ad6c";
			
			//category id; treat this like a "version id" or "release number" to help differentiate data from different versions
			//var cid:int = 1; // FOR DEVELOPMENT
			var cid:int = 3;
			
			logger = Logger.initialize(gid, gname, skey, cid, null); //automatically logs a page load; don't need any parameters

			className = "com.chameleonquest.Main";
			super();
		}
		
	}

}