extends State
class_name ChickenFlee

@export var chicken : CharacterBody2D
@export var move_speed := 90.0
var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	var direction = chicken.global_position - player.global_position
	
	chicken.velocity = direction.normalized() * move_speed
	
	if direction.length() > 70:
		Transitioned.emit(self, "idle")
