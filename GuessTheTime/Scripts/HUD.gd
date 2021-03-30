extends CanvasLayer

var speed = 5
var is_running = false

# Called when the node enters the scene tree for the first time.
func _ready():
	show_mainmenu_layer()
	$GameoverLayer/ColorRect.rect_pivot_offset = $GameoverLayer/ColorRect.rect_size / 2


func reset():
	$GameLayer/ScoreLabel.text = "0"
	$GameLayer/ScoreLabel.rect_rotation = 0
	$GameLayer/ScoreLabel.rect_scale = Vector2(1,1)
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

func increment_time():
	$GameoverLayer/AnimationPlayer.play("correct_answer")
	$GameLayer/ProgressBar.value += 10
	
	if($GameLayer/ProgressBar.value > 100):
		$GameLayer/ProgressBar.value = 100


func decrement_time():
	$GameoverLayer/AnimationPlayer.play("wrong_answer")
	$GameLayer/ProgressBar.value -= 15


func time_finished():
	get_tree().paused = true
	is_running = false
#	$GameLayer/ScoreLabel.text += " GAMEOVER"
#	yield(get_tree().create_timer(3.0), "timeout")
	var score = int($GameLayer/ScoreLabel.text)
	GameController.gameover(score)


func _on_StartButton_pressed():
	show_game_layer()
	GameController.start_game()


func _on_BackButton_pressed():
	show_mainmenu_layer()


func _on_ContinueButton_pressed():
	show_mainmenu_layer()


func show_game_layer():
	$GameLayer.visible = true
	$GameoverLayer.visible = false
	get_tree().paused = false


func show_mainmenu_layer():
	is_running = false
	$GameLayer.visible = false
	$GameoverLayer.visible = false
	GameController.main_menu()


func show_gameover_layer(is_highscore):
	if(is_highscore):
		$GameoverLayer/ColorRect/lblHighscore.visible = true
		$GameoverLayer/AnimationPlayerHighscore.play("highscore")
	else:
		$GameoverLayer/ColorRect/lblHighscore.visible = false
		$GameoverLayer/AnimationPlayerHighscore.stop()
	
	$GameoverLayer/ColorRect.visible = false
	$GameoverLayer/AnimationPlayer.play("pop")
	$GameoverLayer/ColorRect/ScoreLabel.text = "Score:\n" + $GameLayer/ScoreLabel.text
	$GameLayer.visible = false
	$GameoverLayer.visible = true
	get_tree().paused = false

func _on_btnPause():
	get_tree().paused = true
	$GameLayer/AboutPopup.popup()

func _on_btnBack():
	get_tree().paused = false
	$GameLayer/AboutPopup.hide()

func _on_btnMainMenu():
	get_tree().paused = false
	$GameLayer/AboutPopup.hide()
	show_mainmenu_layer()
