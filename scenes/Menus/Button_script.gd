extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var animated_idle = false

var the_rect_position
var the_rect_size

# Called when the node enters the scene tree for the first time.
func _ready():
	
	connect("button_down", self, "_on_button_down")
	connect("button_up", self, "_on_button_up")
	connect("pressed", self, "_on_pressed")

	yield(get_tree(), "idle_frame")
	the_rect_position = rect_position
	the_rect_size = rect_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animated_idle:
#		rect_size.move_toward(rect_size - Vector2(20, 20), 1.4)
#		rect_position.move_toward(rect_position + Vector2(20/2, 20/2), 1)
#		rect_position += Vector2(23,23)
		
#		rect_size = max(rect_size - Vector2(20, 20), rect_size - Vector2(20, 20))
		
#		rect_size.x = min(rect_size.x - 20, the_rect_size.x + 20)
#		rect_size.y = max(rect_size.y - 20, the_rect_size.y + 20)
		pass

func _on_button_down():
#	the_rect_position = rect_position
#	the_rect_size = rect_size
	rect_size = rect_size - Vector2(20, 20)
	rect_position = rect_position + Vector2(20/2, 20/2)

func _on_button_up():
	rect_position = the_rect_position
	rect_size = the_rect_size

func _on_pressed():
	Global.get_node("button_pressed").play()
