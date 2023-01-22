extends ScrollContainer

var teams = preload("res://resources/teams.tres")
var team_label = preload("res://scenes/components/TeamLabel.tscn")
var selected_team_label 

const TEAM_LABEL_GROUP = "team_label_group"

# Called when the node enters the scene tree for the first time.
func _ready():
	build_team_list()
	teams.connect("changed", self, "build_team_list")


func build_team_list():
	remove_list_items()
	for team in teams.list:
		var label = team_label.instance()
		label.setup(team)
		label.add_to_group(TEAM_LABEL_GROUP)
		label.connect("team_pressed", self, "on_team_pressed")
		$TeamLabelsVBox.add_child(label)
		
func remove_list_items():
	for n in $TeamLabelsVBox.get_children():
		n.queue_free()

func on_team_pressed(p_team):
	var team_labels = get_tree().get_nodes_in_group(TEAM_LABEL_GROUP)
	for label in team_labels:
		label.is_selected = false
	p_team.is_selected = true
