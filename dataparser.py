import json
import sys

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

def main():
	if len(sys.argv) < 2:
		print "Usage: python dataparser.py <JSON-file>"
		exit()

	fname = sys.argv[1]

	with open(fname, 'r') as data_file:    
		data = json.load(data_file)

	#print_qid_data(get_qid_data(data))
	print_action_in_qid(get_action_in_qid(data))

	return

if __name__ == "__main__":
    main()