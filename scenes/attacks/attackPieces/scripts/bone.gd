@tool
extends Control

func _ready():
	update_children()

func _notification(what):
	if Engine.is_editor_hint():
		if what == NOTIFICATION_RESIZED:
			update_children()

func update_children():
	var texture = get_node_or_null("texture")
	texture.size = size
	var collision = get_node_or_null("collision/shape")
	collision.shape = collision.shape.duplicate() 
	collision.shape.size = size - Vector2(6, 6)
	collision.position = texture.size / 2
