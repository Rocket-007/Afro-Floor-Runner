extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var button_positions = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$Settings/Panel3/back_settings.connect("pressed", self, "_on_settings_button_close")
	$Guide/Panel3/back_settings.connect("pressed", self, "_on_guide_button_close")

	# yield a bit to get the correct buttons positions for the swoosh
	yield(get_tree(), "idle_frame")
	
#	Shooosh animate tween the first menu that is visible
	if $Control.visible:
		swoosh_in($Control)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func swoosh_in(node):
	#	store and remove their position
	button_positions.clear()
	for v in node.get_children():
		button_positions.append(v.rect_position)
		v.rect_position += Vector2(0, v.rect_size.y) *2
	
	for i in node.get_child_count():
		var _v = node.get_child(i)
		
		$Tween.interpolate_property(_v, "rect_position", _v.rect_position, button_positions[i], 0.1*(i+2), Tween.TRANS_BACK)
		
	$Tween.start()


func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene("res://scenes/entities/map/EndlessMap.tscn")


func _on_settings_pressed():
	$Control.hide()
	$Settings.show()
	swoosh_in($Settings)

func _on_settings_button_close():
	$Control.show()
	$Settings.hide()
	swoosh_in($Control)

func _on_guide_button_close():
	$Control.show()
	$Guide.hide()
	swoosh_in($Control)


func _on_guide_pressed():
	$Control.hide()
	$Guide.show()
	swoosh_in($Guide)



func _on_socialB_pressed():
	OS.shell_open("https://www.youtube.com/channel/UC8G8IEsYtIkj2hxfnRWhkuQ")


func _on_socialB2_pressed():
	OS.shell_open("https://rocket-007.itch.io/")


func _on_socialB3_pressed():
	OS.shell_open("https://github.com/Rocket-007")
