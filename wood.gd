extends Node2D

const effect = preload("res://woodeffect.tscn")

func _on_hurtbox_area_entered(area):
	var effecti = effect.instance()
	var main = get_tree().current_scene
	main.add_child(effecti)
	effecti.global_position = global_position
	queue_free()
