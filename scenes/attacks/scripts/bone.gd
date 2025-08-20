@tool

## Attack bones used by Sans
class_name Bone
extends Control

## Length of the bone. Minimum 12
@export var length : float = 12 : 
	set(value):
		length = value
		update_children()

## Bottom bone to pair with current. Adjust gap with gap
@export var bottom : Bone

## Gap between bottom and top bone if bottom exists. 
## Default 16 is just enough for the height
@export var gap : float = 16.0

## Max height for bones to fill. Use arena height
@export var maxHeight : int = 128

## Velocity of bone 
@export var velocity : float = 3.0

## Minimum size of bone
const MIN_SIZE : Vector2 = Vector2(8, 12)

## Minimum input length
const MIN_LENGTH : int = 14

func _ready():
	update_children()
	
func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	position.x += velocity

func _notification(what):
	if Engine.is_editor_hint():
		if what == NOTIFICATION_RESIZED:
			length = size.y
			size.x = MIN_SIZE.x
			update_children()

## Updates the position of bone and bottom bone in editor
func update_children():
	if length < MIN_LENGTH:
		length = MIN_LENGTH
	
	var texture = get_node_or_null("texture")
	if texture:
		texture.size.y = length
		
	var collision = get_node_or_null("collision/shape")
	if collision:
		collision.shape = collision.shape.duplicate()
		collision.shape.size.y = length - (MIN_SIZE.y / 2)
		collision.position.y = length / 2
		
	if bottom:
		bottom.global_position = position
		bottom.position.y += length + gap
		bottom.length = maxHeight - (gap + length)
