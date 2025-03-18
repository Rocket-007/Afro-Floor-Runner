extends Control



func go_back():
	if get_parent().get_parent().filename == "res://Scenes/Menus/MainMenu/MainMenu.tscn":
		var MainMenu_instance = get_parent().get_parent()
		for v in MainMenu_instance.get_node("Container").get_children():
			v.hide()
		MainMenu_instance.get_node("Container/options").show()
		MainMenu_instance.swoosh_in(MainMenu_instance.get_node("Container/options"))
	else:
		hide()




func _on_settings_visibility_changed():

	Save.save_data()

