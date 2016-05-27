package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Enemies.BossDragon;
	import com.chameleonquest.Enemies.BossSandworm;
	import com.chameleonquest.LevelCompleteState;
	import com.chameleonquest.Main;
	import com.chameleonquest.Objects.Boulder;
	import com.chameleonquest.Objects.Fanfare;
	import com.chameleonquest.Objects.Platform;
	import com.chameleonquest.Objects.StoneGate;
	import com.chameleonquest.Objects.TNT;
	import com.chameleonquest.Objects.Torch;
	import com.chameleonquest.Objects.TunnelEntrance;
	import com.chameleonquest.PlayState;
	import com.chameleonquest.Preloader;
	import flash.utils.Dictionary;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	
	public class Room3_7State extends PlayState
	{		
		[Embed(source = "../../../../assets/mapCSV_3-7_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		private const EMERGENCE_TIME:Number = 5;
		private var bossTimer:Number;
		private var tunnels:FlxGroup;
		private var boss:BossSandworm;
		private var boulders:FlxGroup;
		private var lastTunnel:int = 0;
		private var rebuildList:Array = new Array();
		private var boulderOwnership:Dictionary = new Dictionary();
		
		private var leftgate:StoneGate;
		private var rightgate:StoneGate;
		private var enteredBossChamber:Boolean;
		private var fanfare:Boolean;
		
		override public function create():void 
		{
			ROOM_WIDTH = 49;
			ROOM_HEIGHT = 36;
			
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Chameleon(0, 35);
			Preloader.logger.logLevelStart(21, {"src": 20});
			Preloader.tracker.trackPageview(Preloader.flag + "/level-21");
			Preloader.tracker.trackEvent("level-21", "level-enter", null, 20);
			
			boss = new BossSandworm(0, 0);
			preMap.add(boss);
			
			elems.add(new Platform(new Array(new FlxPoint(2 * 16, 23 * 16), new FlxPoint(2 * 16, 15 * 16), new FlxPoint(5 * 16, 15 * 16)), 50));
			elems.add(new Platform(new Array(new FlxPoint(15 * 16, 24 * 16), new FlxPoint(25 * 16, 24 * 16)), 50));
			
			bgElems.add(new Torch(7, 35));
			leftgate = new StoneGate(0, 35, -1, 20);
			rightgate = new StoneGate(31, 35, -1, 20);
			elems.add(leftgate);
			elems.add(rightgate);
			StoneGate.lift(leftgate);
			StoneGate.lift(rightgate);
			
			tunnels = new FlxGroup();
			tunnels.add(new TunnelEntrance(16 * 20, 16 * (ROOM_HEIGHT - 3), 0));
			tunnels.add(new TunnelEntrance(16 * 5, 16 * 25, 1));
			tunnels.add(new TunnelEntrance(16 * 18, 16 * 8, 2, true));
			tunnels.add(new TunnelEntrance(16 * 44, 16 * 18, 3, true));
			//bgElems.add(tunnels);
			
			bossTimer = 0;
			
			Main.lastRoom = 21;
			super.create();
			
			boulders = new FlxGroup();
			for (var i:int = 0; i < tunnels.length; i++)
			{
				var tunnel:TunnelEntrance = tunnels.members[i] as TunnelEntrance;
				bgElems.add(tunnel.dirtPile);
				this.createTNT(i);
			}
			
			elems.add(boulders);
			
			this.enteredBossChamber = false;
			this.fanfare = false;
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x < 0) {
				player.x = 0;
			}
			
			if (player.x > map.width - 16) {
				Preloader.logger.logLevelEnd({"dest": 22, "time": playtime});
				Preloader.tracker.trackPageview(Preloader.flag + "/level-21-end");
				Preloader.tracker.trackEvent("level-21", "level-end", null, int(Math.round(playtime)));
				FlxG.switchState(new LevelCompleteState(playtime));
			}
			
			if (player.x > (7 * 16) && !enteredBossChamber)
			{
				enteredBossChamber = true;
				StoneGate.drop(leftgate);
				StoneGate.drop(rightgate);
			}
			
			if (boss.health <= 0)
			{
				StoneGate.lift(leftgate);
				StoneGate.lift(rightgate);
				if (!fanfare) {
					Preloader.logger.logAction(8, {"boss": "fire"});
					Preloader.tracker.trackEvent("level-14", "boss-kill", null);
					enemies.kill();
					add(new Fanfare(18, 14));
					fanfare = true;
				}
			}
			
			if (bossTimer > EMERGENCE_TIME)
			{
				// emerge!
				do
				{
					var tunnel:TunnelEntrance = tunnels.members[lastTunnel] as TunnelEntrance;
					lastTunnel = (lastTunnel + 1) % tunnels.length;
				}
				while (!tunnel.isOpen);
				
				boss.emergeFrom(tunnel);
				
				bossTimer = -EMERGENCE_TIME;
				
				for (var i:int = 0; i < rebuildList.length; i++)
				{
					var tunnelID:int = rebuildList.pop() as int;
					this.createTNT(tunnelID);
				}
			}
			
			bossTimer += FlxG.elapsed;
			
			FlxG.collide(boss, boulders, hurtBoss);
			FlxG.overlap(boulders, tunnels, null, destroyBoulder);
			FlxG.collide(boulders, map, destroyBoulder);
			FlxG.collide(player, boss, hurtPlayer);
			FlxG.collide(projectiles, boss);
		}
		
		private function hurtBoss(boss:BossSandworm, boulder:Boulder):void 
		{
			boss.crush();
			boulder.kill();
		}
		
		private function destroyBoulder(boulder:Boulder, obj:FlxObject):void 
		{
			if (boulderOwnership[boulder] != null)
			{
				rebuildList.push(boulderOwnership[boulder] as int);
			}
			
			boulder.kill();
		}
		
		private function createTNT(tunnelID:Number):void
		{
			var tnt:TNT = null;
			var boulder:Boulder = null;
			switch(tunnelID)
			{
				case 0:
					boulder = new Boulder(24 * 16, 15 * 16);
					tnt = new TNT(24, 21, new Array(new FlxPoint(27 * 16 + 6, 19 * 16 + 6), new FlxPoint(35 * 16 + 6, 19 * 16 + 6), new FlxPoint(35 * 16 + 6, 21 * 16 + 6)));
					break;
				case 1: 
					boulder = new Boulder(8 * 16, 0 * 16);
					tnt = new TNT(8, 7, new Array(new FlxPoint(7 * 16 + 6, 5 * 16 + 6), new FlxPoint(1 * 16 + 6, 5 * 16 + 6), new FlxPoint(1 * 16 + 6, 9 * 16 + 6), new FlxPoint(3 * 16 + 6, 9 * 16 + 6)));
					break;
				case 2: 
					boulder = new Boulder(15 * 16, 2 * 16);
					tnt = new TNT(16, 7, new Array(new FlxPoint(19 * 16 + 6, 5 * 16 + 6), new FlxPoint(22 * 16 + 6, 5 * 16 + 6), new FlxPoint(22 * 16 + 6, 15 * 16 + 6), new FlxPoint(12 * 16 + 6, 15 * 16 + 6)));
					break;
				case 3:
					boulder = new Boulder(41 * 16, 7 * 16);
					tnt = new TNT(41, 13, new Array(new FlxPoint(44 * 16 + 6, 11 * 16 + 6), new FlxPoint(46 * 16 + 6, 11 * 16 + 6), new FlxPoint(46 * 16 + 6, 13 * 16 + 6), new FlxPoint(44 * 16 + 6, 13 * 16 + 6)));
					break;
				default:
					return;
			}
			
			boulderOwnership[boulder] = tunnelID;
			boulders.add(boulder);
			elems.add(tnt);
		}
	}

}