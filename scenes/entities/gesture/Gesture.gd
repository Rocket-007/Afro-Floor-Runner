extends Node

# Minimum distance required for a swipe gesture to be detected
const MIN_SWIPE_DISTANCE = 50

# Minimum duration required for a swipe gesture to be detected
const MIN_SWIPE_DURATION = 0.2

var swipe_start_pos: Vector2
var swipe_start_time: int
var is_swipe_active: bool = false


onready var player = get_tree().root.get_node("EndlessMap/Player")




var swipe_start = null
var minimum_drag = 100

func _unhandled_input(event):
#func _input(event):
#	if event is InputEventScreenTouch:
	if event is InputEventMouse and not event is InputEventMouseMotion:
		if event.pressed:
			swipe_start = event.get_position()
		else:
#			_calculate_swipe(event.get_position())
			pass

func _calculate_swipe(swipe_end):
	if swipe_start == null:
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			print("_right()")
		else:
			print("_left()")
			
	if abs(swipe.y) > minimum_drag:
		if swipe.y > 0:
			_down()
		else:
			_up()




func _down():
	player = get_tree().root.get_node("EndlessMap/Player")
	player.shoe_color = Color.blue
func _up():
	player = get_tree().root.get_node("EndlessMap/Player")
	player.shoe_color = Color.red

func _right():
	player = get_tree().root.get_node("EndlessMap/Player")
	player.shoe_color = Color.blue
func _left():
	player = get_tree().root.get_node("EndlessMap/Player")
	player.shoe_color = Color.red
