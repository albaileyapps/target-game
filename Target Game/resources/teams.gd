extends Resource
class_name Teams


var list = [Team.new("Ji Won and Ye Dam", 0),
Team.new("Seon Woo and Yeon Jae", 0),
]

var undo_actions = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_team(p_name):
	if list.size() >= 30: return
	var new_team = Team.new(p_name, 0)
	list.append(new_team)
	emit_changed()
	
func remove_team(p_team):
	list.erase(p_team)
	emit_changed()
	
func undo():
	print("undoing...")
	if undo_actions.size() <= 0: return
	var action = undo_actions.pop_back()
	for team in list:
		if team.resource_path == action["resource_path"]:
			team.score = action["score"]
	
func add_undo_action(p_team: Team):
	print("adding undo action")
#	var action = {
#		"resource_path": p_team.resource_path,
#		"score": p_team.score
#	}
#	undo_actions.append(action)
#	if undo_actions.size() > 5:
#		undo_actions.pop_front()
