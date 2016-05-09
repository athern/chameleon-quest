package com.chameleonquest 
{
	import com.chameleonquest.Chameleons.FireChameleon;
	import com.chameleonquest.Chameleons.Player;
	import com.chameleonquest.Chameleons.WaterChameleon;
	import com.chameleonquest.Enemies.Enemy;
	import com.chameleonquest.Enemies.Spikes;
	import com.chameleonquest.Enemies.Turtle;
	import com.chameleonquest.Objects.ElementSource;
	import com.chameleonquest.Objects.Grate;
	import com.chameleonquest.Objects.Pile;
	import com.chameleonquest.Objects.Pulley;
	import com.chameleonquest.Objects.WaterFountain;
	import com.chameleonquest.Projectiles.Projectile;
	import com.chameleonquest.interactiveObj.Button;
	import com.chameleonquest.interactiveObj.InteractiveObj;
	import com.chameleonquest.interactiveObj.WoodBlock;
	import org.flixel.*;
	
    public class PlayState extends FlxState
    {
		
		[Embed(source = "../../../assets/tile-16.png")]
		public var levelTiles:Class;
		
		public var ROOM_WIDTH:int;
		public var ROOM_HEIGHT:int;
		
		public var map:FlxTilemap = new FlxTilemap;
		public var player:Player;
		
		public var projectiles:FlxGroup = new FlxGroup;
		public var enemyProjectiles:FlxGroup = new FlxGroup;
		public var enemies:FlxGroup = new FlxGroup;
		
		public var elems:FlxGroup = new FlxGroup;
		public var bgElems:FlxGroup = new FlxGroup;
		public var intrELems:FlxGroup = new FlxGroup;
		
		// heart bar
		public var heartbar:HeartBar = new HeartBar();
		public var ammoindicator:AmmoIndicator = new AmmoIndicator();
		
		// pause state
		public var pauseText:FlxText;
		public var quitText:FlxText;

        override public function create():void
		{
			if (Main.lastRoom >= 1 && Main.lastRoom <= 7)
			{
				Background.buildBackground(this, 1);
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
			
			
			setupPauseHUD();
			
			add(heartbar);
			add(ammoindicator);
			add(ammoindicator.currentindicator);
			super.create();
			
		}
		
		override public function update():void
		{
			// handle pause
			if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.paused = !FlxG.paused;
				togglePauseMenu();
			}
			// handle quit
			if (FlxG.paused)
			{
				if(FlxG.keys.justPressed("Q")) {
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
				if (player.tongue != null)
				{
					FlxG.overlap(player.tongue, bgElems, null, pickupRock);
					FlxG.overlap(player.tongue, enemies, null, hurtPlayer);
					FlxG.overlap(player.tongue, intrELems, null, grabItem);
				}
				FlxG.collide(elems, map);
				FlxG.collide(player, elems, playerElemCollision);
				// For Interactive game object collision
				FlxG.collide(projectiles, intrELems, projectileHitCollision);
				FlxG.collide(projectiles, elems);
				FlxG.collide(player, intrELems);
				FlxG.collide(intrELems, map);
				FlxG.collide(intrELems, intrELems);
				
				// water grate check
				if (player.getType() != Player.WATER) {
					FlxG.overlap(player, bgElems, null, passGrate);					
				}
				
				
				if (FlxG.keys.justPressed("C")) {
					FlxG.overlap(player, bgElems, null, changeElement);
				}
				
				if (player.getType() != Player.NORMAL && FlxG.keys.justPressed("X")) {
					// change back to normal chameleon
					remove(player);
					player = Player.cloneFrom(player);
					add(player.tongue);
					add(player);
					FlxG.camera.setBounds(0, 0, 16*ROOM_WIDTH, 16*ROOM_HEIGHT, true);
					FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
				}
				
				//Player is being squashed!
				if (player.isTouching(FlxObject.UP) && player.isTouching(FlxObject.DOWN))
				{
					heartbar.hit(1);
				}
				
				if (player.tongue != null)
				{
					player.tongue.alignWithPlayer();
				}
				
				if (player is WaterChameleon)
				{
					ammoindicator.showWater();
				}
				else if (player.hasAmmo)
				{
					ammoindicator.showRock();
				}
				else
				{
					ammoindicator.showTongue();
				}

				// check for game over
				if (heartbar.isEmpty()) {
					FlxG.flash(0x000000, 0.75);
					FlxG.fade(0xff000000, 0.5, onFadeOver);
				}
			}

		}
		
		// TODO: issue when player try to pass the grate (could crash the game)
		private function passGrate(player:Player, elem:FlxSprite):void {
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
		
		private function changeElement(me:Player, elem:FlxSprite):void
		{
			var src:ElementSource = null;
			if (elem is ElementSource)
			{
				src = elem as ElementSource;
				if (me.getType() == src.getElementType())
				{
					return;
				}
				
				if (me.getType() == Player.NORMAL)
				{
					remove(me.tongue);
				}
				remove(me);
				switch (src.getElementType())
				{
					case Player.WATER:
						player = WaterChameleon.cloneFrom(me);
						break;
					case Player.FIRE:
						player = FireChameleon.cloneFrom(me);
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
		
		public function playerElemCollision(player:Player, elem:FlxObject):void {
			if (player.isTouching(FlxObject.FLOOR)) {
				player.velocityModifiers.x = elem.velocity.x;
				player.velocityModifiers.y = elem.velocity.y;
			}
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
		
		
		private function hurtPlayer(playerPart:FlxSprite, enemy:Enemy):void
		{
			heartbar.hit(this.player.reactToDamage(enemy));
		}
		
		private function inflictProjectileDamage(bullet:Projectile, target:FlxSprite):void 
		{
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
		
		private function grabItem(tongue:Tongue, item:InteractiveObj):void
		{
			if (item is WoodBlock)
			{
				tongue.grabbedObject = item;
				tongue.grabbedFacing = player.facing;
				tongue.extending = false;
			}
		}
    }

}