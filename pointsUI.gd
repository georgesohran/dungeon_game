extends Control

onready var label = $Label

export var points = 0 setget set_points1

func set_points1(value1):
	points = value1
	if label != null:
		label.text = "Killed Enemies:" + str(points)

func _ready():
	ZombieStats.connect("add_points",self,"set_points1")
