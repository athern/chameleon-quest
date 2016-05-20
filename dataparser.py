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
#								Projectile
#	11	-	Element change
#	12	-	Pick up rock
#	13	-	Enemy kill
#	14	-	Retry


def get_qid_data(data):
	dct = {}
	for d in data:
		uid = d["uid"]
		if uid not in dct:
			dct[uid] = {}
		for l in d["levels"]:
			qid = l["qid"]
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
			qid = l["qid"]
			actions = l["actions"]
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
			room = k
			detail = ast.literal_eval(a[1])
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
			room = k
			detail = ast.literal_eval(a[1])
			xLoc = detail["x"]
			yLoc = detail["y"]
			enemy = detail["enemy"]
			damage.append([room, xLoc, yLoc, enemy])
	return damage

def get_enemy_kill_data(dct):
	kill = []
	for (k, v) in dct.iteritems():
		for a in v:
			if a[0] != 13:
				continue
			print a[1]
			room = k
			detail = ast.literal_eval(a[1])
			xLoc = detail["x"]
			yLoc = detail["y"]
			enemy = detail["type"]
			kill.append([room, xLoc, yLoc, enemy])
	return kill

def print_table(lst, header):
	print header
	print "----------------------------"
	for x in lst:
		row = ""
		for r in x:
			row += str(r) + "\t\t\t"
		print row

def main():
	if len(sys.argv) < 2:
		print "Usage: python dataparser.py <JSON-file>"
		exit()

	fname = sys.argv[1]

	with open(fname, 'r') as data_file:    
		data = json.load(data_file)

	qid_data = get_qid_data(data)
	action_data = get_action_in_qid(data)

	# QID/level data
	#print_qid_data(qid_data)
	#print

	# Action data
	#print_action_in_qid(action_data)
	#print

	# Game over data
	print_table(get_game_over_data(action_data), "Room\t\t\tx-loc\t\t\ty-loc\t\t\ttime")
	print

	# Damage/Hit data (by enemy)
	print_table(get_damage_data(action_data), "Room\t\t\tx-loc\t\t\ty-loc\t\t\tenemy")
	print

	# Enemy kill data (by player)
	print_table(get_enemy_kill_data(action_data), "Room\t\t\tx-loc\t\t\ty-loc\t\t\tenemy")

	return

if __name__ == "__main__":
    main()