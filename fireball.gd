extends KinematicBody2D

var direction = Vector2.LEFT
var speed = 80 

func _process(delta):
	translate(direction*speed*delta)

func _on_hurtbox_body_entered(body):
	queue_free()
