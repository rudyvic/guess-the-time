extends Node


var MainMenuScene = preload("res://Nodes/MainMenuScene.tscn")
var GameScene = preload("res://Nodes/GameScene.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func start_game():
	HUD.show_game_layer()
	HUD.reset()
	get_tree().change_scene_to(GameScene)

func gameover():
	HUD.show_gameover_layer()

func main_menu():
	get_tree().change_scene_to(MainMenuScene)
