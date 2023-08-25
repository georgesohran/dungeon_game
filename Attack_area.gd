extends Area2D
#eeee
var playerAttack = null

func can_attack_player():
	return playerAttack != null
	
func _on_Attack_area_body_entered(body):
	playerAttack = body

func _on_Attack_area_body_exited(body):
	playerAttack = null
