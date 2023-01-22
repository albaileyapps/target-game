extends Control

signal edit_teams_pressed
signal scene_button_pressed(p_scene_name)
# Called when the node enters the scene tree for the first time.
func _ready():
	$ScrollContainer.get_v_scrollbar().modulate.a = 0
	$ScrollContainer.get_v_scrollbar().visible = false
	
	get_node("%SceneButton1").connect("pressed", self, "on_SceneButton_pressed", ["TargetScene1"])
	get_node("%SceneButton2").connect("pressed", self, "on_SceneButton_pressed", ["TargetScene1"])
	get_node("%SceneButton3").connect("pressed", self, "on_SceneButton_pressed", ["TargetScene1"])
	get_node("%SceneButton4").connect("pressed", self, "on_SceneButton_pressed", ["TargetScene1"])


func _on_EditTeamsButton_pressed():
	emit_signal("edit_teams_pressed")
	
func on_SceneButton_pressed(p_scene_name):
	emit_signal("scene_button_pressed", p_scene_name)
	
