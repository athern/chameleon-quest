package com.chameleonquest 
{
	import org.flixel.*;
	
    public class PlayState extends FlxState
    {
		
		[Embed(source = "../../../assets/tile-16.png")]
		public var levelTiles:Class;
		
		public var ROOM_WIDTH:int;
		public var ROOM_HEIGHT:int;
	
		public var map:FlxTilemap = new FlxTilemap;
		public var player:Player;
		
		public var elems:FlxGroup = new FlxGroup;
		
		// pause state
		public var pauseText:FlxText;
		public var quitText:FlxText;
		
        override public function create():void
		{
			FlxG.camera.setBounds(0, 0, 16*ROOM_WIDTH, 16*ROOM_HEIGHT, true);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			super.create();
		}
		
		override public function update():void
		{
			
			super.update();
			FlxG.collide(player, map);
			FlxG.collide(elems, map);
			FlxG.collide(player, elems, playerElemCollision);
			
			// handle pause
			if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.paused = !FlxG.paused;
				togglePauseMenu();
			}
			// handle quit
			if (FlxG.paused && FlxG.keys.justPressed("Q")) {
				FlxG.fade(0xff000000, 0.5, onFade);
			}
			

		}
		
		public function playerElemCollision(player:Player, elem:FlxObject):void {
			if (player.isTouching(FlxObject.FLOOR)) {
				player.velocityModifiers.x = elem.velocity.x;
				player.velocityModifiers.y = elem.velocity.y;
				
			}
		}
		
		
		private function onFade():void
		{
			FlxG.paused = !FlxG.paused;
			FlxG.switchState(new MenuState());
		}
		
		
		private function togglePauseMenu():void {
			if (FlxG.paused) {
				var xPause:Number = player.x - FlxG.width / 2;
				if (player.x <= FlxG.width / 2) {
					xPause = 0;
				} else if (player.x > map.width - FlxG.width / 2) {
					xPause = map.width - FlxG.width;
				}
				pauseText = new FlxText(xPause, player.y - 70, FlxG.width, "Game Paused");
				pauseText.setFormat(null, 18, 0x000000, "center");
				this.add(pauseText);
				
				quitText = new FlxText(xPause, player.y - 40, FlxG.width, "Press \"q\" to quit\nPress ESC to resume");
				quitText.setFormat(null, 12, 0x000000, "center");
				this.add(quitText);
			} else {
				this.remove(pauseText);
				this.remove(quitText);
			}
		}
    }

}