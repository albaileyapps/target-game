extends Node2D

var score_label_group_visible = true

signal edit_teams_pressed
signal exit_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	var target_buttons = get_tree().get_nodes_in_group("target_button_group")
	for target in target_buttons:
		target.connect("pressed", self, "on_target_button_pressed")
	
func on_target_button_pressed(p_score):
	print("on target button pressed")
	var team_labels = get_tree().get_nodes_in_group("team_label_group")
	for label in team_labels:
		if label.is_selected:
			label.score_delta += p_score
	
	
func _on_EditTeamsButton_pressed():
	emit_signal("edit_teams_pressed")

func _on_ExitButton_pressed():
	emit_signal("exit_pressed")

func _on_EditButton_pressed():
	emit_signal("edit_teams_pressed")

func _on_HideButton_pressed():
	score_label_group_visible = !score_label_group_visible
	$CanvasLayer/Control/Scoreboard.visible = score_label_group_visible
	$CanvasLayer/Control/HBoxContainer/EditButton.visible = score_label_group_visible
	$CanvasLayer/Control/HBoxContainer/HideButton.text = "HIDE" if score_label_group_visible else "SHOW"

func _unhandled_key_input(event):
	if event.scancode == KEY_UP:
		$TargetButtonParent.position = Vector2($TargetButtonParent.position.x, $TargetButtonParent.position.y - 5)
	if event.scancode == KEY_DOWN:
		$TargetButtonParent.position = Vector2($TargetButtonParent.position.x, $TargetButtonParent.position.y + 5)
	if event.scancode == KEY_LEFT:
		$TargetButtonParent.position = Vector2($TargetButtonParent.position.x - 5, $TargetButtonParent.position.y)
	if event.scancode == KEY_RIGHT:
		$TargetButtonParent.position = Vector2($TargetButtonParent.position.x + 5, $TargetButtonParent.position.y)
	if event.scancode == KEY_MINUS or event.scancode == KEY_KP_SUBTRACT:
		$TargetButtonParent.scale = Vector2($TargetButtonParent.scale.x - 0.05, $TargetButtonParent.scale.y - 0.05)
	if event.scancode == KEY_EQUAL or event.scancode == KEY_KP_ADD:
		$TargetButtonParent.scale = Vector2($TargetButtonParent.scale.x + 0.05, $TargetButtonParent.scale.y + 0.05)
