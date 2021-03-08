extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property($Clock,"rotation_degrees",$Clock.rotation_degrees,$Clock.rotation_degrees+100,randi()%4+2,Tween.TRANS_LINEAR)
	$Tween.interpolate_property($Clock,"position",$Clock.position,Vector2($Clock.position.x,$Clock.position.y+100),randi()%4+2,Tween.TRANS_BOUNCE)
	$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
