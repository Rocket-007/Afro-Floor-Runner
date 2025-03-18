extends Control

var LabelPrefab = load("res://Scenes/Menus/UI diaplay/push_Text_Notification/push_Label.tscn")

#var message_array = ["Let's", "Do", "This!"]
var message_array = []
var message_array_size_max = 9


# Called when the node enters the scene tree for the first time.
func _ready():
	return


func _process(delta):
	if message_array.size() == 0:
		$Timer.wait_time = 0.05
	else:
		$Timer.wait_time = 0.5
#		$Timer.start(0.05)


func push_message(message):
#	var the_label = LabelPrefab.instance()
#	the_label.text = message
#	add_child(the_label)
	message_array.append(message)


func _input(event):
	return
	if event is InputEventMouseButton and event.is_pressed():
		
		push_message("sdfsdfsdfsfsfsefsefsefsffsefsefs2")


func _on_Timer_timeout():
	if message_array.size() > 0:
		var the_label = LabelPrefab.instance()
		the_label.text = message_array[0]
		add_child(the_label)
		message_array.pop_front()
