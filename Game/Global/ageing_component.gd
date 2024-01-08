extends Button

@export var age_amount_on_press = 1.0

func _ready():
	connect("pressed", _on_pressed)

func _on_pressed():
	for ageing_component in get_tree().get_nodes_in_group(AgeingComponent.group_name):
		if(ageing_component is AgeingComponent):
			ageing_component.current_age += age_amount_on_press
		else:
			push_error(ageing_component.name + "node is not an AgeingComponent")
