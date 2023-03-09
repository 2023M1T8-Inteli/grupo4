extends KinematicBody2D

var speed = 450

onready var arrow = $Arrow

var amplitude = 60
var frequency = 5

var vel : Vector2 = Vector2()


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
	if self.global_position.distance_to(Global.activeObjective[1]) < 200:
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
func _physics_process(_delta):
	if Global.isDrunk == true:
		var time = OS.get_ticks_msec() / 1000.0
		var x_offset = amplitude * sin(time * frequency)
		var y_offset = amplitude * cos(time * frequency)
		var speed = Vector2(450, 450)
		var direction = Vector2()
		if Input.is_action_pressed("move_left") or Global.leftPress == true:
			direction.x -= 1
			leftPress = true
		else:
			leftPress = false
		if Input.is_action_pressed("move_right") or Global.rightPress == true:
			direction.x += 1
			rightPress = true
		else:
			rightPress = false
		if Input.is_action_pressed("move_up") or Global.upPress == true:
			direction.y -= 1
			upPress = true
		else:
			upPress = false
		if Input.is_action_pressed("move_down") or Global.downPress == true:
			direction.y += 1
			downPress = true
		else:
			downPress = false
		direction = direction.normalized()
		if leftPress or downPress or upPress or rightPress:
			var velocity = direction * speed + Vector2(x_offset, y_offset)
			vel = move_and_slide(velocity, Vector2.UP)
		_player_dir()
	else:
		var speed = Vector2(450, 450) 
		var direction = Vector2()
		if Input.is_action_pressed("move_left") or Global.leftPress == true:
			direction.x -= 1
			leftPress = true
		else:
			leftPress = false
		if Input.is_action_pressed("move_right") or Global.rightPress == true:
			direction.x += 1
			rightPress = true
		else:
			rightPress = false
		if Input.is_action_pressed("move_up") or Global.upPress == true:
			direction.y -= 1
			upPress = true
		else:
			upPress = false
		if Input.is_action_pressed("move_down") or Global.downPress == true:
			direction.y += 1
			downPress = true
		else:
			downPress = false
		direction = direction.normalized()
		vel = direction * speed
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
