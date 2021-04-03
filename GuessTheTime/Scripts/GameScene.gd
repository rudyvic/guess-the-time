extends Node2D

var ClockTime = preload("res://Nodes/ClockTime.tscn")
onready var HUD = get_node("HUD")
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	HUD.show_game_layer()
	new_random_time()
	HUD.start_game()

func new_random_time():
	$Clock.new_random_time()
	var excluding_times = []
	excluding_times.append($Clock/ClockTime._to_string())
	$Button1.new_random_time(excluding_times)
	excluding_times.append($Button1.get_clock_time())
	$Button2.new_random_time(excluding_times)
	excluding_times.append($Button2.get_clock_time())
	$Button3.new_random_time(excluding_times)
	excluding_times.append($Button3.get_clock_time())
	$Button4.new_random_time(excluding_times)
	
	match(randi() % 4):
		0:
			$Button1.set_clock_equal_to($Clock/ClockTime)
		1:
			$Button2.set_clock_equal_to($Clock/ClockTime)
		2:
			$Button3.set_clock_equal_to($Clock/ClockTime)
		3:
			$Button4.set_clock_equal_to($Clock/ClockTime)
	
	HUD.update_score(score)


func _on_Button1_pressed():
	if(!HUD.is_running):
		return
	
	if($Clock/ClockTime.to_string() == $Button1/ClockTime.to_string()):
		score += 1
		HUD.increment_time()
		$Button1.correct_answer()
	else:
		HUD.decrement_time()
		$Button1.wrong_answer()
	new_random_time()


func _on_Button2_pressed():
	if(!HUD.is_running):
		return
	
	if($Clock/ClockTime.to_string() == $Button2/ClockTime.to_string()):
		score += 1
		HUD.increment_time()
		$Button2.correct_answer()
	else:
		HUD.decrement_time()
		$Button2.wrong_answer()
	new_random_time()


func _on_Button3_pressed():
	if(!HUD.is_running):
		return
	
	if($Clock/ClockTime.to_string() == $Button3/ClockTime.to_string()):
		score += 1
		HUD.increment_time()
		$Button3.correct_answer()
	else:
		HUD.decrement_time()
		$Button3.wrong_answer()
	new_random_time()


func _on_Button4_pressed():
	if(!HUD.is_running):
		return
	
	if($Clock/ClockTime.to_string() == $Button4/ClockTime.to_string()):
		score += 1
		HUD.increment_time()
		$Button4.correct_answer()
	else:
		HUD.decrement_time()
		$Button4.wrong_answer()
	new_random_time()

