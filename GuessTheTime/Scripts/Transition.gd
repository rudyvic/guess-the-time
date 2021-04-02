extends Control

signal transition_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fade(start,end):
	$AnimationPlayer.play("fade_out")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene_to(end)
	$AnimationPlayer.play("fade_in")
	yield($AnimationPlayer,"animation_finished")
	emit_signal("transition_finished")


func reset():
	$AnimationPlayer.stop()
	$ColorRect.modulate.a = 0
