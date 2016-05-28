import json
import sys
import ast

# AID - actions				-	Details
#	1	-	Game over
#								Room
#								X
#								Y
#								Play Time
#	2	-	ESC
#								Paused or not
#	3	-	Q
#	4	-	C
#	5	-	X
#								From what element
#	6	-	JUMP
#	7	-	SPACE
#								Tongue
#								Projectile/Rock
#	8	-	Boss
#	9	-	Hurt/Damage
#	10	-	Projectile
#	11	-	Element change
#	12	-	Pick up rock
#	13	-	Enemy kill
#	15	-	Retry

CID = 3
LEVEL_LIMIT = 20

INACTIVITY_LIMIT = 30000 #time in milliseconds that we consider inactve (i.e. 30 seconds)

def get_src_from_action(room, act):
	for a in act:
		if a["aid"] == 9 or a["aid"] == 10:
			det = ast.literal_eval(a["a_detail"])
			room = det["room"]
	return room

def activeTimePlayed(levels):
    totalActiveTime = 0
    for level in levels:
         if level["dqid"] is not None:
              actions = level["actions"]
              activeTime = 0
              lastTimeStamp = 0
              currentTimeStamp = -1

              for action in actions:
                   currentTimeStamp = action["ts"]
                   difference = currentTimeStamp - lastTimeStamp
                   if difference > INACTIVITY_LIMIT:
                        difference = INACTIVITY_LIMIT
                   activeTime = activeTime + difference				
                   lastTimeStamp = currentTimeStamp

              print "level: ",level["qid"]," activeTime: ",activeTime 		
              totalActiveTime = totalActiveTime + activeTime

    return totalActiveTime/1000

def get_qid_data(data):
	dct = {}
	for d in data:
		uid = d["uid"]
		if uid not in dct:
			dct[uid] = {}
		for l in d["levels"]:
			if l["cid"] != CID:
				continue
			qid = l["qid"]
			if qid == 99:
				continue
			qid = get_src_from_action(qid, l["actions"])
			dqid = l["dqid"]

			if qid not in dct[uid]:
				dct[uid][qid] = []
			dct[uid][qid].append(dqid)
	return dct

def print_qid_data(dct):
	print "uid\t\tqid\t\t# of unique dqid (repeatance)"
	for (k, v) in dct.iteritems():
		for (kk, vv) in v.iteritems():
			print k, "\t\t", kk, "\t\t", len(vv)

def get_action_in_qid(data):
	dct = {}
	for d in data:
		for l in d["levels"]:
			if l["cid"] != CID:
				continue
			qid = l["qid"]
			if qid == 99:
				continue
			actions = l["actions"]
			qid = get_src_from_action(qid, actions)
			for a in actions:
				aid = a["aid"]
				detail = a["a_detail"]

				if qid not in dct:
					dct[qid] = []
				dct[qid].append((aid, detail))
	return dct

def print_action_in_qid(dct):
	print "qid\t\taid\t\tdetails"
	for (k, v) in dct.iteritems():
		for x in v:
			print k, "\t\t", x[0], "\t\t", x[1]

def get_game_over_data(dct):
	go = []
	for (k, v) in dct.iteritems():
		for a in v:
			if a[0] != 1:
				continue
			detail = ast.literal_eval(a[1])
			room = detail["room"]
			time = detail["time"]
			xLoc = detail["x"]
			yLoc = detail["y"]
			go.append([room, xLoc, yLoc, time])
	return go

def get_damage_data(dct):
	damage = []
	for (k, v) in dct.iteritems():
		for a in v:
			if a[0] != 9:
				continue
			detail = ast.literal_eval(a[1])
			room = detail["room"]
			xLoc = detail["x"]
			yLoc = detail["y"]
			enemy = detail["enemy"]
			damage.append([room, xLoc, yLoc, enemy])
	return damage


def get_damage_per_enemy(tbl):
	lvl = {}
	for x in tbl:
		room = x[0]
		enemy = x[3]
		if room not in lvl:
			lvl[room] = {}
		if enemy not in lvl[room]:
			lvl[room][enemy] = 0

		lvl[room][enemy] += 1

	for k in lvl:
		room = k
		max_cnt = -1
		enemy = None
		total = sum(lvl[k].values())
		for kk in lvl[k]:
			e = kk
			val = lvl[k][kk]
			if val > max_cnt:
				max_cnt = val
				enemy = e

		lvl[k] = (enemy, float(max_cnt) / total)

	return lvl

def get_enemy_kill_data(dct):
	kill = []
	for (k, v) in dct.iteritems():
		for a in v:
			if a[0] != 13:
				continue
			detail = ast.literal_eval(a[1])
			room = detail["room"]
			xLoc = detail["x"]
			yLoc = detail["y"]
			enemy = detail["type"]
			kill.append([room, xLoc, yLoc, enemy])
	return kill

def get_player_coor(dct):
	lvl = {}
	for (k, v) in dct.iteritems():
		for a in v:
			if a[0] != 77:
				continue
			detail = ast.literal_eval(a[1])
			room = detail["room"]
			if room == 99:
				continue
			xLoc = detail["x"]
			yLoc = detail["y"]
			if room not in lvl:
				lvl[room] = []
			lvl[room].append((xLoc, yLoc))
	return lvl

def print_table(lst, header):
	print header
	print "----------------------------"
	for x in lst:
		row = ""
		for r in x:
			row += str(r) + "\t\t\t"
		print row


def get_returning_player_cnt(data):
	uid_cnt = 0
	ret_cnt = 0
	max_cnt = -1
	total_ret_cnt = 0
	for d in data:
		pl = d["pageloads"]
		uid_cnt += 1
		cnt = 0
		for p in pl:
			if p["cid"] == CID:
				cnt += 1
		if cnt > 1:
			ret_cnt += 1
			total_ret_cnt += cnt
		if cnt > max_cnt:
			max_cnt = cnt

	return (uid_cnt, ret_cnt, max_cnt, (float(total_ret_cnt) / ret_cnt))

def get_replay_level_cnt(dct):
	rep_lvl = {}
	for (k, v) in dct.iteritems():
		uid = k
		for (kk, vv) in dct[k].iteritems():
			if kk not in rep_lvl:
				rep_lvl[kk] = {}
				rep_lvl[kk]["cnt"] = 0
				rep_lvl[kk]["user"] = []
			rep_lvl[kk]["cnt"] += len(vv)

			if uid not in rep_lvl[kk]["user"]:
				rep_lvl[kk]["user"].append(uid)
	return rep_lvl

def print_replay_level_cnt(dct):
	print "qid\t\treplay count\t\t# of user"
	for k in sorted(dct):
		qid = k
		rep_cnt = dct[k]["cnt"]
		user_cnt = len(dct[k]["user"])
		print k, "\t\t", rep_cnt, "\t\t", user_cnt

def get_table_count(lst):
	dt = {}
	for x in lst:
		if x[0] not in dt:
			dt[x[0]] = 0
		dt[x[0]] += 1
	
	ret = []
	for (k, v) in dt.iteritems():
		ret.append((k, v))
	return ret

def get_level_data(data):
	dct = {}
	for d in data:
		for l in d["levels"]:
			if l["cid"] != CID:
				continue
			qid = l["qid"]
			if qid == 99:
				continue
			end = l["quest_end"]

			detail = ast.literal_eval(l["q_detail"])

			room = detail["src"] + 1

			# get the room from action
			act = l["actions"]
			room = get_src_from_action(room, act)

			if room not in dct:
				dct[room] = {}
				dct[room]["enter"] = 0
				dct[room]["exit"] = 0
				dct[room]["avg_time"] = 0
				dct[room]["max_time"] = -1
				dct[room]["min_time"] = None
				dct[room]["time"] = []

			dct[room]["enter"] += 1
			if end != None:
				detail = ast.literal_eval(end["q_detail"])
				# game over before finishing level
				if "time" in detail:
					if "dest" in detail:
						dct[room]["exit"] += 1
						time = detail["time"]
						dct[room]["avg_time"] += time
						dct[room]["time"].append(time)
						# check max time
						if dct[room]["max_time"] < time:
							dct[room]["max_time"] = time

						# check min time
						if dct[room]["min_time"] == None or dct[room]["min_time"] > time:
							dct[room]["min_time"] = time

	# calculate average time:
	for (k, v) in dct.iteritems():
		if v["exit"] != 0:
			dct[k]["avg_time"] = float(v["avg_time"]) / v["exit"]

	# make as a table:
	tbl = []
	for (k, v) in dct.iteritems():
		time = sorted(v["time"])
		if len(time) < 1:
			continue
		tbl.append((k, v["enter"], v["exit"], v["avg_time"], v["max_time"], v["min_time"], time[len(time)/2]))

	return tbl


def get_unique_player_per_level(data):
	dct = {}
	for d in data:
		uid = d["uid"]
	
		lvl = {}
		for l in d["levels"]:
			if l["cid"] != CID:
				continue
			qid = l["qid"]
			if qid == 99:
				continue
			end = l["quest_end"]

			detail = ast.literal_eval(l["q_detail"])
			room = detail["src"] + 1

			# get the room from action
			act = l["actions"]
			room = get_src_from_action(room, act)

			if room not in lvl:
				lvl[room] = False

			if end != None:
				lvl[room] = True

		dct[uid] = lvl

	# get number of unique playthrough per level
	lvl = {}
	for k  in dct:
		uid = k
		for kk in dct[k]:
			room = kk
			if room not in lvl:
				lvl[room] = {}
				lvl[room]["enter"] = 0
				lvl[room]["exit"] = 0
			# update count
			lvl[room]["enter"] += 1
			if dct[k][kk]:
				lvl[room]["exit"] += 1

	# turn to table
	tbl = []
	for k in lvl:
		tbl.append((k, lvl[k]["enter"], lvl[k]["exit"]))
	return sorted(tbl)


def main():
	if len(sys.argv) < 2:
		print "Usage: python dataparser.py <JSON-file>"
		exit()

	fname = sys.argv[1]

	with open(fname, 'r') as data_file:    
		data = json.load(data_file)

	qid_data = get_qid_data(data)
	action_data = get_action_in_qid(data)
	game_over_data = get_game_over_data(action_data)
	damage_data = get_damage_data(action_data)

	# QID/level data
	#print_qid_data(qid_data)
	#print

	# Action data
	#print_action_in_qid(action_data)
	#print

	# Game over data
	#print_table(game_over_data, "Room\t\t\tx-loc\t\t\ty-loc\t\t\ttime")
	#print

	# # of game over / level
	#print_table(get_table_count(game_over_data), "Room\t\t\t# of game over")
	#print

	# Damage/Hit data (by enemy)
	#print_table(damage_data, "Room\t\t\tx-loc\t\t\ty-loc\t\t\tenemy")
	#print

	#get_damage_per_enemy(damage_data)
	#print

	# # of damage / level
	#print_table(get_table_count(damage_data), "Room\t\t\t# of damage")
	#print

	# Enemy kill data (by player)
	#print_table(get_enemy_kill_data(action_data), "Room\t\t\tx-loc\t\t\ty-loc\t\t\tenemy")
	#print

	# Returning player (# of unique player, # of returning player, # of max return play, average of return play)
	#print get_returning_player_cnt(data)
	#print

	# # of level replayed (by level qid (different dqid))
	#print_replay_level_cnt(get_replay_level_cnt(qid_data))
	#print

	# level info (enter, exit, avg time, max time, min time)
	#print_table(get_level_data(data), "Room\t\t\t# of enter\t\t\t# of exit\t\t\tavg time\t\t\tmax time\t\t\tmin time")
	#print

	# of unique player per level
	#print_table(get_unique_player_per_level(data), "Room\t\t\t# of unique enter\t\t\t# of unique exit")
	#print

	# get heat map coordinate
	#heat = get_player_coor(action_data)

	#for (x, y) in heat[3]:
	#	print x

	#print

	#for (x, y) in heat[3]:
	#	print y

	#print data[0]["levels"][0]["log_q_ts"]
	#print data[0]["levels"][0]["actions"][0]["ts"]


	return

if __name__ == "__main__":
    main()