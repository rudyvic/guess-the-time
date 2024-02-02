extends Node

signal game_saved
signal game_loaded

var MainMenuScene = preload("res://Nodes/MainMenuScene.tscn")
var GameScene = preload("res://Nodes/GameScene.tscn")
var LearnScene = preload("res://Nodes/LearnGameScene.tscn")

var background_music = preload("res://Sound/build.oggvorbis.ogg")

onready var save_dict = {
		"last_scores" : [],
		"highscore" : 0,
		"language" : "null",
		"is_muted" : "false",
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game()	
	set_is_muted(get_is_muted())
	$AudioStreamPlayer.play()


func start_game():
	Transition.fade_to(GameScene)
	yield(Transition,"transition_finished")

func start_learn():
	Transition.fade_to(LearnScene)
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
	var loaded_data = parse_json(save_game.get_line())
	
	if typeof(loaded_data) == TYPE_DICTIONARY:
		save_dict = loaded_data
	
	save_game.close()
	emit_signal("game_loaded")
	return true

func get_highscore():
	load_game()
	return save_dict["highscore"]

func get_last_scores():
	load_game()
	return save_dict["last_scores"]

func get_language():
	load_game()
	if(!save_dict.has("language") || (save_dict["language"] == "null")):
		save_dict["language"] = TranslationServer.get_locale()
	return save_dict["language"]

func set_language(language):
	TranslationServer.set_locale(language)
	save_dict["language"] = language
	save_game()

func set_is_muted(value):
	save_dict["is_muted"] = value
	save_game()
	AudioServer.set_bus_mute(0,value)

func get_is_muted():
	if(save_dict.has("is_muted")):
		return save_dict["is_muted"]
	else:
		return false
