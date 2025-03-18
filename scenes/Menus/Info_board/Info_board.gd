extends Control




var highScores = []  # Initialize an empty list for high scores
var currentScoreData : Array = ["",0]

var hasExec_game_over = hasExec_game_over
var hasExec_check_highScore = false # will allow use check once per game

onready var the_world = get_tree().current_scene



func _ready():
	if is_instance_valid(the_world) and "is_world" in the_world:
		the_world.get_node("UI_CanvasLayer/game_over/InputName/Panel/inputName_ok").connect("pressed", self, "_on_inputNameOK_pressed")
	
	load_high_scores()
	transmit_scores_to_node(highScores)


func _process(delta):
	if not is_instance_valid(the_world) or not "is_world" in the_world:
		return
	# just want to update if there is a new highscore so i can send a push notification
	# mid game
	currentScoreData = calculate_score(currentScoreData, "") # actually does nothing
	if is_new_high_score(currentScoreData) and not hasExec_check_highScore:
		the_world.get_node("UI_Info_display/PushTextOnTopCanvas/push_Text_Notification").push_message("NEW HIGH_SCORE")
		hasExec_check_highScore = true


func game_over_endless():
	the_world.get_node("UI_CanvasLayer/game_over/Control/VBoxContainer/new_high_score").hide()
	# reset the opacity of any of the former highlighted Alert High Scores
	for v in $ScrollContainer/VBoxContainer.get_children():
		v.modulate.a = 0.7
#		v.modulate.b = 1 # nahh i will comment this out. will show all the HS in one sitting
	#set the first one back to pure white
	$ScrollContainer/VBoxContainer.get_child(0).modulate.a = 1

	# Chat GPT Heheh
	load_high_scores() # just collects the data from the Save file
	currentScoreData = calculate_score(currentScoreData, "") # actually does nothing
	transmit_scores_to_node(highScores) # send the info to the display nodes 
  
	if is_new_high_score(currentScoreData):
		the_world.get_node("UI_CanvasLayer/game_over/InputName").show() # this will process the HiScore
#		yes_new_high_score()

##################
##################
func yes_new_high_score():
		update_high_scores(currentScoreData)
		transmit_scores_to_node(highScores) # new high score is updated, transmite it
		alert_new_high_score(currentScoreData)
		save_high_scores()

func _on_inputNameOK_pressed():
	currentScoreData = calculate_score(currentScoreData, the_world.get_node("UI_CanvasLayer/game_over/InputName/Panel/input").text)
	yes_new_high_score()
	the_world.get_node("UI_CanvasLayer/game_over/InputName").hide()
###################
####################

func load_high_scores():
#	highScores = Save.game_data["high_scores"].duplicate(true)
	highScores = Save.game_data["high_scores"]

func calculate_score(currentScoreData, _name) -> Array:
	return [_name, the_world.get_node("Player").touched_floors]

func transmit_scores_to_node(data:Array):
	for i in data.size():
		# the first node in the one for displaying the atttribute type
		$ScrollContainer/VBoxContainer.get_child(i+1).get_node("position").text = str(i+1)
		$ScrollContainer/VBoxContainer.get_child(i+1).get_node("name").text = str(data[i][0])
		$ScrollContainer/VBoxContainer.get_child(i+1).get_node("floor").text = str(data[i][1])

func is_new_high_score(data:Array):
	# Compare the 'scoreData' with the existing high scores in the 'highScores' list
	# Return true if it's higher than any of the scores, otherwise return false
	for score in highScores:
		if score[1] < data[1]:
			return true
	return false

func alert_new_high_score(data):
	the_world.get_node("UI_CanvasLayer/game_over/Control/VBoxContainer/new_high_score").show()
	for v in $ScrollContainer/VBoxContainer.get_children():
		if v.get_node("name").text == str(data[0]):
			if v.get_node("floor").text == str(data[1]):
				v.modulate.a = 1
				v.modulate.b = 0.3
				break # break out!, otherwise might look for another one that is the same

func update_high_scores(data:Array):
	# Insert the 'scoreData' into the 'highScores' list at the appropriate position
	# Remove any extra scores beyond a certain limit (e.g., top 10 scores)
	highScores.append(data)

	# Sort the 'highScores' list in descending order based on the score
	highScores.sort_custom(self, "_compare_scores")

	# Remove any extra scores beyond a certain limit (e.g., top 10 scores)
	while highScores.size() > 5:
		highScores.remove(highScores.size()-1)

func _compare_scores(a, b) -> bool:
	if a[1] > b[1]:
		return true
	else:
		return false

func save_high_scores():
	# Save the updated 'highScores' list to the save data
	Save.game_data["high_scores"] = highScores
	Save.save_data()
