extends CanvasLayer

var speed = 5
var is_running = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameoverLayer.rect_pivot_offset = $GameoverLayer.rect_size/2


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
	var score = int($GameLayer/ScoreLabel.text)
	var is_highscore = GameController.gameover(score)
	show_gameover_layer(is_highscore)


func show_game_layer():
	$GameLayer.visible = true
	$GameoverLayer.hide()
	get_tree().paused = false


func show_gameover_layer(is_highscore):
	if(is_highscore):
		$GameoverLayer/CenterContainer/GridContainer/lblHighscore.text = tr("NEW_HIGHSCORE")
		$GameoverLayer/AnimationPlayerHighscore.play("highscore")
	else:
		$GameoverLayer/CenterContainer/GridContainer/lblHighscore.text = tr("HIGHSCORE_TO_BEAT") + ": " + str(GameController.get_highscore())
		$GameoverLayer/AnimationPlayerHighscore.stop()
	
	$GameoverLayer.show()
	$GameoverLayer/CenterContainer/GridContainer/ContinueButton.text = tr("CONTINUE")
	$GameoverLayer/CenterContainer/GridContainer/ScoreLabel.text = tr("SCORE") + ":\n" + $GameLayer/ScoreLabel.text
	$GameoverLayer/AnimationPlayer.play("pop")
	$GameLayer.visible = false
	get_tree().paused = false

func _on_btnPause():
	get_tree().paused = true
	$GameLayer/PausePopup.popup()
	$GameLayer/PausePopup/CenterContainer/GridContainer/btnBack.text = tr("BACK")
	$GameLayer/PausePopup/CenterContainer/GridContainer/btnMainMenu.text = tr("MAIN_MENU")
	$GameLayer/PausePopup/CenterContainer/GridContainer/lblPause.text = tr("PAUSE")

func _on_btnBack():
	get_tree().paused = false
	$GameLayer/PausePopup.hide()

func _on_btnMainMenu():
	get_tree().paused = false
	$GameLayer/PausePopup.hide()
	GameController.main_menu()

func _on_ContinueButton():
	get_tree().paused = false
	GameController.main_menu()


func start_game():
	is_running = true
