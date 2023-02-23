extends KinematicBody2D

var speed = 450

var vel : Vector2 = Vector2()

#Atribuindo nossa sprite como variavel
onready var spriteA : AnimatedSprite = get_node("Fantasma/Ghost")
onready var spriteB : AnimatedSprite = get_node("Fantasma/GhostBack")

onready var zeIdle : AnimatedSprite = get_node("Ze/ZeIdle")
onready var zeCorre : AnimatedSprite = get_node("Ze/ZeCorrendo")

# var sprite_list = [spriteA, spriteB, zeIdle, zeCorre]

onready var	root_node = get_tree().get_root()

#definir variáveis de movimentação
var leftPress = false
var rightPress = false
var upPress = false
var downPress = false

func _ready():
	spriteB.visible = false # a sprite do fantasminha de costas não aparece.

#enquanto a setinha não ta apertada o player não se mexe 
func _on_LeftButton_button_up():
	leftPress = false
	
#quando aperta a setinha da esquerda o personagem vai para a esquerda
func _on_LeftButton_button_down():
	leftPress = true
	
#enquanto a setinha não ta apertada o player não se mexe 
func _on_RightButton_button_up():
	rightPress = false
	
#quando aperta a setinha da direita o personagem vai para a direita
func _on_RightButton_button_down():
	rightPress = true

#enquanto a setinha não ta apertada o player não se mexe 
func _on_UpButton_button_up():
	upPress = false
	
#quando aperta a setinha de cima o personagem vai para cima
func _on_UpButton_button_down():
	upPress = true

#enquanto a setinha não ta apertada o player não se mexe 
func _on_DownButton_button_up():
	downPress = false

#quando aperta a setinha de baixo o personagem vai para baixo
func _on_DownButton_button_down():
	downPress = true


#física do jogo
func _physics_process(_delta):
	
	vel.x = 0
	vel.y = 0


	#Controles do player
	if Input.is_action_pressed("move_left") or leftPress == true:
		vel.x -= speed
	if Input.is_action_pressed("move_right") or rightPress == true:
		vel.x += speed
	if Input.is_action_pressed("move_up") or upPress == true:
		vel.y -= speed
	if Input.is_action_pressed("move_down") or downPress == true:
		vel.y += speed
		
	if Input.is_action_pressed("pause"):
		get_tree().change_scene("res://Scenes/Title Screen.tscn")

	vel = move_and_slide(vel, Vector2.UP)
	
	_player_dir()

func _on_LeftButton_pressed():
	print("p")
#Funcao responsavel por controlar que direcao o player esta olhando enquanto/apos se mexer
func flip_sprites(flip: bool):
	spriteA.flip_h = flip
	spriteB.flip_h = flip
	zeIdle.flip_h = flip
	zeCorre.flip_h = flip
	
func idle_sprites(show_idle: bool):
	zeIdle.visible = show_idle
	zeCorre.visible = not show_idle

func _player_dir():
		
	var fLeft
	var fRight
	var fUp
	var fDown
	
	if vel.x == 0 and vel.y == 0:
		idle_sprites(true)
	else:
		idle_sprites(false)
	
	#Faz player olhar para direcao que esta andando	
	if vel.x < 0:
		fLeft = true
		fRight = false
	elif vel.x > 0:
		fRight = true
		fLeft = false
	#Faz a sprite das costas aparecer qdo o player se move verticalmente para baixo
	if vel.y < 0:
		fDown = true
		fUp = false
	elif vel.y > 0:
		spriteA.visible = true
		spriteB.visible = false
		fUp = true
		fDown = false
		
	if fLeft == true:
		flip_sprites(true)
	if fRight == true:
		flip_sprites(false)
	if fDown == true:
		spriteA.visible = false
		spriteB.visible = true
	if fUp == true:
		spriteA.visible = true
		spriteB.visible = false
		
