tool

extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var col = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var col = get_child(0)
	col.shape.extents = get_parent().rect_size/2
	col.position = get_parent().rect_size/2
	pass
