extends Node2D

signal pressed

var clockTime = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func new_random_time():
	$ClockTime.set_random_time()
	$Button/Label.text = str($ClockTime)

func set_clock_equal_to(other_clock_time):
	$ClockTime.set_equal_to(other_clock_time)
	$Button/Label.text = str($ClockTime)

func _on_Button_pressed():
	emit_signal("pressed")

func correct_answer():
	$AnimationPlayer.play("correct_answer")

func wrong_answer():
	$AnimationPlayer.play("wrong_answer")
