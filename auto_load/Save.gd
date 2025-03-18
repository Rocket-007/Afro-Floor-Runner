extends Node

const SAVEFILE = "user://SAVEFILE1.txt"
#const SAVEFILE = "res://SAVEFILE.txt"

var game_data = {}

func _ready():
	load_data()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVEFILE):
		game_data = {
			"debug": false,
			
			"music_vol": 0.0,
			"sfx_vol": 0.0,
			
			"landscape": true,
			"show_shoe_trail": true,
			"show_color_control": true,
			
			"high_scores":[["",0], ["",0], ["",0], ["",0],  ["",0],],
		}
		save_data()
	file.open(SAVEFILE, File.READ)
	game_data = file.get_var()
#	print(game_data)
	file.close()
	
func save_data():
	var file = File.new()
	file.open(SAVEFILE, File.WRITE)
	file.store_var(game_data)
#	print(game_data)
	file.close()
		
