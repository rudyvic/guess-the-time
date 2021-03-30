extends Node

var MainMenuScene = preload("res://Nodes/MainMenuScene.tscn")
var GameScene = preload("res://Nodes/GameScene.tscn")

var save_dict = {
		"last_scores" : [],
		"highscore" : 0,
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func start_game():
	HUD.show_game_layer()
	HUD.reset()
	get_tree().change_scene_to(GameScene)

func gameover(score):
	var is_highscore = false
	
	save_dict["last_scores"].push_front(score)
	if(save_dict["last_scores"].size() > 5):
		save_dict["last_scores"].pop_back()
	
	if(save_dict["highscore"] < score):
		save_dict["highscore"] = score
		is_highscore = true
	
	save_game()
	HUD.show_gameover_layer(is_highscore)

func main_menu():
	load_game()
	get_tree().change_scene_to(MainMenuScene)

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	
	# Store the save dictionary as a new line in the save file
	save_game.store_line(to_json(save_dict))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return false# Error! We don't have a save to load.
	
	save_game.open("user://savegame.save", File.READ)
	save_dict = parse_json(save_game.get_line())
	
	save_game.close()
	return true

func get_highscore():
	load_game()
	return save_dict["highscore"]

func get_last_scores():
	load_game()
	return save_dict["last_scores"]
