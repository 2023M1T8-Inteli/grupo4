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

onready var root_node = get_tree().get_root()

#definir variáveis de movimentação
onready var leftPress = Global.leftPress
onready var rightPress = Global.rightPress
onready var upPress = Global.upPress
onready var downPress = Global.downPress


func _process(_delta):
	if pos.savePosCommand == true:
		pos.savePosCommand = false
		pos.currentPos = self.global_position
		pos.posScene = get_parent().get_path()
		SceneTransition.change_scene("res://Scenes/Title Screen.tscn", 1.5 , 1.5)
		
	
	arrow.active_objective = Global.activeObjective[1]
	if self.global_position.distance_to(Global.activeObjective[1]) < 180:
		$Arrow.visible = false
	else:
		$Arrow.visible = true
		
func _ready():
	Global.leftPress = false
	Global.rightPress = false
	Global.upPress = false
	Global.downPress = false
	Global.midPress = false
	
	
	
	spriteB.visible = false # a sprite do fantasminha de costas não aparece.
	
		

#enquanto a setinha não ta apertada o player não se mexe 
func _on_LeftButton_button_up():
	Global.leftPress = false
#quando aperta a setinha da esquerda o personagem vai para a esquerda
func _on_LeftButton_button_down():
	Global.leftPress = true
#enquanto a setinha não ta apertada o player não se mexe 
func _on_RightButton_button_up():
	Global.rightPress = false
#quando aperta a setinha da direita o personagem vai para a direita
func _on_RightButton_button_down():
	Global.rightPress = true
#enquanto a setinha não ta apertada o player não se mexe 
func _on_UpButton_button_up():
	Global.upPress = false
#quando aperta a setinha de cima o personagem vai para cima
func _on_UpButton_button_down():
	Global.upPress = true
#enquanto a setinha não ta apertada o player não se mexe 
func _on_DownButton_button_up():
	Global.downPress = false
#quando aperta a setinha de baixo o personagem vai para baixo
func _on_DownButton_button_down():
	Global.downPress = true

	
#física do jogo
func _physics_process(delta):
	if Input.is_action_pressed("touch"):
		target_position = get_viewport().get_mouse_position()
		var angle = atan2(target_position.x - 180, target_position.y - 320)
		var x = sin(angle) * 1
		var y = cos(angle) * 1
		var velocity = Vector2(x*speed, y*speed)
		move_and_slide(velocity, Vector2.UP)
		_player_dir(velocity)
	else:
		_player_dir(Vector2(0,0))
	


#Funcao responsavel por controlar que direcao o player esta olhando enquanto/apos se mexer
func flip_sprites(flip: bool):
	# Inverte a sprite horizontalmente de acordo com a direcao do jogador
	spriteA.flip_h = flip
	spriteB.flip_h = flip
	zeIdle.flip_h = flip
	zeCorre.flip_h = flip

# Funcao que lida com a troca de sprites entre parado e andando
func idle_sprites(show_idle: bool):
	# Altera a visibilidade das sprites para mostrar a animacao parada ou andando
	zeIdle.visible = show_idle
	zeCorre.visible = not show_idle

func _player_dir(velocity):
	# Verifica se o jogador está parado
	if velocity == Vector2(0,0):
		idle_sprites(true)
	else:
		idle_sprites(false)
	
	# Faz o jogador olhar para a direção que está se movendo
	if velocity.x < 0:
		flip_sprites(true)
	elif velocity.x > 0:
		flip_sprites(false)





func _on_MidButton_button_up():
	Global.midPress = false


func _on_MidButton_button_down():
	Global.midPress = true
