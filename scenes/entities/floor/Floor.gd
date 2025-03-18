extends StaticBody2D



var old_layer_mask = 0
var old_collision_mask = 0

var fallzone_prefab = load("res://scenes/entities/fall_zone/FallZone.tscn")

enum _TYPE {red, blue}
export(_TYPE) var _type = _TYPE.red
export var use_random_type = true

onready var world = get_tree().root.get_node("EndlessMap")
var floor_index
var color

var playerTouched = false
var playerLeft = false


var Body = self

# Called when the node enters the scene tree for the first time.
func _ready():
	world.floor_index = world.floor_index + 1
	floor_index = world.floor_index
	
	name = str(floor_index)
	
	if use_random_type:
		var rand = randi()%2
		if rand == 0:
			_type = _TYPE.red
		else:
			_type = _TYPE.blue

	
	if _type == _TYPE.red:
		$ColorRect.color = Color.red
	else:
		$ColorRect.color = Color.blue
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not world:
		return

	$Label.text = "Floor " + str(floor_index)
	
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("Player"):
#			if world.get_node("floors").get_child_count() > floor_index:
			if true:
#				body.tween_to(world.get_node("floors").get_node(str(floor_index+1)).position.x - 100, 
#				world.get_node("floors").get_node(str(floor_index+1)).position.y - 130)

				# player sound for jumping off player 
				if not playerLeft:
					body.tween_to(world.get_node("floors").get_node(str(floor_index+1)).position.x - 100, 
					world.get_node("floors").get_node(str(floor_index+1)).position.y - 130)

					body.get_node("jumped").stop()
					body.get_node("jumped").play()
					
					# Spawn new floor
					world.get_node("spawner").spawn()
					
					playerLeft = true
				pass

			

	for body in $boxbond.get_overlapping_bodies():
		if body.is_in_group("Player"):

			# update player touched
			if  not playerTouched:
				body.touched_floors += 1
				playerTouched = true

				# player sound for touch ground (landing)
#				body.get_node("landed").stop()
#				body.get_node("landed").play()

				# add a fall zone bellow
				var fall_zone_instance = fallzone_prefab.instance()
				fall_zone_instance.position = $CollisionShape2D.position
				fall_zone_instance.position.y += 1000
				
				add_child(fall_zone_instance)

			#Check wrong Player shoe color
			check_player_shoe(body)
			
	check_self_boundry()
	
#	update()

func check_player_shoe(body):
	Body = body
	if body.shoe_color == Color.red and _type == _TYPE.red:
		pass
	elif body.shoe_color == Color.blue and _type == _TYPE.blue:
		pass
	else:
		if not Global.debug:
			disable(self)


func check_self_boundry():
	if Body.is_in_group("Player"):
		var limit = 3000#1500
		if to_local(Body.global_position).x - $CollisionShape2D.position.x  > limit:
			queue_free()


func _drawww():
	draw_line($CollisionShape2D.position, to_local(Body.global_position), Color.beige, 10)
	pass

func enable(v):
	v.set_collision_layer_bit(old_layer_mask, true)
	v.set_collision_mask_bit(old_collision_mask, true)

func disable(v):
	old_layer_mask = v.collision_layer
	old_collision_mask = v.collision_mask
	v.set_collision_layer_bit(0, false)
	v.set_collision_mask_bit(0, false)
