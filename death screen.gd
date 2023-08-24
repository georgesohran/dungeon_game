extends Control

onready var label = $PanelContainer/VBoxContainer/label/Label2



func _ready():
	var points = PointsUi.points
	if label != null:
		label.text = "points:" + str(points)

func _on_restart_pressed():
	get_tree().change_scene("res://level1.tscn")


func _on_quit_pressed():
	get_tree().quit()
