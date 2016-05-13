package com.chameleonquest.Chameleons 
{
	public class EarthChameleon extends Chameleon
	{
		[Embed(source = "../../../../assets/brownchameleon.png")]public var brownChameleon:Class;
		
		public function EarthChameleon(Xindex:int,Yfloorindex:int, indexedPoint:Boolean = true) 
		{
			super(Xindex, Yfloorindex, indexedPoint);
            loadGraphic(brownChameleon, true, true, 38, 16);			
			width = 20;  
			offset.x = 9;
			height = 14;
			offset.y = 2;
			
			this.tongue = null; // todo: we may change this
			this.type = Chameleon.EARTH;
		}
		
		public static function cloneFrom(reference:Chameleon):Chameleon
		{
			var clone:Chameleon = new EarthChameleon(reference.x, reference.y, false);
			clone.facing = reference.facing;
			clone.velocity.x = reference.velocity.x;
			clone.velocity.y = reference.velocity.y;
			clone.health = reference.health;
			clone.jumpPhase = reference.jumpPhase;
			
			return clone;
		}
		
	}

}