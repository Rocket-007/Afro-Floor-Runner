extends Node2D





#### SETTINGS ######
var debug = false

var music_vol = 0.0
var sfx_vol = 0.0

var landscape = true
var show_shoe_trail = true
var show_color_control = true
#var show_shoe_path
##########################



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_vol)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), sfx_vol)
	
#	if Input.is_key_pressed(KEY_R):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	pass
	







func instance_node_at_location(node: Object, parent: Object, location: Vector2) -> Object:
#	var node_instance = instance_node(node, parent)
#	node_instance.global_position = location
#	return node_instance
	var node_instance = node.instance()
	node_instance.global_position = location
	parent.add_child(node_instance)
	return node_instance


func instance_node(node: Object, parent: Object) -> Object:
	var node_instance = node.instance()
	parent.add_child(node_instance)
	return node_instance


func clone(node: Node) -> Node:
	var copy = node.duplicate()
	# see https://docs.godotengine.org/en/3.1/classes/class_object.html#id2
	var properties: Array = node.get_property_list()

	var script_properties: Array = []

	for prop in properties:
		# see https://docs.godotengine.org/en/3.1/classes/class_@globalscope.html#enum-globalscope-propertyusageflags
			# basically here we are getting any of the user-defined script variables that exist, since those apparently don't
			# get copied via `duplicate()`
		if prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE == PROPERTY_USAGE_SCRIPT_VARIABLE:
			script_properties.append(prop)

	for prop in script_properties:
		copy.set(prop.name, node[prop.name])

	return copy
