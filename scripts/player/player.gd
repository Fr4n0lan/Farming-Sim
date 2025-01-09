extends CharacterBody2D
class_name Player

const SPEED = 75.0
const ACCEL = 7.5

@onready var anim_sprite2d = $AnimatedSprite2D

var input: Vector2

func get_input():
	input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return input.normalized()

func _process(delta: float) -> void:
	var playerInput = get_input()
	
	velocity = lerp(velocity, playerInput * SPEED, delta * ACCEL)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("move_left"):
		anim_sprite2d.play("walk_left")
	elif Input.is_action_pressed("move_right"):
		anim_sprite2d.play("walk_right")
	elif Input.is_action_pressed("move_down"):
		anim_sprite2d.play("walk_down")
	elif Input.is_action_pressed("move_up"):
		anim_sprite2d.play("walk_up")
	
	if Input.is_action_just_released("move_left"):
		anim_sprite2d.play("idle_left")
	elif Input.is_action_just_released("move_right"):
		anim_sprite2d.play("idle_right")
	elif Input.is_action_just_released("move_down"):
		anim_sprite2d.play("idle_down")
	elif Input.is_action_just_released("move_up"):
		anim_sprite2d.play("idle_up")
