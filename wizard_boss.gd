extends KinematicBody2D

const EnDeatheffect = preload("res://DeathEffect.tscn")
const fireball = preload("res://fireball.tscn")
const toxicball = preload("res://toxicball.tscn")

var attackCount = 0

export var friction = 700
export var max_speed = 10

enum{IDLE,WALK,SPELL_C,SPELL_F,REST}

onready var playerDetection1 = $Detact_player
onready var AnimatEnemy = $AnimationWiz
onready var AnimTree1 = $AnimationTree1
onready var stats = $Stats
onready var CloseSpell_detaction1 = $Attack_area1
onready var FarSpell_detaction2 = $Attack_area2
onready var animstateEnemy = AnimTree1.get("parameters/playback")


var veloc = Vector2.ZERO
var knokback = Vector2.ZERO
var state = IDLE

func _ready():
	AnimTree1.active = true
#	timerAttack.start(0)

func _process(delta):
	knokback = knokback.move_toward(Vector2.ZERO, friction*delta)
	knokback = move_and_slide(knokback)
	match state:
		IDLE:
			veloc = veloc.move_toward(Vector2.ZERO,friction*delta)
			if playerDetection1.can_see_player():
				state = WALK
			if FarSpell_detaction2.can_attack_player():
				state = SPELL_F
			if CloseSpell_detaction1.can_attack_player():
				state = SPELL_C
			if attackCount>5:
				state = REST
		WALK:
			var player = playerDetection1.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				animstateEnemy.travel("walk")
				veloc = direction*max_speed
				veloc = move_and_slide(veloc)
				if FarSpell_detaction2.can_attack_player():
					state = SPELL_F
				if CloseSpell_detaction1.can_attack_player():
					state = SPELL_C
			else:
				state = IDLE
				animstateEnemy.travel("Idle")
		SPELL_F:
			animstateEnemy.travel("spell_f")
		SPELL_C:
			animstateEnemy.travel("spell_c")
		REST:
			animstateEnemy.travel("rest")


func cast_spell_c():
	var player = playerDetection1.player
	if attackCount<=5 :
		attackCount+=1
		var Toxicball = toxicball.instance()
		var main = get_tree().current_scene
		main.add_child(Toxicball)
		Toxicball.global_position = global_position
		 
func cast_spell_f():
	var player = playerDetection1.player
	if FarSpell_detaction2.can_attack_player() and attackCount<=5:
		attackCount+=1
		var FireBall = fireball.instance()
		var main = get_tree().current_scene
		main.add_child(FireBall)
		FireBall.global_position = global_position
		var direction = (player.global_position - global_position).normalized()
		FireBall.global_rotation = direction.angle()+PI/2.0
		FireBall.direction = direction

func attack_finnisheddd():
	state = IDLE


func _on_hurtbox_area_entered(area):
	stats.health-=area.damage
	knokback = area.knokback_vector * 90
func _on_Stats_no_health():
	queue_free()

func rest_reset():
	state = IDLE
	attackCount = 0

