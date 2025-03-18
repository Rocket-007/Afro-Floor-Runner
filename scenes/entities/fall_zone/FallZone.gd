extends Area2D


var playerTouched = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for body in get_overlapping_bodies():
		if body.is_in_group("Player") and not playerTouched:
			body.get_node("game_over_time").start()
			playerTouched = true
