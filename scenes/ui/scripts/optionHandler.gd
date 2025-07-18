extends Node2D

signal changeContainer(ID: String)

var subMenu: int = 0

func _ready():
	emit_signal("changeContainer", "bottom")

func _physics_process(delta: float) -> void:
	if subMenu > 0 and Input.is_action_just_pressed("myBack"):
		exitSubMenu()

func bottomOptionPicked(optionID: String):
	match optionID:
		"fight":
			print("fight")
		"act":
			print("act")
		"item":
			print("item")
			subMenu += 1
			emit_signal("changeContainer", "items")
		"mercy":
			print("spared")

func itemOptionPicked(optionID: String):
	match optionID:
		"lhero":
			print("+1 HP")
		"steak":
			print("+2 HP")
		"noodles":
			print("+3 HP")
		"pie":
			print("+4 HP")
	exitSubMenu()

func exitSubMenu():
	subMenu -= 1
	emit_signal("changeContainer", "bottom")
