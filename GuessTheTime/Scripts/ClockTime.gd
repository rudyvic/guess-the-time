extends Node

var Hours = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
var Minutes = [0, 15, 30, 45]

var hour = 0
var minute = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


func is_equal_to(other):
	if(hour==other.hour && minute==other.minute):
		return true
	return false


func set_equal_to(other):
	hour = other.hour
	minute = other.minute


func set_random_time():
	hour = Hours[rand_range(0, Hours.size())]
	minute = Minutes[rand_range(0, Minutes.size())]


func set_random_time_excluding(time):
	hour = Hours[rand_range(0, Hours.size())]
	minute = Minutes[rand_range(0, Minutes.size())]
	
	if(is_equal_to(time)):
		set_random_time_excluding(time)


func _to_string():
	return str(hour) + ":" + str(minute)

