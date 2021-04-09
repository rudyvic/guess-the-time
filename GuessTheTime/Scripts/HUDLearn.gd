extends CanvasLayer

var is_running = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameoverLayer.rect_pivot_offset = $GameoverLayer.rect_size/2


func reset():
	is_running = false
	$GameLayer/ScoreLabel.text = "0/10"
	get_tree().paused = false


func _process(delta):
	pass


func update_score(score):
	$GameLayer/ScoreLabel.text = str(score) + "/10"
	if(score >= 10):
		game_finished()

func increment_time():
	$GameoverLayer/AnimationPlayer.play("correct_answer")

func wrong_answer():
	$GameoverLayer/AnimationPlayer.play("wrong_answer")

func game_finished():
	is_running = false
	get_tree().paused = true
	show_gameover_layer()


func show_game_layer():
	$GameLayer.visible = true
	$GameoverLayer.hide()
	get_tree().paused = false


func show_gameover_layer():
	$GameoverLayer.show()
	$GameoverLayer/CenterContainer/GridContainer/TitleLabel.text = tr("TUTORIAL_COMPLETED_TITLE")
	$GameoverLayer/CenterContainer/GridContainer/ContinueButton.text = tr("CONTINUE")
	$GameoverLayer/CenterContainer/GridContainer/ScoreLabel.text = tr("TUTORIAL_COMPLETED_OTHER")
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
