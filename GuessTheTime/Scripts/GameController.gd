extends Node

signal game_saved
signal game_loaded

var MainMenuScene = preload("res://Nodes/MainMenuScene.tscn")
var GameScene = preload("res://Nodes/GameScene.tscn")

var save_dict = {
		"last_scores" : [],
		"highscore" : 0,
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game()


func start_game():
	Transition.fade_to(GameScene)
	yield(Transition,"transition_finished")

func gameover(score):
	var is_highscore = false
	
	save_dict["last_scores"].push_front(score)
	if(save_dict["last_scores"].size() > 5):
		save_dict["last_scores"].pop_back()
	
	if(save_dict["highscore"] < score):
		save_dict["highscore"] = score
		is_highscore = true
	
	save_game()
	return is_highscore

func main_menu(do_transition = true):
	load_game()
	if(do_transition):
		Transition.fade_to(MainMenuScene)
		yield(Transition,"transition_finished")
	else:
		get_tree().change_scene_to(MainMenuScene)

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	
	# Store the save dictionary as a new line in the save file
	save_game.store_line(to_json(save_dict))
	save_game.close()
	emit_signal("game_saved")

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return false# Error! We don't have a save to load.
	
	save_game.open("user://savegame.save", File.READ)
	save_dict = parse_json(save_game.get_line())
	
	save_game.close()
	emit_signal("game_loaded")
	return true

func get_highscore():
	load_game()
	return save_dict["highscore"]

func get_last_scores():
	load_game()
	return save_dict["last_scores"]
	
