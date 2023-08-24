extends Area2D

var Stats = PlayerStats



func _on_heal_potion_area_entered(area):
	Stats.health +=1
	queue_free()
