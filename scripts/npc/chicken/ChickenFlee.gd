extends State
class_name ChickenFlee

@export var chicken : CharacterBody2D

var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	var direction = chicken.global_position - player.global_position
	
	chicken.velocity = direction.normalized() * chicken.FleeMoveSpeed
	
	if direction.length() > chicken.FleeDistance:
		Transitioned.emit(self, "idle")
