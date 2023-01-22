extends Node2D

onready var main_menu = get_node("CanvasLayer/MainMenu")
onready var teams_editor = preload("res://scenes/TeamsEditor.tscn")

var current_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	main_menu.connect("edit_teams_pressed", self, "show_teams_editor")
	main_menu.connect("scene_button_pressed", self, "show_target_scene")

func show_teams_editor():
	var editor = teams_editor.instance()
	editor.connect("exit", self, "exit_teams_editor")
	$CanvasLayer2.add_child(editor)

func exit_teams_editor():
	for child in $CanvasLayer2.get_children():
		child.queue_free()

func show_main_menu():
	main_menu.visible = true
	
func show_target_scene(p_scene_name):
	var scene_path = "res://scenes/%s.tscn"
	main_menu.visible = false
	var scene = load(scene_path % p_scene_name).instance()
	add_child(scene)
	current_scene = scene
	scene.connect("exit_pressed", self, "exit_scene")
	scene.connect("edit_teams_pressed", self, "show_teams_editor")
	
func exit_scene():
	current_scene.queue_free()
	main_menu.visible = true
	
	
	
	
	
