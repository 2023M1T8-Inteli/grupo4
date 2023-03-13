extends Node2D

onready var camera: Camera2D = get_node("Player/Camera2D")
onready var map = get_node("map")
onready var children = get_node("map").get_children()
var map_width = 0
var map_height = 0

var lockIf0 = true
var closeToPorta

func _ready():
	Global.activeObjective[0] == false
	$Player.global_position = pos.posADM
	if pos.posADM == Vector2(381,79):
		$Player.downPress = true
		$WalkInPlayer.play("WalkIn")
	camera.zoom = Vector2(0.6,0.6)
	$Player/Fantasma.visible = false
	$Player/Ze.visible = true
	_getMapLimits()
	set_process(true)

func _process(_delta):
	var camera_limits = Rect2(map.global_position, Vector2(map_width, map_height))
	camera.limit_left = camera_limits.position.x
	#camera.limit_top = camera_limits.position.y
	camera.limit_right = 768 #mudar depois para funcao que pega os limites
	camera.limit_bottom = 1344 #mudar depois para funcao que pega os limites
	
	if $Player/HitBox.global_position.distance_to($PortaAncora.global_position) < 90:
		Global.closeToSomething = true
		closeToPorta = true
	else:
		Global.closeToSomething = false
		closeToPorta = false
	
	if closeToPorta and Global.midPress and lockIf0:
		lockIf0 = false
		yield(get_tree().create_timer(0.15), "timeout")
		pos.posADM = $Player.global_position
		if get_tree().change_scene("res://Scenes/Cidade.tscn") != OK:
			print("ERRO")
	
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
