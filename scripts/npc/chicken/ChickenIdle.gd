extends State
class_name ChickenIdle

@export var chicken: CharacterBody2D

var player : CharacterBody2D

var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)
	
func Enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
		
	else:
		randomize_wander()

func Physics_Update(delta: float):
	if chicken:
		chicken.velocity = move_direction * chicken.IdleMoveSpeed
	
	var direction = chicken.global_position - player.global_position
	
	if direction.length() < chicken.IdleDistance:
		Transitioned.emit(self, "flee")
