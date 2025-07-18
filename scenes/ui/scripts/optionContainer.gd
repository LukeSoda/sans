extends Node2D

### optionContainer ###
# All children of this class inherit from the abstract UtOption. This class handles switching from option to 
#  when multiple options are presented to the player
class_name optionContainer

@export var player: CharacterBody2D # player node. Allows for the players position to be manipulated by child buttons
@export var inFocus: UtOption # Option that is in focus on ready
@export var containerID: String # id differentiating container from others 

var current = false # Tell each container if it is the one inputs should be applied to

func _physics_process(delta: float) -> void:
	if current: # Ensures that an inFocus exists
		# Scans directional inputs and makes sure that corresponding options exist. If checks pass, switch to corresponding option
		if Input.is_action_just_pressed("myLeft") and inFocus.getLeftNeighbor():
			grabButtonFocus(inFocus.getLeftNeighbor())
		elif Input.is_action_just_pressed("myRight") and inFocus.getRightNeighbor():
			grabButtonFocus(inFocus.getRightNeighbor())
		elif Input.is_action_just_pressed("myUp") and inFocus.getTopNeighbor():
			grabButtonFocus(inFocus.getTopNeighbor())
		elif Input.is_action_just_pressed("myDown" ) and inFocus.getBottomNeighbor():
			grabButtonFocus(inFocus.getBottomNeighbor())

### grabFocus() ###
# Shifts the focus from the current in focus to its passed in neighbor'
# option: UtOption The option to switch to
func grabButtonFocus(option: UtOption):
	if inFocus:
		inFocus.loseFocus()
	inFocus = option # Set inFocus to the passed in option to swap to
	inFocus.grabFocus(player) # Call grabFocus of passed in option. This exists in a different script. NOT RECURSIVE

### grabContainerFocus ###
# Signal method which which is receiving from optionHandler. Signal emitted when the current container is changed (Ex. submenus).
#  A unique ID is passed in which is compared to the container ID. Only the container with the corresponding ID will be set set in 
#  in foucs. The rest lose their currency status in case they were active.
# ID: String Unique ID passed in to check against container ID
func grabContainerFocus(ID: String):
	if (ID == containerID):
		current = true
		grabButtonFocus(inFocus)
	else:
		current = false
