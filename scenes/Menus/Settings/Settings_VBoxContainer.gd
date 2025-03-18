extends VBoxContainer


var has_exec = false

func run_ready():
	for i in get_child_count():
		var _v = get_child(i)
		for ii in get_child(i).get_child_count():
			if get_child(i).get_child_count() >= 2: # probably a line
				var _vv = _v.get_child(0)
				if _vv is Label:
					var attribute = _vv.text

					if _v.get_child(1) is CheckBox:
						var the_checkBox = _v.get_child(1)
						if attribute in Save.game_data:
							if typeof(Save.game_data[attribute]) == typeof(the_checkBox.pressed):
								the_checkBox.pressed = Save.game_data[attribute]

					if _v.get_child(1) is HSlider:
						var the_HSlider = _v.get_child(1)
						if attribute in Save.game_data:
							if typeof(float(Save.game_data[attribute])) == typeof(float(the_HSlider.value)):
								the_HSlider.value = Save.game_data[attribute]
						
						# display the HSliders value with the label below it 
						if _v.get_child_count() > 2:
							_v.get_child(2).text = str(the_HSlider.value)

					if _v.get_child(1) is SpinBox:
						var the_SpinBox = _v.get_child(1)
						if attribute in Save.game_data:
							if typeof(Save.game_data[attribute]) == typeof(int(the_SpinBox.value)):
								the_SpinBox.value = Save.game_data[attribute]


func _ready():
	run_ready()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not visible:
		return

	# Need to run it again to get the right values for them
	if not has_exec:
		run_ready()
		has_exec = true

	for i in get_child_count():
		var _v = get_child(i)
		for ii in get_child(i).get_child_count():
			if get_child(i).get_child_count() >= 2: # probably a line
				var _vv = _v.get_child(0)
				if _vv is Label:
					var attribute = _vv.text

					if _v.get_child(1) is CheckBox:
						var the_checkBox = _v.get_child(1)
						if attribute in Global:
							if typeof(Global[attribute]) == typeof(the_checkBox.pressed):
								Global[attribute] = the_checkBox.pressed
								Save.game_data[attribute] = the_checkBox.pressed

					if _v.get_child(1) is HSlider:
						var the_HSlider = _v.get_child(1)
						if attribute in Global:
							if typeof(float(Global[attribute])) == typeof(float(the_HSlider.value)):
								Global[attribute] = the_HSlider.value
								Save.game_data[attribute] = the_HSlider.value
						
						# display the HSliders value with the label below it 
						if _v.get_child_count() > 2:
							_v.get_child(2).text = str(the_HSlider.value)

					if _v.get_child(1) is SpinBox:
						var the_SpinBox = _v.get_child(1)
						if attribute in Global:
							if typeof(Global[attribute]) == typeof(int(the_SpinBox.value)):
								Global[attribute] = int(the_SpinBox.value)
								Save.game_data[attribute] = int(the_SpinBox.value)



func _on_CheckButton_toggled(button_pressed):
#	Globalsettings.toggle_vsync(button_pressed)
	pass

	
func _on_MaxFpsSlider_value_changed(value):
#	Globalsettings.set_max_fps(value)
#	max_fps_val.text = str(value) if value < max_fps_slider.max_value else "max"
	pass


func _on_MouseSlider_value_changed(value):
#	Globalsettings.update_mouse_sens(value)
#	mouse_sens_amount.text = str(value)
	pass
	


func _on_Settings_VBoxContainer_visibility_changed():
#	run_ready()
	pass
