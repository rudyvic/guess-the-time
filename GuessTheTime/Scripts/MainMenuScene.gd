extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property($Clock,"rotation_degrees",$Clock.rotation_degrees,$Clock.rotation_degrees+100,randi()%4+2,Tween.TRANS_LINEAR)
	$Tween.interpolate_property($Clock,"position",$Clock.position,Vector2($Clock.position.x,$Clock.position.y+100),randi()%4+2,Tween.TRANS_BOUNCE)
	$Tween.start()
	$Clock.rotate_minutes(1)
	TranslationServer.set_locale(GameController.get_language())
	refresh_texts()
	
	$lblVersion.text = "v" + ProjectSettings.get("application/config/version")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func refresh_texts():
	$MainMenuLayer/CenterContainer/GridContainer/btnLearn.text = tr("MAIN_MENU_LEARN")
	$MainMenuLayer/CenterContainer/GridContainer/btnStart.text = tr("MAIN_MENU_PLAY")
	$MainMenuLayer/CenterContainer/GridContainer/btnStats.text = tr("MAIN_MENU_STATS")
	
	# language icon
	if("en" in GameController.get_language()):
		$MainMenuLayer/CenterContainer/GridContainer/HBoxContainer/btnLanguage.icon.set_region(Rect2(Vector2(32,0),Vector2(32,32)))
	else:
		$MainMenuLayer/CenterContainer/GridContainer/HBoxContainer/btnLanguage.icon.set_region(Rect2(Vector2(0,0),Vector2(32,32)))
	
	# volume icon
	var btn = $MainMenuLayer/CenterContainer/GridContainer/HBoxContainer/btnVolume
	if(GameController.get_is_muted()):
		btn.pressed = true
		btn.icon.set_region(Rect2(Vector2(128,0),Vector2(32,32)))
	else:
		btn.pressed = false
		btn.icon.set_region(Rect2(Vector2(96,0),Vector2(32,32)))

func _on_btnStart():
	GameController.start_game()

func _on_btnLearn():
	GameController.start_learn()

func _on_btnStats():
	$MainMenuLayer/StatsPopup.popup()
	$MainMenuLayer/StatsPopup/CenterContainer/GridContainer/lblHighscore.text = tr("HIGHSCORE") + ": " + str(GameController.get_highscore())
	$MainMenuLayer/StatsPopup/CenterContainer/GridContainer/lblLastScores.text = tr("LAST_SCORES") + ":\n" + str(GameController.get_last_scores())
	$MainMenuLayer/StatsPopup/CenterContainer/GridContainer/btnBack.text = tr("BACK")

func _on_btnAbout():
	$MainMenuLayer/AboutPopup.popup()
	$MainMenuLayer/AboutPopup/CenterContainer/GridContainer/lblFollowMe.text = tr("ABOUT_FOLLOW_ME") + ":"
	$MainMenuLayer/AboutPopup/CenterContainer/GridContainer/btnBack.text = tr("BACK")

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

func _on_btnLanguage():
	if("en" in GameController.get_language()):
		GameController.set_language("it")
	else:
		GameController.set_language("en")
	refresh_texts()


func _on_btnVolume():
	var btn = $MainMenuLayer/CenterContainer/GridContainer/HBoxContainer/btnVolume
	if(btn.pressed):
		GameController.set_is_muted(true)
	else:
		GameController.set_is_muted(false)
	refresh_texts()
