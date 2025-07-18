extends CharacterBody2D

enum {MENU, BATTLE}

const MAX_SPEED = 200 
const ACCELERATION = 10000

var dir = Vector2.ZERO # Represents direction the is moving as a unit vector
var state = MENU # State machine determining if battle movement or menu movement can be used

func _physics_process(delta: float) -> void:
	match state:
		MENU:
			menuMove(delta)
		BATTLE:
			battleMove(delta)
	move_and_slide()

func menuMove(delta: float):
	dir = Input.get_vector("myLeft", "myRight", "myUp", "myDown")

func battleMove(delta: float):
	dir = Input.get_vector("myLeft", "myRight", "myUp", "myDown") # Gets vector based on inputs
	velocity = velocity.move_toward(dir * MAX_SPEED, ACCELERATION * delta) # Update velocity
