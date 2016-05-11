package com.chameleonquest 
{
	import org.flixel.*;
	import org.flixel.system.FlxPreloader;
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	
	public class Preloader extends FlxPreloader
	{
		
		public static var tracker:GATracker;
		
		public function Preloader():void
		{
			tracker = new GATracker(this, "UA-77647600-1", "AS3", false);
			className = "com.chameleonquest.Main";
			super();
		}
		
	}

}