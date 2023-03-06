extends KinematicBody2D

var speed = 450

var timer = Timer.new()

var last_offset = Vector2.ZERO

var vel : Vector2 = Vector2()

#Atribuindo nossa sprite como variavel
onready var spriteA : AnimatedSprite = get_node("Fantasma/Ghost")
onready var spriteB : AnimatedSprite = get_node("Fantasma/GhostBack")

onready var zeIdle : AnimatedSprite = get_node("Ze/ZeIdle")
onready var zeCorre : AnimatedSprite = get_node("Ze/ZeCorrendo")

var isDrunk = false

onready var root_node = get_tree().get_root()

#definir variáveis de movimentação
onready var leftPress = Global.leftPress
onready var rightPress = Global.rightPress
onready var upPress = Global.upPress
onready var downPress = Global.downPress

func _ready():
	spriteB.visible = false # a sprite do fantasminha de costas não aparece.

	add_child(timer)
	timer.set_wait_time(0.0025)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.start()
	

	if str(self.get_parent()).get_slice(":", 0) == "Prelude":
		if get_node("/root/Prelude").connect("is_drunk", self, "is_drunk") != OK:
			print ("An unexpected error occured when trying to connect to the signal")
		else:
			print("CONNECTED")
	
	
	if isDrunk == true:
		speed = 225
		
func is_drunk():
	print("MF DRUNK")
	isDrunk = true

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

func simulate_drunk_movement(strength: float):
	var target_vel = Vector2(rand_range(-strength, strength), rand_range(-strength, strength))
	var lerp_speed = 0.05
	vel = vel.linear_interpolate(target_vel, lerp_speed)


func _on_timer_timeout():
	if isDrunk == true:
		var target_zoom = Vector2(rand_range(0.5, 1.5), rand_range(0.5, 1.5))
		var lerp_speed = 0.005
		# Lerp the camera zoom
		$Camera2D.zoom = $Camera2D.zoom.linear_interpolate(target_zoom, lerp_speed)
	
#física do jogo
func _physics_process(_delta):
	
	vel.x = 0
	vel.y = 0
	
	if isDrunk == true:
		simulate_drunk_movement(450)
	
	if Input.is_action_pressed("move_left") or Global.leftPress == true:
		leftPress = true
	else:
		leftPress = false
	if leftPress == true:
		vel.x -= speed
	if Input.is_action_pressed("move_right") or Global.rightPress == true:
		rightPress = true
	else:
		rightPress = false
	if rightPress == true:
		vel.x += speed
	if Input.is_action_pressed("move_up") or Global.upPress == true:
		upPress = true
	else:
		upPress = false
	if upPress == true:
		vel.y -= speed
	if Input.is_action_pressed("move_down") or Global.downPress == true:
		downPress = true
	else:
		downPress = false
	if downPress == true:
		vel.y += speed
		
	if Input.is_action_pressed("pause"):
			if get_tree().change_scene("res://Scenes/Title Screen.tscn") != OK:
				print ("An unexpected error occured when trying to switch to the scene")

	vel = move_and_slide(vel, Vector2.UP)
	
	_player_dir()


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

func _player_dir():
	# Variáveis para armazenar a direção do jogador
	var fLeft = false
	var fRight = false
	var fUp = false
	var fDown = false

	# Verifica se o jogador está parado
	if leftPress == false and rightPress == false and upPress == false and downPress == false:
		idle_sprites(true)
	else:
		idle_sprites(false)
	
	# Faz o jogador olhar para a direção que está se movendo
	if leftPress ==  true:
		fLeft = true
		fRight = false
	elif rightPress == true:
		fRight = true
		fLeft = false
	
	# Mostra a sprite das costas quando o jogador se move verticalmente para baixo
	if downPress == true:
		fDown = true
		fUp = false
	elif upPress == true:
		# Mostra a sprite da frente quando o jogador se move verticalmente para cima
		spriteA.visible = true
		spriteB.visible = false
		fUp = true
		fDown = false
		
	# Volta a sprite para a posição normal dependendo da direção em que o jogador está se movendo
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
		




func _on_MidButton_button_up():
	Global.midPress = false


func _on_MidButton_button_down():
	Global.midPress = true
