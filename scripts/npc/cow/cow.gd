extends CharacterBody2D
class_name Cow

@onready var anim_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var IdleDistance := 20
@export var FleeDistance := 60

@export var IdleMoveSpeed := 10
@export var FleeMoveSpeed := 45

func _physics_process(delta: float):
	if velocity.length() > 0:
		anim_2d.play("walk")
	else:
		anim_2d.play("idle")
	
	if velocity.x > 0:
		anim_2d.flip_h = false
	else:
		anim_2d.flip_h = true
	
	move_and_slide()
