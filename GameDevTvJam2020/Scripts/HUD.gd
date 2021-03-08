extends CanvasLayer

var speed = 20
var is_running = true

# Called when the node enters the scene tree for the first time.
func _ready():
	show_mainmenu_layer()
	$GameoverLayer/ColorRect.rect_pivot_offset = $GameoverLayer/ColorRect.rect_size / 2


func reset():
	$GameLayer/ScoreLabel.text = "0"
	update_score(0)
	$GameLayer/ProgressBar.value = 100
	is_running = true
	get_tree().paused = false


func _process(delta):
	if(!is_running):
		return
	
	$GameLayer/ProgressBar.value -= speed * delta
	if($GameLayer/ProgressBar.value == 0):
		time_finished()


func update_score(score):
	$GameLayer/ScoreLabel.text = str(score)


func time_finished():
	get_tree().paused = true
	is_running = false
#	$GameLayer/ScoreLabel.text += " GAMEOVER"
#	yield(get_tree().create_timer(3.0), "timeout")
	GameController.gameover()


func _on_StartButton_pressed():
	show_game_layer()
	GameController.start_game()


func _on_AboutButton_pressed():
	show_about_layer()


func _on_BackButton_pressed():
	show_mainmenu_layer()


func _on_ContinueButton_pressed():
	show_mainmenu_layer()
	GameController.main_menu()


func show_game_layer():
	$MainMenuLayer.visible = false
	$GameLayer.visible = true
	$AboutLayer.visible = false
	$GameoverLayer.visible = false
	get_tree().paused = false


func show_mainmenu_layer():
	$MainMenuLayer.visible = true
	$GameLayer.visible = false
	$AboutLayer.visible = false
	$GameoverLayer.visible = false
	get_tree().paused = false


func show_gameover_layer():
	$GameoverLayer/ColorRect.visible = false
	$GameoverLayer/AnimationPlayer.play("pop")
	$GameoverLayer/ColorRect/ScoreLabel.text = "Score:\n" + $GameLayer/ScoreLabel.text
	$MainMenuLayer.visible = false
	$GameLayer.visible = false
	$AboutLayer.visible = false
	$GameoverLayer.visible = true
	get_tree().paused = false


func show_about_layer():
	$MainMenuLayer.visible = false
	$GameLayer.visible = false
	$AboutLayer.visible = true
	$GameoverLayer.visible = false
	get_tree().paused = false


