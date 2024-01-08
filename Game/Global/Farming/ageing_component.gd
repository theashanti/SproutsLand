class_name AgeingComponent

extends Node
## Track object age and can replace target scene(usually parent)
## with a new scene after reaching an age_threshold

signal age_changed(new_age : float, last_age : float)
signal age_threshold_reached(new_scene : Node2D)

## When set is the scene that will be replaced with next_scene
## Otherwise the direct parent will be used
@export var target : Node2D
@export var current_age = 0.0 :
	set(value):
		if(current_age != value):
			var last_age = current_age
			current_age = value
			emit_signal("age_changed", current_age, last_age)
			
			if (current_age >= age_threshold && _threshold_reached != true):
				var new_scene : Node2D 
				
				if(next_scene != null):
					new_scene = _create_next_scene()
				
				emit_signal("age_threshold_reached", new_scene)
				_threshold_reached = true
				target.queue_free()


@export var age_threshold = 1.0
@export var next_scene : PackedScene

static var group_name = "AgeingComponent"

var _threshold_reached = false

func _ready():
	if(target == null):
		target = get_parent()
		
	add_to_group(group_name)

func _create_next_scene() -> Node2D:
	var instance : Node2D = next_scene.instantiate()
	target.get_parent().add_child(instance)
	instance.global_transform = target.global_transform
	return instance
	
	
