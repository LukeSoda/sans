extends UtOption

### UtButtonOption ###
# Extends abstract UtOption. Handles changing the visibility of default and selected sprites when
# focus / unfocused
class_name UtButtonOption

func _ready():
	super._ready()
	
func grabFocus(player: CharacterBody2D) -> void:
	super.grabFocus(player)
	$default.visible = false
	$selected.visible = true

func loseFocus():
	super.loseFocus()
	$default.visible = true
	$selected.visible = false
	
