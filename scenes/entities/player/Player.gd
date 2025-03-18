extends KinematicBody2D


var in_air = false
var jumping = true
var on_ground = true
var runnig = true

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1000#ProjectSettings.get_setting("physics/2d/default_gravity")
var velocity = Vector2.ZERO

onready var world = get_tree().root.get_node("EndlessMap") # get_parent()

var line: Line2D
var line2: Line2D
var trailLength: int = 15

var shoe_color = Color.red

var touched_floors = 0


func _ready():
	# drawing trails  tuff
	line = get_node("Line2D")
	line2 = get_node("Line2D2")
	remove_child(line)
	remove_child(line2)
#	world.add_child(line)
	world.get_node("line_CanvasLayer").call_deferred("add_child", line)
	world.get_node("line_CanvasLayer").call_deferred("add_child", line2)
	


func _physics_process(delta):
	simple_godot4_controller(delta)
	update_animation()
#	draw_trail()
	extra_control_keys()
	
#	$Label.text = "floors remaingi " + str(get_parent().get_node("floors").get_child_count()) + "\n" + str(velocity.x)


func draw_trail():
	if not Global.show_shoe_trail:
		return
	if not is_instance_valid(line):
		return
	if not is_instance_valid(line2):
		return
	
	var t_position = $character/Skeleton2D/pant/Bone2D/Bone2D2/Bone2D3.global_position - Vector2(-16, 50)
	var t_position2 = $character/Skeleton2D/pant/Bone2D2/Bone2D2/Bone2D3.global_position - Vector2(10, 50)
	line.add_point(t_position)
	line2.add_point(t_position2)
	
	line.gradient.colors[0] = shoe_color
	line.gradient.colors[0].a = 0
	line.gradient.colors[1] = shoe_color
	
	var op = 0.5
	$character/polygons/left_shoe_glow.color = shoe_color
	$character/polygons/left_shoe_glow.color.a = op
	$character/polygons/right_shoe_glow.color = shoe_color
	$character/polygons/right_shoe_glow.color.a = op
	
	if line.points.size() > trailLength:
		line.remove_point(0)
		pass
	if line2.points.size() > trailLength:
		line2.remove_point(0)
		pass

func extra_control_keys():
	if Input.is_action_pressed("zoom_in"):
		$Camera2D.zoom += Vector2(0.02, 0.02)
	if Input.is_action_pressed("zoom_out"):
		$Camera2D.zoom -= Vector2(0.02, 0.02)

	if Input.is_action_pressed("stop"):
		Engine.time_scale = 0
	elif Input.is_action_pressed("stop"):
		Engine.time_scale = 1
	else:
		Engine.time_scale = 1
		pass

	if Input.is_action_just_pressed("ui_left"):
		shoe_color = Color.red
	if Input.is_action_just_pressed("ui_right"):
		shoe_color = Color.blue

var jump_tween_counter = 0
func tween_to(to_pos, to_pos2):
	# player is jumping off so lets change the animation
	
#	if $character/AnimationPlayer.current_animation == "run":
#		if $character/AnimationPlayer.current_animation_position > 2.1:
#			if jump_tween_counter < 2.1:
#				jump_tween_counter += 0.2
#				$character/AnimationPlayer.seek(jump_tween_counter)
#				pass
				
	
	
	
	var min_time = 0.1
	var max_time = 0.8
	var animation_speed_range : float = max_time - min_time
	
	var normalized_floors_walked = touched_floors / 30.0  # Assuming you want the animation speed to max out at 30 floors walked
	var current_animation_speed = max(max_time - normalized_floors_walked * animation_speed_range, 0.1)
  
	$Label.text = str(current_animation_speed)
	
	# tween for the movement of the X
	$Tween.interpolate_property(self, "position:x", position.x, to_pos,current_animation_speed, Tween.TRANS_SINE, Tween.EASE_OUT)

	# if the next floor is lower than the player
	# interpolate the player y to a higher value for a more real jump effect
	if to_pos2 > position.y:
		$Tween.interpolate_property(self, "position:y", position.y, to_pos2-60, current_animation_speed, Tween.TRANS_SINE, Tween.EASE_OUT)
	else:
		$Tween.interpolate_property(self, "position:y", position.y, to_pos2 + 10, current_animation_speed, Tween.TRANS_SINE, Tween.EASE_OUT)

	$Tween.start()


func update_animation():
	if is_on_floor():
		if touched_floors >= 0 and touched_floors < 41:
			$character/AnimationPlayer.playback_speed = 2
		elif touched_floors >= 41:
			$character/AnimationPlayer.playback_speed = 3

		jump_tween_counter = 0
		
#		$character/AnimationPlayer.stop()
#		$character/AnimationPlayer.play("idk")
		if $character/AnimationPlayer2.current_animation == "idk":
			pass
		if $character/AnimationPlayer.current_animation == "":
#			$character/AnimationPlayer.stop()
			$character/AnimationPlayer.play("run")
				
	else:
		
		# slow down the slits animation
		$character/AnimationPlayer.playback_speed = 0.3
		
		# animate the restart of the run if 0.9 secs played
		if $character/AnimationPlayer.current_animation == "run":
			if $character/AnimationPlayer.current_animation_position <= 0.9:
				if jump_tween_counter < 0.9:
					jump_tween_counter += 0.4
					$character/AnimationPlayer.seek(min(0.9, jump_tween_counter))
		pass
		


func simple_godot4_controller(delta):
	# controlling the velocity based on the floors reached
	velocity.x = SPEED + (1 * touched_floors)

	# Add the gravity.
	if not is_on_floor():
		if not $Tween.is_active():
#			velocity.y += gravity * delta
			pass
		pass

	velocity.y += gravity * delta

	if $Tween.is_active():
		velocity = Vector2.ZERO

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
		pass

	var direction
#	direction = Input.get_axis("ui_left", "ui_right")
	direction = Vector2.ZERO
	if direction:
		velocity.x = direction * SPEED
	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
		pass

	move_and_slide(Vector2(velocity), Vector2.UP, false, 4, PI/4, true)


func _on_line_Timer_timeout():
	draw_trail()
	pass


func _on_game_over_time_timeout():
#	hide()
#	$Camera2D.current = false
	$vine_boom.play()
	pass
