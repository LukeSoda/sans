extends UtOption

### UtTextOption ###
# Extends the abstract UtOption
class_name UtTextOption

@onready var textNode = $text # Used for setting text on ready

@export var optionText : String # Text can be inputed more easily

func _ready():
	super._ready()
	textNode.text = optionText
