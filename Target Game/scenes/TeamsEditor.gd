extends Control

var teams = preload("res://resources/teams.tres")
var team_list_item = preload("res://scenes/TeamsEditorListItem.tscn")

signal exit

# Called when the node enters the scene tree for the first time.
func _ready():
	build_list()
	teams.connect("changed", self, "on_teams_changed")

func add_team(p_name):
	teams.add_team(p_name)
	
func build_list():
	for team in teams.list:
		add_list_item(team)
	
func remove_list_items():
	var children = get_node("%TeamList").get_children()
	for child in children:
		child.queue_free()
		
func add_list_item(p_team):
	var list_item = team_list_item.instance()
	list_item.setup(p_team)
	list_item.connect("remove_team", self, "remove_team")
	get_node("%TeamList").add_child(list_item)
	
func on_teams_changed():
	remove_list_items()
	build_list()


func _on_AddTeamButton_pressed():
	add_team("new team")
	
func remove_team(p_team):
	teams.remove_team(p_team)

func _on_ExitButton_pressed():
	emit_signal("exit")

func _on_ResetScoresButton_pressed():
	for team in teams.list:
		team.score = 0
