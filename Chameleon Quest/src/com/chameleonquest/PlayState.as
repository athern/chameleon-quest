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
		// spikes
		public var spikeBar:FlxGroup = new FlxGroup;
		
		// hearbar
		public var heartbar:HeartBar = new HeartBar();
		
		// pause state
		public var pauseText:FlxText;
		public var quitText:FlxText;
		
        override public function create():void
		{
			FlxG.camera.setBounds(0, 0, 16*ROOM_WIDTH, 16*ROOM_HEIGHT, true);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			
			setupPauseHUD();
			
			add(heartbar);
			super.create();
		}
		
		override public function update():void
		{
			
			super.update();
			FlxG.collide(player, map);
			FlxG.collide(elems, map);
			FlxG.collide(player, elems, playerElemCollision);
			// spike collision
			FlxG.collide(player, spikeBar, playerSpikeCollision);
			
			// handle pause
			if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.paused = !FlxG.paused;
				togglePauseMenu();
			}
			// handle quit
			if (FlxG.paused && FlxG.keys.justPressed("Q")) {
				FlxG.fade(0xff000000, 0.5, onFadeExit);
			}
			
			// check for game over
			if (heartbar.isEmpty()) {
				FlxG.flash(0x000000, 0.75);
				FlxG.fade(0xff000000, 0.5, onFadeOver);
			}

		}
		
		public function playerElemCollision(player:Player, elem:FlxObject):void {
			if (player.isTouching(FlxObject.FLOOR)) {
				player.velocityModifiers.x = elem.velocity.x;
				player.velocityModifiers.y = elem.velocity.y;
			}
		}
		
		
		// Spike and player collision
		public function playerSpikeCollision(player:Player, spikeBar:FlxObject):void {
			heartbar.hit();
		}
		
		// Fade exit from pause
		private function onFadeExit():void
		{
			FlxG.paused = !FlxG.paused;
			FlxG.switchState(new MenuState());
		}
		
		// Fade to game over
		private function onFadeOver():void
		{
			FlxG.switchState(new GameOverState());
		}
		
		// Sets up the Pause Menu
		private function setupPauseHUD():void {
			// Pause HUD
			pauseText = new FlxText(0, (FlxG.width / 2) - 80, FlxG.width, "Game Paused");
			pauseText.setFormat(null, 18, 0x000000, "center");
			pauseText.scrollFactor.x = 0;
			pauseText.scrollFactor.y = 0;
			
			quitText = new FlxText(0, (FlxG.width / 2) - 40, FlxG.width, "Press \"q\" to quit\nPress ESC to resume");
			quitText.setFormat(null, 12, 0x000000, "center");
			quitText.scrollFactor.x = 0;
			quitText.scrollFactor.y = 0;
		}
		
		private function togglePauseMenu():void {
			if (FlxG.paused) {
				this.add(pauseText);
				this.add(quitText);
			} else {
				this.remove(pauseText);
				this.remove(quitText);
			}
		}
    }

}