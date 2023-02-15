extends PanelContainer

var default_panel_color = Color.white
var team: Team

var is_pressed = false
var touch_down_time = 0
var touch_down_pos = Vector2(0,0)

var is_selected = false setget set_is_selected

#the score label is updated by 1/-1 on a timer - this is the total amount to change it
var score_delta = 0 setget set_score_delta

signal team_pressed(p_team)

func setup(p_team: Team):
	team = p_team

func _ready():
	team.connect("changed", self, "on_team_changed")
	set_labels()
	
func set_labels():
	get_node("%NameLabel").text = team.team_name
	get_node("%ScoreLabel").text = String(team.score)
	
func set_text_size():
	pass
	
func on_team_changed():
	set_labels()

func set_is_selected(p_val):
	if p_val:
		is_selected = true
		material.set_shader_param("panel_color", Color("A6F1F1"))
	else: 
		is_selected = false
		material.set_shader_param("panel_color", Color.white)
		
func set_score_delta(p_val):
	score_delta = p_val
#	if $ScoreChangeTimer.is_stopped():
	$ScoreChangeTimer.start()
	

func _on_TeamLabel_gui_input(event):
	if event is InputEventScreenTouch and event.pressed:
		touch_down_time = OS.get_system_time_msecs()
		touch_down_pos = get_local_mouse_position()
	if event is InputEventScreenTouch and !event.pressed:
		print(get_local_mouse_position().distance_to(touch_down_pos))
		print(OS.get_system_time_msecs() - touch_down_time)
		if get_local_mouse_position().distance_to(touch_down_pos) > 10:
			return
		if OS.get_system_time_msecs() - touch_down_time > 500:
			return
		SoundManager.play(SoundManager.CLICK)
		emit_signal("team_pressed", self)


func _on_ScoreChangeTimer_timeout():
	SoundManager.play(SoundManager.SCORE)
	team.score += sign(score_delta)
	score_delta += sign(-score_delta)
	if score_delta == 0:
		$ScoreChangeTimer.stop()
	
