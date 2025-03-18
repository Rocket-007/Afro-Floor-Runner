extends Control




#onready var pause = $UI_CanvasLayer/Panel
onready var pause = $UI_CanvasLayer/Pause

var is_world = true
var floor_index = 0
var game_over = false
var done_bend_music = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI_CanvasLayer/Settings/Panel3/back_settings.connect("pressed", self, "_on_settings_button_close")
	$Player/game_over_time.connect("timeout", self, "_on_game_over")
	
	$UI_Info_display/PushTextOnTopCanvas/push_Text_Notification.push_message("GO! GO!! GO!!!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("settings"):
		settings_options()
	
	if Global.show_color_control:
		$Touch_CanvasLayer/touch_Control.modulate.a = 1.0#0.04
	else:
		$Touch_CanvasLayer/touch_Control.modulate.a = 0
		
	# Game Over Bend Sound
	if not done_bend_music:
#		$Main_song.pitch_scale -= delta *1.9
		if $Main_song.pitch_scale <= 0.01:
			done_bend_music = true
		$Main_song.stop()
		done_bend_music = true
		


func _notification(what):
	# if game is over then you  cant pause or show deathmatch scores
#	if has_node("PauseCanvas/game_over"):
#		if $PauseCanvas/game_over.visible:
#			return

		
		if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST and not pause.visible:
			# For Windows
			get_tree().paused = true
			pause.show()
		elif what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST and pause.visible:
			# For Windows
			get_tree().paused = false
			pause.hide()
			Engine.time_scale = 1
			
		if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST and not pause.visible:
			# For Android
			get_tree().paused = true
			pause.show()
#			Engine.time_scale = 0
		elif what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST and pause.visible:
			# For Android
			get_tree().paused = false
			pause.hide()
#			Engine.time_scale = 1


func _on_pause_pressed():
	get_tree().paused = true
	pause.show()
	$UI_CanvasLayer/pause.hide()
	$UI_CanvasLayer/resume.show()


func _on_resume_pressed():
	get_tree().paused = false
	pause.hide()
	$UI_CanvasLayer/pause.show()
	$UI_CanvasLayer/resume.hide()


func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Menus/MainMenu.tscn")


func _on_settings_button_close():
	$UI_CanvasLayer/Settings.hide()
	$UI_CanvasLayer/Pause.show()


func settings_options():
	if $UI_CanvasLayer/Settings.visible:
		$UI_CanvasLayer/Settings.hide()
	else:
#		$UI_CanvasLayer/Pause.hide()
		$UI_CanvasLayer/Settings.show()
	pass

func _on_settings_pressed():
	settings_options()


func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	

func _on_game_over():
	$UI_CanvasLayer/game_over.show()
	$UI_CanvasLayer/game_over/Panel3/Info_board.game_over_endless()
	done_bend_music = false


func _on_left_touch_area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		Gesture._left()

func _on_right_touch_area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		Gesture._right()

# use this to kill the player in case of failed fall zone
func _on_die_pressed():
	$Player.get_node("game_over_time").start()
	$UI_CanvasLayer/die.hide()
