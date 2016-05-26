package com.chameleonquest 
{
	import com.chameleonquest.Chameleons.*;
	import com.chameleonquest.Enemies.Enemy;
	import com.chameleonquest.Enemies.Spikes;
	import com.chameleonquest.Enemies.Turtle;
	import com.chameleonquest.Objects.Boulder;
	import com.chameleonquest.Objects.ChainSegment;
	import com.chameleonquest.Objects.ElementSource;
	import com.chameleonquest.Objects.FuseSegment;
	import com.chameleonquest.Objects.Grate;
	import com.chameleonquest.Objects.Pile;
	import com.chameleonquest.Objects.PlatformOnChain;
	import com.chameleonquest.Objects.Pulley;
	import com.chameleonquest.Objects.RopeSegment;
	import com.chameleonquest.Objects.StoneGate;
	import com.chameleonquest.Objects.WaterFountain;
	import com.chameleonquest.Projectiles.Fireball;
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
		
		public var preMap:FlxGroup = new FlxGroup();
		public var projectiles:FlxGroup = new FlxGroup;
		public var enemyProjectiles:FlxGroup = new FlxGroup;
		public var enemies:FlxGroup = new FlxGroup;
		public var particles:FlxGroup = new FlxGroup;
		
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
		private var lastSec:Number;

        override public function create():void
		{
			playtime = 0;
			lastSec = 1;
			
			if (Main.lastRoom >= 1 && Main.lastRoom <= 7)
			{
				Background.buildBackground(this, 1);
			} else if (Main.lastRoom >= 8 && Main.lastRoom <= 14)
			{
				Background.buildBackground(this, 2);
			}
			else if (Main.lastRoom >= 15 && Main.lastRoom <= 21)
			{
				Background.buildBackground(this, 3);
			}
			
			add(preMap);
			add(map);
			add(bgElems);
			add(elems);
			
			add(intrELems);
			add(player.tongue);
			add(player);
			add(enemies);
			add(projectiles);
			add(enemyProjectiles);
			add(particles);
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
			if (!FlxG.paused) {
				playtime += FlxG.elapsed;
				
				if (lastSec < playtime) {
					lastSec += 1;
					// log location
					Preloader.logger.logAction(77, {"x": player.x, "y": player.y, "room": Main.lastRoom});
				}
			}
			
			
			// handle pause
			if (FlxG.keys.justPressed("ESCAPE")) {
				Preloader.logger.logAction(2, {"state": FlxG.paused});
				Preloader.tracker.trackEvent("action", "esc", "" + FlxG.paused);
				
				FlxG.paused = !FlxG.paused;
				togglePauseMenu();
			}
			if (FlxG.keys.justPressed("R")) {
				Preloader.logger.logAction(15, {"room": Main.lastRoom});
				Preloader.tracker.trackEvent("action", "reset", "level-" + Main.lastRoom);
				FlxG.flash(0x000000, 0.75);
				FlxG.switchState(Main.getStage(Main.lastRoom));
				FlxG.paused = false;
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
				FlxG.overlap(projectiles, bgElems, null, projectileBackgroundCheck);
				FlxG.collide(elems, intrELems, bigButtonCheck);
				FlxG.collide(elems, map);
				FlxG.collide(elems, elems);
				FlxG.collide(player, elems, playerElemCollision);
				// For Interactive game object collision
				FlxG.overlap(projectiles, intrELems, null, projectileHitCollision);
				FlxG.collide(projectiles, elems);
				FlxG.collide(player, intrELems);
				FlxG.collide(intrELems, map);
				FlxG.collide(intrELems, intrELems);
				FlxG.collide(particles, map);
				//FlxG.overlap(particles, elems, null, particleElemCollision);
				FlxG.overlap(particles, intrELems, null, particleElemCollision);
				FlxG.collide(particles, enemies);
				
				
				if (FlxG.keys.justPressed("C")) {
					Preloader.logger.logAction(4, null);
					Preloader.tracker.trackEvent("action", "c", null);
					
					FlxG.overlap(player, bgElems, null, changeElement);
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
					heartbar.hit(player.takeDamage(1));
					player.x -= 2;
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
				if (player is FireChameleon)
				{
					ammoindicator.showFire();
					ammoText.visible = false;
				}
				else if (player is WaterChameleon)
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
				if (heartbar.isEmpty() || player.x < -100 || player.x > FlxG.camera.bounds.right + 100 
						|| player.y < -100 || player.y > FlxG.camera.bounds.bottom + 100) {
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
						me.tongue.cleanup()
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
			if (elem is Boulder)
			{
				heartbar.hit(player.takeDamage(6));
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
			Preloader.tracker.trackPageview(Preloader.flag + "/game-over");
			Preloader.tracker.trackEvent("game-over", "level-" + Main.lastRoom, "(" + player.x + ", " + player.y +")", int(Math.round(playtime)));
			
			FlxG.switchState(new GameOverState());
		}
		
		// Sets up the Pause Menu
		private function setupPauseHUD():void {
			// Pause HUD
			pauseText = new FlxText(0, (FlxG.width / 2) - 90, FlxG.width, "Game Paused");
			pauseText.setFormat(null, 18, 0x000000, "center");
			pauseText.scrollFactor.x = 0;
			pauseText.scrollFactor.y = 0;
			
			quitText = new FlxText(0, (FlxG.width / 2) - 40, FlxG.width, "Press \"q\" to quit\n\nPress \"r\" to reset level\n\nPress ESC to resume");
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
		
		
			if (target == player)
			{
				heartbar.hit(player.takeDamage(bullet.getDamage(player)));
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
			if (bullet is WaterStream || target is WoodBlock)
			{
				bullet.kill();
			}
		}
		
		private function enemyFriendlyFire(e1:Enemy, e2:Enemy):void
		{
			if (e2 is Spikes)
			{
				e1.hurt(e2.power);
			}
			if (e1 is Spikes)
			{
				e2.hurt(e1.power);
			}
		}
		
		private function enemyBackgroundCheck(enemy:Enemy, background:FlxSprite):void
		{
			if (background is ChainSegment && enemy.isTouching(FlxObject.FLOOR))
			{
				(background as ChainSegment).parentPlatform.pulley.addWeight(enemy);
			}
		}
		
		private function projectileBackgroundCheck(projectile:Projectile, background:FlxSprite):void
		{
			if (projectile is Fireball && background is RopeSegment)
			{
				(background as RopeSegment).triggerDrop();
				background.kill();
			}
			if (projectile is Fireball && background is FuseSegment)
			{
				var fuse:FuseSegment = background as FuseSegment;
				if (fuse.variant == 2)
				{
					fuse.source.startBurning(fuse);
				}
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
		
		private function particleElemCollision(particle:FlxParticle, elem:FlxSprite):void
		{
			elem.velocity.y += particle.velocity.y/10;
			elem.velocity.x += particle.velocity.x/10;
			particle.kill();
		}
		
		private function bigButtonCheck(elem:FlxSprite, intrElem:FlxSprite):void
		{
			if (elem is Boulder && intrElem is Button && intrElem.width == 64)
			{
				(intrElem as Button).activate();
			}
		}
	
    }

}