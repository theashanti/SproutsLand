extends Node

class_name HeightAdjusterComponent

@export var body : CharacterBody2D
@export var default_layer : int = 1
@export var high_layer : int = 8

@export var tilemap : TileMap :
	set(value):
		tilemap = value
		layers = tilemap.get_layers_count()
		
var layers : int

func _ready():
	#SignalBus.connect("level_loaded", _on_level_loaded)
	pass

func _physics_process(delta):
	var make_above_ground = _check_if_elevated()
	
	_set_mask_and_collision(default_layer, !make_above_ground)
	_set_mask_and_collision(high_layer, make_above_ground)
	
func _on_level_loaded(level : Node2D):
	for child in level.get_children():
		if(child is TileMap):
			tilemap = child
			break
	
	assert(tilemap)

func _check_if_elevated() -> bool:
	var tile_under: Vector2i = tilemap.local_to_map(body.position)
	
	for layer in layers:
		var tile_data = tilemap.get_cell_tile_data(layer, tile_under)
		
		if (tile_data && tile_data.get_custom_data("elevate")):
			return true
			
	return false

func _set_mask_and_collision(layer : int, value : bool):
	body.set_collision_layer_value(layer, value)
	body.set_collision_mask_value(layer, value)
