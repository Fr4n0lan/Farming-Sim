extends State
class_name CowFlee

@export var cow : CharacterBody2D

var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	var direction = cow.global_position - player.global_position
	
	cow.velocity = direction.normalized() * cow.FleeMoveSpeed
	
	if direction.length() > cow.FleeDistance:
		Transitioned.emit(self, "idle")
