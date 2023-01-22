extends Resource
class_name Team

export var team_name = "" setget set_team_name, get_team_name
export var score = 0 setget set_score, get_score

func _init(p_name, p_score):
	team_name = p_name
	score = p_score

func set_team_name(p_val):
	team_name = p_val
	emit_changed()

func get_team_name():
	return team_name
	
func set_score(p_val):
	score = p_val
	emit_changed()
	
func get_score():
	return score
