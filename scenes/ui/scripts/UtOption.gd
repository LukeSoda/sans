extends Area2D

### UtOption ###
# Absract button class. UtButtonOption and UtTextOption both inherit this
class_name UtOption

@onready var selectRegion = $selectRegion # Collision shape that allows for selection detection

@export var playerOffset: int # Soul shifted left x number of pixels for alignment
# Communicate which options correspond to directions
@export var leftNeighbor: UtOption
@export var rightNeighbor: UtOption
@export var topNeighbor: UtOption
@export var bottomNeighbor: UtOption

@export var optionID: String

var player: CharacterBody2D # Player position manipulated for aligment

signal choose(optionID: String) # Emitted when current option is accepted

func _ready():
	selectRegion.position.x -= playerOffset # Move accept region so that is will be where the soul is on hover

func _physics_process(delta: float) -> void:
	# If the player has this node selected and accepts emit choose signal
	if player and Input.is_action_just_pressed("ui_accept"):
		emit_signal("choose", optionID)

func getLeftNeighbor() -> UtOption:
	return leftNeighbor

func getRightNeighbor() -> UtOption:
	return rightNeighbor

func getTopNeighbor() -> UtOption:
	return topNeighbor
	
func getBottomNeighbor() -> UtOption:
	return bottomNeighbor

### grabFocus() ###
# Sets player to correct position when focus shifted to this option
func grabFocus(player: CharacterBody2D) -> void:
	player.position = Vector2(global_position.x - playerOffset, global_position.y)

### loseFocus() ###
# Unfocus the current node
# Abastract type does not implement this
func loseFocus():
	pass

func _on_body_entered(body: Node2D) -> void:
	player = body

func _on_body_exited(body: Node2D) -> void:
	player = null
