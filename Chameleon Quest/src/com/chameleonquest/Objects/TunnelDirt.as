package com.chameleonquest.Objects 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	public class TunnelDirt extends FlxSprite
	{
		[Embed(source = "../../../../assets/dirt.png")] public var dirt:Class;
		public static const SPRITE_WIDTH:Number = 33.5;
		public static const SPRITE_HEIGHT:Number = 24;
		
		private var shaking:Boolean;
		private var SHAKE_TIME:Number = .5;
		private var shake_elapsed:Number;
		
		private var baseY:Number;
		
		public function TunnelDirt(X:Number, Y:Number, sideways:Boolean)
		{
			super(X, Y);
			this.baseY = Y;
			loadGraphic(dirt, false, true);
			scale.x = 0.25;
			scale.y = 0.25;
			width = SPRITE_WIDTH;
			height = SPRITE_HEIGHT;
			offset.x = SPRITE_WIDTH + SPRITE_WIDTH / 2;
			offset.y = SPRITE_HEIGHT;
		
			if (sideways)
			{
				this.angle = -90.
			}
			
			this.shaking = false;
			this.shake_elapsed = 0;
		}
		
		public function shake(turnOn:Boolean):void
		{
			if (!turnOn) {
				this.angle = 0;
				this.angularVelocity = 0;
				this.velocity.y = 0;
				this.y = this.baseY;
			}
			
			this.shaking = turnOn;
			this.shake_elapsed = 0;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (this.shaking && this.shake_elapsed > SHAKE_TIME)
			{
				this.angularVelocity = (int)(FlxG.random() * 100) % 2 == 0 ? 45 : -45;
				this.velocity.y = (int)(FlxG.random() * 100) % 2 == 0 ? 5 : -5;
			}
			
			this.shake_elapsed += FlxG.elapsed;
		}
	}

}