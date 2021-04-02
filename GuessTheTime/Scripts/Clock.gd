extends Node2D

var long = null
var short = null

# Called when the node enters the scene tree for the first time.
func _ready():
	long = $base/long
	short = $base/short

func new_random_time():
	$ClockTime.set_random_time_excluding_previous()
	
	$Tween.interpolate_property(short,"rotation_degrees",short.rotation_degrees,(($ClockTime.hour * 360.0) / 12.0) - 90,0.3,Tween.TRANS_SINE)
	$Tween.interpolate_property(long,"rotation_degrees",long.rotation_degrees,(($ClockTime.minute * 360.0) / 60.0),0.3,Tween.TRANS_SINE)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	
	short.rotation_degrees = (($ClockTime.hour * 360.0) / 12.0) - 90
	long.rotation_degrees = (($ClockTime.minute * 360.0) / 60.0) 

func rotate_minutes(speed):
	$AnimationPlayer.play("rotate_minutes",-1,speed)

func rotate_hours(speed):
	$AnimationPlayer.play("rotate_hours",-1,speed)
