extends CharacterBody2D
class_name Chicken

@onready var anim_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float):
	move_and_slide()
	
	if velocity.length() > 0:
		anim_2d.play("walk")
	else:
		anim_2d.play("idle")
	
	if velocity.x > 0:
		anim_2d.flip_h = false
	else:
		anim_2d.flip_h = true
