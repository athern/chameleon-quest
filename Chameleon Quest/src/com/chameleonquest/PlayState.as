package com.chameleonquest 
{
	import com.chameleonquest.Chameleons.*;
	import com.chameleonquest.Enemies.Enemy;
	import com.chameleonquest.Enemies.Spikes;
	import com.chameleonquest.Enemies.Turtle;
	import com.chameleonquest.Objects.ChainSegment;
	import com.chameleonquest.Objects.ElementSource;
	import com.chameleonquest.Objects.Grate;
	import com.chameleonquest.Objects.Pile;
	import com.chameleonquest.Objects.PlatformOnChain;
	import com.chameleonquest.Objects.Pulley;
	import com.chameleonquest.Objects.WaterFountain;
	import com.chameleonquest.Projectiles.Projectile;
	import com.chameleonquest.Projectiles.WaterStream;
	import com.chameleonquest.interactiveObj.Button;
	import com.chameleonquest.interactiveObj.InteractiveObj;
	import com.chameleonquest.interactiveObj.WoodBlock;
	import com.chameleonquest.Rooms.*;
	import org.flixel.*;
	
    public class PlayState extends FlxState
    {
		
		[Embed(source = "../../../assets/tile-16.png")]
		public var levelTiles:Class;
		
		public var ROOM_WIDTH:int;
		public var ROOM_HEIGHT:int;
		
		public var map:FlxTilemap = new FlxTilemap;
		public var player:Chameleon;
		
		public var projectiles:FlxGroup = new FlxGroup;
		public var enemyProjectiles:FlxGroup = new FlxGroup;
		public var enemies:FlxGroup = new FlxGroup;
		
		public var elems:FlxGroup = new FlxGroup;
		public var bgElems:FlxGroup = new FlxGroup;
		public var intrELems:FlxGroup = new FlxGroup;
		
		public var grates:FlxGroup = new FlxGroup;
		
		// heart bar
		public var heartbar:HeartBar = new HeartBar();
		public var ammoindicator:AmmoIndicator = new AmmoIndicator();
		public var ammoText : FlxText;
		
		// pause state
		public var pauseText:FlxText;
		public var quitText:FlxText;
		
		// Logging variable
		public var playtime:Number;

        override public function create():void
		{
			playtime = 0;
			
			if (Main.lastRoom >= 1 && Main.lastRoom <= 7)
			{
				Background.buildBackground(this, 1);
			} else if (Main.lastRoom >= 8 && Main.lastRoom <= 14)
			{
				Background.buildBackground(this, 2);
			}
			add(map);
			add(elems);
			add(bgElems);
			add(intrELems);
			add(player.tongue);
			add(player);
			add(enemies);
			add(projectiles);
			add(enemyProjectiles);
			FlxG.camera.setBounds(0, 0, 16*ROOM_WIDTH, 16*ROOM_HEIGHT, true);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			FlxG.camera.deadzone.x = 160 - 16;
			FlxG.camera.deadzone.y = 120 - 16;
			FlxG.camera.deadzone.width = 32;
			FlxG.camera.deadzone.height = 32;
			
			setupPauseHUD();
			
			add(heartbar);
			add(ammoindicator);
			add(ammoindicator.currentindicator);
			ammoText = new FlxText(ammoindicator.x + 3, ammoindicator.y + 10, 16);
			ammoText.setFormat(null, 8, 0x000000, "center");
			ammoText.scrollFactor.y = 0;
			ammoText.scrollFactor.x = 0;					
			add(ammoText);
			super.create();
			
		}
		
		override public function update():void
		{
			playtime += FlxG.elapsed;
			
			
			// handle pause
			if (FlxG.keys.justPressed("ESCAPE")) {
				Preloader.logger.logAction(2, {"state": FlxG.paused});
				Preloader.tracker.trackEvent("action", "esc", "" + FlxG.paused);
				
				FlxG.paused = !FlxG.paused;
				togglePauseMenu();
			}
			// handle quit
			if (FlxG.paused)
			{
				if (FlxG.keys.justPressed("Q")) {
					Preloader.logger.logAction(3, null);
					Preloader.tracker.trackEvent("action", "q", null);
					
					FlxG.fade(0xff000000, 0.5, onFadeExit);
				}
			}
			else
			{
				super.update();

				FlxG.collide(projectiles, map);
				FlxG.collide(projectiles, enemies, inflictProjectileDamage);
				FlxG.collide(enemyProjectiles, map);
				FlxG.collide(enemyProjectiles, player, inflictProjectileDamage);
				FlxG.collide(enemyProjectiles, elems);
				FlxG.collide(enemyProjectiles, intrELems);
				FlxG.collide(enemies, map);
				FlxG.collide(enemies, enemies, enemyFriendlyFire);
				FlxG.collide(player, enemies, hurtPlayer);
				FlxG.collide(player, map);
				FlxG.collide(enemies, elems);
				FlxG.overlap(enemies, bgElems, null, enemyBackgroundCheck);
				
				FlxG.collide(elems, map);
				FlxG.collide(player, elems, playerElemCollision);
				// For Interactive game object collision
				FlxG.collide(projectiles, intrELems, projectileHitCollision);
				FlxG.collide(projectiles, elems);
				FlxG.collide(player, intrELems);
				FlxG.collide(intrELems, map);
				FlxG.collide(intrELems, intrELems);
				
				
				if (FlxG.keys.justPressed("C")) {
					Preloader.logger.logAction(4, null);
					Preloader.tracker.trackEvent("action", "c", null);
					
					FlxG.overlap(player, bgElems, null, changeElement);
				}
				
				if (FlxG.keys.justPressed("R")) {
					Preloader.logger.logAction(15, null);
					Preloader.tracker.trackEvent("action", "reset", "level-" + Main.lastRoom);
					FlxG.flash(0x000000, 0.75);
					FlxG.switchState(getStage(Main.lastRoom));
				}
				
				if (player.getType() != Chameleon.NORMAL && FlxG.keys.justPressed("X") && !FlxG.overlap(player, grates)) {
					Preloader.logger.logAction(5, {"type": player.getType().toString()});
					Preloader.tracker.trackEvent("action", "x", "" + player.getType().toString());
					
					// change back to normal chameleon
					remove(player);
					player = Chameleon.cloneFrom(player);
					add(player.tongue);
					add(player);
					player.tongue.cleanup();
					FlxG.camera.setBounds(0, 0, 16*ROOM_WIDTH, 16*ROOM_HEIGHT, true);
					FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
				}
				
				//Player is being squashed!
				if (player.isTouching(FlxObject.UP) && player.isTouching(FlxObject.DOWN))
				{
					heartbar.hit(player.reactToDamage());
				}
				
				// water grate check
				if (player.getType() != Chameleon.WATER) {
					FlxG.collide(player, grates);					
				}
				
				if (player.tongue != null)
				{
					player.tongue.alignWithPlayer();
					FlxG.overlap(player.tongue, bgElems, null, pickupRock);
					FlxG.overlap(player.tongue, enemies, null, hurtPlayer);
					FlxG.overlap(player.tongue, intrELems, null, grabItem);
				}
				
				if (player is WaterChameleon)
				{
					ammoindicator.showWater();
					ammoText.visible = false;
				}
				else if (player.ammo > 0)
				{
					ammoindicator.showRock(player.ammo);
					ammoText.text = player.ammo.toString();
					ammoText.visible = true;
				}
				else
				{
					ammoindicator.showTongue();
					ammoText.visible = false;
				}

				// check for game over
				if (heartbar.isEmpty()) {
					FlxG.flash(0x000000, 0.75);
					FlxG.fade(0xff000000, 0.5, onFadeOver);
				}
			}

		}
		
		private function passGrate(player:Chameleon, elem:FlxSprite):void {
			if (elem is Grate) {
				FlxG.collide(player, elem);
			}
		}
		
		private function pickupRock(tongue:Tongue, elem:FlxSprite):void 
		{
			if (elem is Pile)
			{
				tongue.pickupRock();
			}
		}
		
		private function changeElement(me:Chameleon, elem:FlxSprite):void
		{		
			var src:ElementSource = null;
			if (elem is ElementSource)
			{
				Preloader.logger.logAction(11, {"elem": me.getType().toString() });
				Preloader.tracker.trackEvent("action", "elem", me.getType().toString());
			
				src = elem as ElementSource;
				if (me.getType() == src.getElementType())
				{
					return;
				}
				
				if (me.getType() == Chameleon.NORMAL)
				{
					remove(me.tongue);
				}
				remove(me);
				switch (src.getElementType())
				{
					case Chameleon.WATER:
						player = WaterChameleon.cloneFrom(me);
						break;
					case Chameleon.FIRE:
						player = FireChameleon.cloneFrom(me);
						break;
					case Chameleon.EARTH:
						player = EarthChameleon.cloneFrom(me);
						break;
					case Chameleon.WIND:
						player = WindChameleon.cloneFrom(me);
						break;
					case Chameleon.ELECTRICITY:
						player = ElectricChameleon.cloneFrom(me);
						break;
					default:
						player = me;
						if (me.tongue != null)
						{
							add(player.tongue);
						}
				}
				
				if (player != me) {
					if (me.tongue != null) {
						me.tongue.kill()
					}
					me.kill();
				}
				
				add(player);
				FlxG.camera.setBounds(0, 0, 16*ROOM_WIDTH, 16*ROOM_HEIGHT, true);
				FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			}
		}
		
		public function playerElemCollision(player:Chameleon, elem:FlxObject):void {
			if (player.isTouching(FlxObject.FLOOR)) {
				player.velocityModifiers.x = elem.velocity.x;
				player.velocityModifiers.y = elem.velocity.y;
			}
		}
		
		// Fade exit from pause
		private function onFadeExit():void
		{
			Preloader.logger.logLevelEnd({"quit": Main.lastRoom, "time": playtime});
			Preloader.tracker.trackEvent("quit", "level-" + Main.lastRoom, null, int(Math.round(playtime)));
			
			FlxG.paused = !FlxG.paused;
			FlxG.switchState(new MenuState());
		}
		
		// Fade to game over
		private function onFadeOver():void
		{
			Preloader.logger.logAction(1, {"room": Main.lastRoom, "x": player.x, "y": player.y, "time": playtime});
			Preloader.logger.logLevelEnd({"dest": -1});
			Preloader.tracker.trackPageview("/game-over");
			Preloader.tracker.trackEvent("game-over", "level-" + Main.lastRoom, "(" + player.x + ", " + player.y +")", int(Math.round(playtime)));
			
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
		
		
		protected function hurtPlayer(playerPart:FlxSprite, enemy:Enemy):void
		{
			Preloader.logger.logAction(9, {"room": Main.lastRoom, "x": player.x, "y": player.y, "enemy": enemy.toString()});
			Preloader.tracker.trackEvent("damage", "level-" + Main.lastRoom, "(" + player.x + ", " + player.y +"), " + enemy.toString(), int(Math.round(playtime)));
			
			if (playerPart is Tongue)
			{
				player.tongue.cleanup();
			}
			
			if (enemy is Turtle)
			{
				enemy.velocity.x = 0;
				enemy.velocity.y = 0;
				enemy.x = enemy.last.x;
				enemy.y = enemy.last.y;
			}
			heartbar.hit(this.player.reactToDamage(enemy));
		}
		
		private function inflictProjectileDamage(bullet:Projectile, target:FlxSprite):void 
		{
			Preloader.logger.logAction(10, {"room": Main.lastRoom, "x": player.x, "y": player.y, "target": target.toString(), "bullet": bullet.toString()});
			Preloader.tracker.trackEvent("shoot", "level-" + Main.lastRoom, "(" + player.x + ", " + player.y +"), target: " + target.toString() + ", bullet: " + bullet.toString(), int(Math.round(playtime)));
			
			if (target is Turtle && bullet is WaterStream)
			{
				target.velocity.x = 0;
				target.velocity.y = 0;
			}
			if (target == player)
			{
				heartbar.hit(bullet.getDamage(player));
			}
			else if (target is Enemy)
			{
				(target as Enemy).hitWith(bullet);
			}
			else
			{
				target.hurt(bullet.getDamage(target));
			}
		}
		
		// for interactive game object with projectile collision
		private function projectileHitCollision(bullet:Projectile, target:InteractiveObj):void {
			target.hit(bullet);
		}
		
		private function enemyFriendlyFire(e1:Enemy, e2:Enemy):void
		{
			if (e2 is Spikes)
			{
				e1.hurt(1);
			}
			if (e1 is Spikes)
			{
				e2.hurt(1);
			}
		}
		
		private function enemyBackgroundCheck(enemy:Enemy, background:FlxSprite):void
		{
			if (background is ChainSegment && enemy.isTouching(FlxObject.FLOOR))
			{
				(background as ChainSegment).parentPlatform.pulley.addWeight(enemy);
			}
		}
		
		private function grabItem(tongue:Tongue, item:InteractiveObj):void
		{
			if (item is WoodBlock)
			{
				tongue.grabbedObject = item;
				tongue.extending = false;
			}
		}
		
		public static function getStage(number:int):FlxState
		{
			if (number == 1)
			{
				return new Room1_1State();
			}
			else if (number == 2)
			{
				return new Room1_2State();
			}
			else if (number == 3)
			{
				return new Room1_3State();
			}
			else if (number == 4)
			{
				return new Room1_4State();
			}
			else if (number == 5)
			{
				return new Room1_5State();
			}
			else if (number == 6)
			{
				return new Room1_6State();
			}
			else if (number == 7)
			{
				return new Room1_7State();
			}
			else if (number == 8)
			{
				return new Room2_1State();
			}
			else if (number == 9)
			{
				return new Room2_2State();
			}
			else if (number == 10)
			{
				return new Room2_3State();
			}
			else if (number == 11)
			{
				return new Room2_4State();
			}
			else if (number == 12)
			{
				return new Room2_5State();
			}
			else if (number >= 13)
			{
				return new Room2_6State();
			}
			else
			{
				return new MenuState();
			}
		}
    }

}