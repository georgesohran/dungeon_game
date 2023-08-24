extends Control

onready var heartFull = $HeartFull

var hearts = 5 setget set_hearts

func set_hearts(value):
	hearts = clamp(value,0,8)
	if heartFull != null:
		heartFull.rect_size.x = hearts*16
			
func _ready():
	PlayerStats.connect("health_changed",self,"set_hearts")
