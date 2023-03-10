extends Node2D

onready var camera: Camera2D = get_node("Player/Camera2D")
onready var map = get_node("map")
onready var children = get_node("map").get_children()
var map_width = 0
var map_height = 0

var lockIf0 = true
var closeToPorta

func _ready():
	get_node("Player/Ze").visible = false
	get_node("Player/Fantasma").visible = false
	get_node("Player/Tereza").visible = true
	get_node("Player/Jonas").visible = false
	Global.canMove = true
	
	if pos.posScene == "res://Scenes/Administrativo.tscn":
		$Player.global_position = pos.currentPos
		pos.posScene = null
	else:
		$Player.global_position = pos.posADM
		$WalkInPlayer.play("WalkIn")
		Global.moving = true
	camera.zoom = Vector2(0.8,0.8)
	_getMapLimits()
	set_process(true)
	
	yield(get_tree().create_timer(3.0), "timeout")
	SceneTransition.change_scene("res://Scenes/Reincarn.tscn", 1, 1)
	pos.posScene = "res://Scenes/Cidade.tscn"
	
func _process(_delta):
	var camera_limits = Rect2(map.global_position, Vector2(map_width, map_height))
	camera.limit_left = camera_limits.position.x
	#camera.limit_top = camera_limits.position.y
	camera.limit_right = 768 #mudar depois para funcao que pega os limites
	camera.limit_bottom = 1344 #mudar depois para funcao que pega os limites
	
	if $Player/HitBox.global_position.distance_to($PortaAncora.global_position) < 160:
		closeToPorta = true
	else:
		closeToPorta = false
	

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


func _on_TextureButton_pressed():
	print("pressed")
	if closeToPorta:
		Global.canMove = false
		yield(get_tree().create_timer(0.15), "timeout")
		if get_tree().change_scene("res://Scenes/Cidade.tscn") != OK:
			print("ERRO")


func _on_WalkInPlayer_animation_finished(_anim_name):
	Global.moving = false
