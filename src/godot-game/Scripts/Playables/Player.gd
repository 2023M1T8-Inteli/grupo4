extends KinematicBody2D

var speed = 450

onready var arrow = $Arrow

var amplitude = 60
var frequency = 5

var vel : Vector2 = Vector2()

var target_position: Vector2

#Atribuindo nossa sprite como variavel
onready var spriteA : AnimatedSprite = get_node("Fantasma/Ghost")
onready var spriteB : AnimatedSprite = get_node("Fantasma/GhostBack")

onready var zeIdle : AnimatedSprite = get_node("Ze/ZeIdle")
onready var zeCorre : AnimatedSprite = get_node("Ze/ZeCorrendo")

onready var terezaIdle = $Tereza/TerezaIdle
onready var terezaCorre = $Tereza/TerezaCorrendo

onready var jonasIdle = $Jonas/JonasIdle
onready var jonasCorre = $Jonas/JonasCorrendo

onready var root_node = get_tree().get_root()

func _process(_delta):
	if pos.savePosCommand == true:
		print("res://Scenes/Playables/Environment",str(get_parent().get_path()).get_slice("/",2),".tscn")
		pos.savePosCommand = false
		pos.currentPos = self.global_position
		pos.posScene = "res://Scenes/Playables/Environment"+str(get_parent().get_path()).get_slice("/",2)+".tscn"
		SceneTransition.change_scene("res://Scenes/Non Playables/misc/Title Screen.tscn", 1.5 , 1.5)
		
	arrow.active_objective = Global.activeObjective[1]
	if self.global_position.distance_to(Global.activeObjective[1]) < 180:
		$Arrow.visible = false
	else:
		$Arrow.visible = true
		
func _ready():
	spriteB.visible = false # a sprite do fantasminha de costas não aparece.

#física do jogo
func _physics_process(_delta):
	if Input.is_action_pressed("touch") and Global.canMove:
		target_position = get_viewport().get_mouse_position()
		var angle = atan2(target_position.x - (get_viewport_transform().xform(self.global_position)).x, target_position.y - (get_viewport_transform().xform(self.global_position)).y)
		var x = sin(angle) * 1
		var y = cos(angle) * 1
		var velocity = Vector2(x*speed, y*speed)
		var _moveAndSlide = move_and_slide(velocity, Vector2.UP)
		_player_dir(velocity)
	else:
		_player_dir(Vector2(0,0))

#Funcao responsavel por controlar que direcao o player esta olhando enquanto/apos se mexer
func flip_sprites(flip: bool):
	# Inverte a sprite horizontalmente de acordo com a direcao do jogador
	jonasCorre.flip_h = flip
	jonasIdle.flip_h = flip
	terezaCorre.flip_h = flip
	terezaIdle.flip_h = flip
	spriteA.flip_h = flip
	spriteB.flip_h = flip
	zeIdle.flip_h = flip
	zeCorre.flip_h = flip

# Funcao que lida com a troca de sprites entre parado e andando
func idle_sprites(show_idle: bool):
	# Altera a visibilidade das sprites para mostrar a animacao parada ou andando
	zeIdle.visible = show_idle
	zeCorre.visible = not show_idle
	jonasIdle.visible = show_idle
	jonasCorre.visible = not show_idle
	terezaIdle.visible = show_idle
	terezaCorre.visible = not show_idle

func _player_dir(velocity):
	# Verifica se o jogador está parado
	if velocity != Vector2(0,0):
		idle_sprites(false)
	elif Global.moving:
		idle_sprites(false)
	else:
		idle_sprites(true)
	
	# Faz o jogador olhar para a direção que está se movendo
	if velocity.x < 0:
		flip_sprites(true)
	elif velocity.x > 0:
		flip_sprites(false)
