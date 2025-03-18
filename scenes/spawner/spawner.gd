extends Node2D


export(PackedScene) var resource 
export var wait_time = 1.0
export var use_timer = false

#resource_prefab = load(resource)
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = wait_time
#	$Timer.autostart = true
	if not use_timer:
		spawn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var random_points = [-100, 100, 0] # for the y positions
	var random_points2 = [500, 650, 800] # for the x position distance
	var last_child_floors = get_parent().get_node("floors").get_child(get_parent().get_node("floors").get_child_count()-1)
	
	var randomIndex = randi() % random_points.size()
	var randomIndex2 = randi() % random_points2.size()
	var selectedPoint = random_points[randomIndex]
	var selectedPoint2 = random_points2[randomIndex2]
	
	position = last_child_floors.position + Vector2(selectedPoint2, selectedPoint)


func spawn():
	var resource_instance = resource.instance()
	resource_instance.position = position
	get_parent().get_node("floors").call_deferred("add_child", resource_instance)


func _on_Timer_timeout():
	if use_timer:
		spawn()
	

