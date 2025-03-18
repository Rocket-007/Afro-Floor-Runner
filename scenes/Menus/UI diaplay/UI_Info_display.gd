extends CanvasLayer

### not most of these nodes are not named properly, I am just to lazy!!
onready var the_world = get_tree().current_scene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/VBoxContainer/game_time.text = "FLOOR: " + str(the_world.get_node("Player").touched_floors)
#	$Control/VBoxContainer/game_time2.text = "WAVE: " + str(the_world.wave)
#	$Control/VBoxContainer/game_time3.text = "SCORE: " + str(the_world.game_score[0])


func format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]
	var milliseconds := fmod(time, 1) * 100
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
