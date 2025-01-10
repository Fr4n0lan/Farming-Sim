extends CharacterBody2D
class_name Player

const SPEED = 75.0
const ACCEL = 15

@onready var anim2d = $AnimatedSprite2D

var last_input: String
var input: Vector2

const DIR := {
	Left = Vector2.LEFT,
	Right = Vector2.RIGHT,
	Up = Vector2.UP,
	Down = Vector2.DOWN,
	
	UpLeft = Vector2.UP + Vector2.LEFT,
	UpRight = Vector2.UP + Vector2.RIGHT,
	DownLeft = Vector2.DOWN + Vector2.LEFT,
	DownRight = Vector2.DOWN + Vector2.RIGHT,
}

const Controller := {
	Keyboard = "Keyboard",
}

var controller: String = Controller.Keyboard

func get_input():
	input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return input.normalized()

func get_dir_name(dir: Vector2) -> String:
	var dir_name: String = ""
	var index: int = DIR.values().find(dir)
	
	dir_name = DIR.keys()[index]
	
	return dir_name

func get_closest_dir(dir: Vector2) -> Vector2:
	var closest_distance: float = 9999.99
	var closest_dir := Vector2.ZERO
	
	var other_directions := DIR.values()
	for other_dir in other_directions:
		var distance = dir.distance_to(other_dir)
		if distance < closest_distance:
			closest_distance = distance
			closest_dir = other_dir
	return closest_dir
		

func play_dir_anim(dir: Vector2) -> void:
	var closest_dir := get_closest_dir(dir)
	var anim_name := ""
	
	match closest_dir:
		DIR.Left: 		anim_name = "move_left"
		DIR.Right: 		anim_name = "move_right"
		DIR.Up: 		anim_name = "move_up"
		DIR.Down: 		anim_name = "move_down"
		DIR.UpLeft: 	anim_name = "move_up"
		DIR.UpRight: 	anim_name = "move_up"
		DIR.DownLeft: 	anim_name = "move_down"
		DIR.DownRight:	anim_name = "move_down"

	if anim2d.animation != anim_name:
		anim2d.play(anim_name)
		last_input = anim_name

func play_idle_anim(input: String):
	if input == "move_left":
		anim2d.play("idle_left")
	elif input == "move_right":
		anim2d.play("idle_right")
	elif input == "move_up":
		anim2d.play("idle_up")
	elif input == "move_down":
		anim2d.play("idle_down")

func _physics_process(delta: float) -> void:
	var playerInput = get_input()
	var dir := Vector2.ZERO
	
	dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	dir.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if dir != Vector2.ZERO:
		play_dir_anim(dir)
	else:
		play_idle_anim(last_input)
			
	velocity = lerp(velocity, playerInput * SPEED, delta * ACCEL)

	move_and_slide()
