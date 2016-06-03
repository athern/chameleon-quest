package com.chameleonquest 
{
	import com.chameleonquest.Logger;
	import com.google.analytics.debug.DebugConfiguration;
	import org.flixel.*;
	import org.flixel.system.FlxPreloader;
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	
	public class Preloader extends FlxPreloader
	{
		
		public static var tracker:GATracker;
		public static var logger:Logger;
		public static var flag:String;
		
		private static var DEVELOPMENT_FLAG:Boolean = false;	// FOR DEVELOPMENT, SET TO FALSE FOR RELEASE
		
		public function Preloader():void
		{
			// Logger
			var gid:uint = 119; //INSERT TEAM GID HERE
			var gname:String = "cgs_gc_chameleon_quest_log";
			var skey:String = "b4b8c257ae5ef1df0bf399923638ad6c";
			
			var cid:int = 1;
			
			if (DEVELOPMENT_FLAG) {
				flag = "dev";
				// Google analytics
				tracker = new GATracker(this, "UA-77647600-1", "AS3", true); // FOR DEVELOPMENT
				//category id; treat this like a "version id" or "release number" to help differentiate data from different versions
				cid = 1; // FOR DEVELOPMENT
			} else {
				// FOR RELEASE
				flag = "prod";
				// Google analytics
				tracker = new GATracker(this, "UA-77647600-1", "AS3", false);
				//category id; treat this like a "version id" or "release number" to help differentiate data from different versions
				cid = 6;
			}
			
			logger = Logger.initialize(gid, gname, skey, cid, null); //automatically logs a page load; don't need any parameters
			trace("Logging with CID: " + cid);
			className = "com.chameleonquest.Main";
			super();
		}
		
	}

}