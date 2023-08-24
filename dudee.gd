extends KinematicBody2D

export var maxspeed = 60

var veloc = Vector2.ZERO

onready var AnimatPlayer = $AnimationPlayer
onready var AnimTree = $AnimationTree
onready var Swordhitbox = $Position2D/swordHitbox
onready var stats = PlayerStats

enum {MOVE, ATTACK }

var state = MOVE

onready var animstate = AnimTree.get("parameters/playback")


func _ready():
	stats.connect("no_health",self,"death")
	AnimTree.active = true

func _process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		Swordhitbox.knokback_vector = input_vector
		AnimTree.set("parameters/idle/blend_position", input_vector)
		AnimTree.set("parameters/Attack/blend_position", input_vector)
		AnimTree.set("parameters/run/blend_position", input_vector)
		animstate.travel("run")
		veloc = input_vector * maxspeed
	else:
		animstate.travel("idle")
		veloc = Vector2.ZERO
	veloc = move_and_slide(veloc)
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
func attack_state(delta):
	animstate.travel("Attack")
func attack_finish():
	state = MOVE

func death():
	queue_free()
	get_tree().change_scene("res://death screen.tscn")

func _on_hurtbox_area_entered(area):
	stats.health -= 1
