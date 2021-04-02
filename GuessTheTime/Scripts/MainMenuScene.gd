extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property($Clock,"rotation_degrees",$Clock.rotation_degrees,$Clock.rotation_degrees+100,randi()%4+2,Tween.TRANS_LINEAR)
	$Tween.interpolate_property($Clock,"position",$Clock.position,Vector2($Clock.position.x,$Clock.position.y+100),randi()%4+2,Tween.TRANS_BOUNCE)
	$Tween.start()
	$Clock.rotate_minutes(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_btnStart():
	GameController.start_game()

func _on_btnLearn():
	pass

func _on_btnStats():
	$MainMenuLayer/StatsPopup.popup()
	$MainMenuLayer/StatsPopup/CenterContainer/GridContainer/lblHighscore.text = "Highscore: " + str(GameController.get_highscore())
	$MainMenuLayer/StatsPopup/CenterContainer/GridContainer/lblLastScores.text = "Last scores:\n" + str(GameController.get_last_scores())
	
func _on_btnAbout():
	$MainMenuLayer/AboutPopup.popup()
	

func _on_btnAboutBack():
	$MainMenuLayer/AboutPopup.hide()

func _on_btnStatsBack():
	$MainMenuLayer/StatsPopup.hide()

func _on_btnItchio():
	OS.shell_open("https://rudyvic.itch.io/")

func _on_btnWebsite():
	OS.shell_open("https://rudyvicario.altervista.org/")

func _on_btnTwitter():
	OS.shell_open("https://twitter.com/rudyvic95")
