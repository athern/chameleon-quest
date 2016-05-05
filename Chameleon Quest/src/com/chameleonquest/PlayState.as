package com.chameleonquest 
{
	import com.chameleonquest.Enemies.Enemy;
	import com.chameleonquest.Objects.Pile;
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
		
		// pause state
		public var pauseText:FlxText;
		public var quitText:FlxText;
				
        override public function create():void
		{
			if (Main.lastRoom >= 1 && Main.lastRoom <= 6)
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
			if (FlxG.keys.SPACE)
			{
				// TODO: prevent tongue from coming out repeatedly on space (add cooldown in tongue?)
				var attack:Projectile = this.player.getNextAttack() as Projectile;
				if (attack != null) 
				{
					var attackX:Number = player.facing == FlxObject.LEFT ? this.player.x - attack.width : this.player.x + this.player.width;
					var attackY:Number = this.player.y + this.player.height / 2 - attack.height / 2;
					attack.shoot(attackX, attackY, player.facing == FlxObject.LEFT ? -200 : 200, 0);
					projectiles.add(attack);
				}
				else
				{
					player.tongue.shoot();
				}
			}
			
			FlxG.collide(projectiles, map);
			FlxG.collide(projectiles, enemies, inflictProjectileDamage);
			FlxG.collide(enemyProjectiles, map);
			FlxG.collide(enemyProjectiles, player, inflictProjectileDamage);
			FlxG.collide(enemies, map);
			FlxG.collide(player, enemies, hurtPlayer);
			FlxG.collide(player, map);
			FlxG.overlap(player.tongue, bgElems, null, pickupRock);
			FlxG.overlap(player.tongue, enemies, null, hurtPlayer);
			FlxG.overlap(player.tongue, intrELems, null, grabItem);
			FlxG.collide(enemies, map);
			FlxG.collide(elems, map);
			FlxG.collide(player, elems, playerElemCollision);
			// For Interactive game object collision
			FlxG.collide(projectiles, intrELems, projectileHitCollision);
			FlxG.collide(projectiles, elems);
			FlxG.collide(player, intrELems);
			FlxG.collide(intrELems, map);
			
			
			
			// check for game over
			if (heartbar.isEmpty()) {
				FlxG.flash(0x000000, 0.75);
				FlxG.fade(0xff000000, 0.5, onFadeOver);
			}
			}

		}
		
		private function pickupRock(tongue:Tongue, elem:FlxSprite):void 
		{
			if (elem is Pile)
			{
				tongue.pickupRock();
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
			else
			{
				target.hurt(bullet.getDamage(target));
			}
		}
		
		// for interactive game object with projectile collision
		private function projectileHitCollision(bullet:Projectile, target:InteractiveObj):void {
			target.hit();
		}
		
		private function grabItem(tongue:Tongue, item:InteractiveObj):void
		{
			if (item is WoodBlock)
			{
				tongue.grabbedObject = item;
			}
		}
    }

}