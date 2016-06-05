package com.chameleonquest.Objects 
{
	import com.chameleonquest.PlayState;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	public class TunnelEntrance extends FlxSprite
	{
		private var open:Boolean;
		private var sideways:Boolean;
		private var dirt:FlxGroup;
		private var id:int;
		
		public function TunnelEntrance(X:Number, Y:Number, ID:int, sideways:Boolean = false) 
		{
			super(X, Y);
			this.sideways = sideways;
			
			if (sideways)
			{
				angle = -90;
				height = TunnelDirt.SPRITE_WIDTH * 2;  
				width = TunnelDirt.SPRITE_HEIGHT;
			}
			else
			{
				width = TunnelDirt.SPRITE_WIDTH * 4;  
				height = TunnelDirt.SPRITE_HEIGHT;
			}
			
			buildSprite();
			
			//this.x = sideways ? X + TunnelDirt.SPRITE_HEIGHT : X;
			//this.y = sideways ? Y : Y + TunnelDirt.SPRITE_HEIGHT;
					
			open = true;
		}
		
		public function get isOpen():Boolean
		{
			return this.open;
		}
		
		public function get isSideways():Boolean
		{
			return this.sideways;
		}
		
		public function get dirtPile():FlxGroup
		{
			return this.dirt;
		}
		
		public function get tunnelId():int
		{
			return this.id;
		}
		
		public function shake(turnOn:Boolean):void
		{
			for (var i:int = 0; i < dirt.length; i++)
			{
				var dirtPile:TunnelDirt = dirt.members[i] as TunnelDirt;
				dirtPile.shake(turnOn);
			}
		}
		
		public function collapse():void
		{
			// no longer allow the sandworm to emerge from here
			open = false; 
			
			// play collapse animation
			for (var i:int = 0; i < dirt.length; i++)
			{
				var dirtPile:TunnelDirt = dirt.members[i] as TunnelDirt;
				dirtPile.shake(false);
				
				if (this.sideways)
				{
					dirtPile.angle = 90;
					dirtPile.x += this.width / 2;
				}
				else
				{
					dirtPile.angle = 180;
					dirtPile.y += this.height / 2
				}
			}
		}
		
		private function buildSprite():void
		{
			dirt = new FlxGroup();
			
			for (var i:int = 0; i < 4; i++)
			{
				var dirtX:Number = this.sideways ? this.x : this.x + (i * TunnelDirt.SPRITE_WIDTH / 2);
				var dirtY:Number = this.sideways ? this.y + (i * TunnelDirt.SPRITE_HEIGHT / 2) : this.y;
				dirt.add(new TunnelDirt(dirtX, dirtY, this.sideways));
			}
		}
	}

}