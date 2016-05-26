package com.chameleonquest.Enemies 
{
	import com.chameleonquest.Projectiles.Projectile;
	
	public class SpikedWoodBlock extends Enemy
	{
		protected static const GRAVITY:int =800;
		
		[Embed(source = "../../../../assets/spikedwoodblock.png")]
		protected var img:Class;
		
		public function SpikedWoodBlock(Xindex:int, Yfloorindex:int) 
		{
			super(Xindex*16-8, Yfloorindex*16-48);
			loadGraphic(img);
			acceleration.y = GRAVITY;
			drag.x = 200;
			power = 6;
		}
		
		override public function hitWith(bullet:Projectile):void
		{
			
		}
		
	}

}