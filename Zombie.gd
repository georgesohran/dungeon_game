extends KinematicBody2D

const EnDeatheffect = preload("res://DeathEffect.tscn")

export var friction = 700
export var max_speed = 30

enum{IDLE,WANDER,CHASE,ATTACK}

onready var playerDetection = $Detact_player
onready var AnimatEnemy = $AnimationEnemy1
onready var AnimTree1 = $AnimationTree
onready var animstate = AnimTree1.get("parameters/playback")
onready var stats = $ZombieStats
onready var Attack_detaction = $Attack_area
onready var animstateEnemy = AnimTree1.get("parameters/playback")


var veloc = Vector2.ZERO
var knokback = Vector2.ZERO
var state = IDLE

func _ready():
	AnimTree1.active = true

func _process(delta):
	knokback = knokback.move_toward(Vector2.ZERO, friction*delta)
	knokback = move_and_slide(knokback)
	match state:
		IDLE:
			veloc = veloc.move_toward(Vector2.ZERO,friction*delta)
			if playerDetection.can_see_player():
				state = CHASE
			if Attack_detaction.can_attack_player():
				state = ATTACK
		CHASE:
			var player = playerDetection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				AnimTree1.set("parameters/Idle/blend_position", direction)
				AnimTree1.set("parameters/attack/blend_position", direction)
				AnimTree1.set("parameters/walk/blend_position", direction)
				animstateEnemy.travel("walk")
				veloc = direction*max_speed
				veloc = move_and_slide(veloc)
				if Attack_detaction.can_attack_player() :
					state = ATTACK
			else:
				state = IDLE
				animstateEnemy.travel("idle")
		ATTACK:
			animstateEnemy.travel("attack")


func seek_player():
	if playerDetection.can_see_player():
		state = CHASE
func if_attack_player():
	if Attack_detaction.can_attack_player():
		state = ATTACK

func attack_finnisheddd():
	state = IDLE

func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	knokback = area.knokback_vector * 90


func _on_ZombieStats_no_health():
	ZombieStats.points += 1
	queue_free()
	var enDeathEffect = EnDeatheffect.instance()
	var main = get_tree().current_scene
	main.add_child(enDeathEffect)
	enDeathEffect.global_position = global_position
	
