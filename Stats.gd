extends Node

export var health = 5 setget set_health
export var points = 0 setget set_points

signal no_health
signal health_changed(value)
signal add_points(value1)


func set_points(value1):
	points = value1
	emit_signal("add_points",points)

func set_health(value):
	health = clamp(value,0,8)
	emit_signal("health_changed",health)
	if health <= 0:
		emit_signal("no_health")



