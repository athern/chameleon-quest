package com.chameleonquest.Rooms 
{
	import com.chameleonquest.Chameleons.Chameleon;
	import com.chameleonquest.Enemies.BossDragon;
	import com.chameleonquest.Enemies.BossSandworm;
	import com.chameleonquest.LevelCompleteState;
	import com.chameleonquest.Main;
	import com.chameleonquest.Objects.Boulder;
	import com.chameleonquest.Objects.Door;
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
		[Embed(source = "../../../../assets/bosstheme.mp3")]public var bossTheme:Class;
		
		[Embed(source = "../../../../assets/mapCSV_3-7_Map.csv", mimeType = "application/octet-stream")]
		public var levelMap:Class;
		
		private const EMERGENCE_TIME:Number = 5;
		private const HINT_TIME:Number = 3;
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
		
		private var nextTunnel:TunnelEntrance;
		
		override public function create():void 
		{
			ROOM_WIDTH = 45;
			ROOM_HEIGHT = 30;
			
			map.loadMap(new levelMap, levelTiles, 16, 16);
			player = new Chameleon(1, 27);
			bgElems.add(new Door(1, 27, false));
			elems.add(new Door(ROOM_WIDTH - 3, 27, true));
			
			boss = new BossSandworm(0, 0);
			preMap.add(boss);
			
			bgElems.add(new Torch(6, 27));
			leftgate = new StoneGate(3, 27, -1, 20);
			rightgate = new StoneGate(ROOM_WIDTH - 5, 27, -1, 20);
			elems.add(leftgate);
			elems.add(rightgate);
			StoneGate.lift(leftgate);
			StoneGate.lift(rightgate);
			
			tunnels = new FlxGroup();
			tunnels.add(new TunnelEntrance(16 * 11.5, 16 * 23, 0));
			tunnels.add(new TunnelEntrance(16 * 17.5, 16 * 23, 1));
			tunnels.add(new TunnelEntrance(16 * 23.5, 16 * 23, 2));
			tunnels.add(new TunnelEntrance(16 * 29, 16 * 23, 3));
			//bgElems.add(tunnels);
			
			
			boulders = new FlxGroup();
			for (var i:int = 0; i < tunnels.length; i++)
			{
				var tunnel:TunnelEntrance = tunnels.members[i] as TunnelEntrance;
				preMap.add(tunnel.dirtPile);
				this.createTNT(i);
			}
			
			elems.add(boulders);
			
			FlxG.visualDebug = true;
			
			bossTimer = 0;
			
			Main.lastRoom = 21;
			super.create();
			
			this.enteredBossChamber = false;
			this.fanfare = false;
			FlxG.playMusic(bossTheme);
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x > (6 * 16) && !enteredBossChamber)
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
					Preloader.logger.logAction(8, {"boss": "earth"});
					Preloader.tracker.trackEvent("level-14", "boss-kill", null);
					enemies.kill();
					add(new Fanfare(18, 14));
					fanfare = true;
				}
			}
			
			if (bossTimer > HINT_TIME && nextTunnel == null)
			{
				do
				{
					nextTunnel = tunnels.getRandom() as TunnelEntrance;
				}
				while (!nextTunnel.isOpen);
				
				nextTunnel.shake(true);
			}
			
			if (bossTimer > EMERGENCE_TIME)
			{
				// emerge!
				
				nextTunnel.shake(false);
				boss.emergeFrom(nextTunnel);
				
				bossTimer = 0;
				
				nextTunnel = null;
				
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
					boulder = new Boulder(13 * 16, 9 * 16);
					tnt = new TNT(13, 16, new Array(new FlxPoint(11 * 16 + 6, 14 * 16 + 6), new FlxPoint(7 * 16 + 6, 14 * 16 + 6), new FlxPoint(7 * 16 + 6, 20 * 16 + 6), new FlxPoint(11 * 16 + 6, 20 * 16 + 6)));
					break;
				case 1: 
					//boulder = new Boulder(8 * 16, 0 * 16);
					//tnt = new TNT(8, 7, new Array(new FlxPoint(7 * 16 + 6, 5 * 16 + 6), new FlxPoint(1 * 16 + 6, 5 * 16 + 6), new FlxPoint(1 * 16 + 6, 9 * 16 + 6), new FlxPoint(3 * 16 + 6, 9 * 16 + 6)));
					break;
				case 2: 
					//boulder = new Boulder(15 * 16, 2 * 16);
					//tnt = new TNT(16, 7, new Array(new FlxPoint(19 * 16 + 6, 5 * 16 + 6), new FlxPoint(22 * 16 + 6, 5 * 16 + 6), new FlxPoint(22 * 16 + 6, 15 * 16 + 6), new FlxPoint(12 * 16 + 6, 15 * 16 + 6)));
					break;
				case 3:
					//boulder = new Boulder(41 * 16, 7 * 16);
					//tnt = new TNT(41, 13, new Array(new FlxPoint(44 * 16 + 6, 11 * 16 + 6), new FlxPoint(46 * 16 + 6, 11 * 16 + 6), new FlxPoint(46 * 16 + 6, 13 * 16 + 6), new FlxPoint(44 * 16 + 6, 13 * 16 + 6)));
					break;
				default:
					return;
			}
			
			if (boulder == null)
			{
				return;
			}
			
			boulderOwnership[boulder] = tunnelID;
			boulders.add(boulder);
			elems.add(tnt);
		}
	}

}