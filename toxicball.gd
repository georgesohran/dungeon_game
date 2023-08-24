extends KinematicBody2D

onready var Anim = $AnimationPlayer1

func _ready():
	Anim.play("rotation")


func _on_AnimationPlayer1_animation_finished(anim_name):
	queue_free()
