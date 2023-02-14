
extends Sprite

export var press_scale_x: float = 1.08
export var press_scale_y: float = 0.92
export var score = 10

var is_pressed = false
var touch_down_time = 0
var touch_down_pos = Vector2(0,0)

const TARGET_BUTTON_GROUP = "target_button_group"

signal pressed(p_score)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(TARGET_BUTTON_GROUP)
#	var animation_name = $AnimationPlayer.current_animation # or some other name
	print(press_scale_x)
	var animation = $AnimationPlayer.get_animation("press_down")
	animation.track_set_key_value(0, 1, Vector2(press_scale_x, press_scale_y))


func _unhandled_input(event):
	if event is InputEventScreenTouch and event.pressed:
		print("button pressed")
		if !is_pixel_opaque(get_local_mouse_position()): return
		touch_down_time = OS.get_system_time_msecs()
		touch_down_pos = get_viewport().get_mouse_position()
		press_down()
		get_tree().set_input_as_handled() 
	if event is InputEventScreenTouch and !event.pressed:
		if get_viewport().get_mouse_position().distance_to(touch_down_pos) > 10:
			return
		if OS.get_system_time_msecs() - touch_down_time > 400:
			return
		get_tree().set_input_as_handled() 
		emit_signal("pressed", score)

func _input(event):
#	if !DataManager.get_touch_enabled(): return
	if event is InputEventScreenTouch and !event.pressed:
		press_up()
	
func press_down():
	if !is_pressed:
		$AnimationPlayer.play("press_down")
		is_pressed = true

func press_up():
	if is_pressed:
		$AnimationPlayer.play_backwards("press_down")
		is_pressed = false

