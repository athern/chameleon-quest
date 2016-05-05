package com.chameleonquest 
{
	import org.flixel.*;
	
	public class Background extends FlxSprite
	{
		[Embed(source = "../../../assets/bg-land.png")]
		protected var Area1Land:Class;
		
		[Embed(source = "../../../assets/bg-sky.png")]
		protected var Area1Sky:Class;
		
		
		public function Background(Xindex:int, Yindex:int, area:int, land:Boolean) 
		{
			super(Xindex*16, Yindex*16);
			if (area == 1 && land == true)
			{
				loadGraphic(Area1Land);
			}
			if (area == 1 && land == false)
			{
				loadGraphic(Area1Sky);
			}
			scrollFactor.x = scrollFactor.y = .5;
		}
		
		public static function buildBackground(state:PlayState, area:int):void
		{
			var heightleft:int = (state.ROOM_HEIGHT - 16)*.5;
			var widthleft:int;
			for (widthleft = 0; widthleft < state.ROOM_WIDTH; widthleft += 16)
			{
				state.add(new Background(widthleft, heightleft, area, true));
			}
			for (heightleft = (state.ROOM_HEIGHT - 16)*.5-16; heightleft > -16; heightleft -= 16)
			{
				for (widthleft = 0; widthleft < state.ROOM_WIDTH; widthleft += 16)
				{
					state.add(new Background(widthleft, heightleft, area, false));
				}
				
			}
			
		}
		
	}

}