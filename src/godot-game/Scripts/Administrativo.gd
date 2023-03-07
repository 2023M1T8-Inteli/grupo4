extends Node2D

onready var camera: Camera2D = get_node("Player/Camera2D")
onready var map = get_node("map")
onready var children = get_node("map").get_children()
var map_width = 0
var map_height = 0

func _ready():
	get_node("Player/Fantasma").visible = true
	_getMapLimits()
	set_process(true)

func _process(delta):
	var camera_limits = Rect2(map.global_position, Vector2(map_width, map_height))
	camera.limit_left = camera_limits.position.x
	camera.limit_top = camera_limits.position.y
	camera.limit_right = 768 #mudar depois para funcao que pega os limites
	camera.limit_bottom = 1344 #mudar depois para funcao que pega os limites

func _getMapLimits():
	# Iterate through all child nodes of the map node
	for child in children:
		# Check if the child is a sprite
		if child is Sprite:
			# Get the global position of the sprite
			var sprite_pos = child.global_position
			# Update map_width and map_height if necessary
			map_width = max(map_width, sprite_pos.x + child.texture.get_size().x * child.scale.x)
			map_height = max(map_height, sprite_pos.y + child.texture.get_size().y * child.scale.y)
			print(map_height)
			print(map_width)
