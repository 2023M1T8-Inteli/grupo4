extends KinematicBody2D

onready var arrow = $Arrow

var amplitude = 60
var frequency = 5

var angle
var x = 0
var y = 0
var velocity

var closeEnough = 140

var target_position: Vector2

export(String) var personagemAtivo = "zezinho"
export(int) var speed = 350
export(float) var size = 1.0

signal sizeSignal

onready var root_node = get_tree().get_root()

func _process(_delta):
	if pos.savePosCommand == true:
		print("res://Scenes/Playables/Environment/",str(get_parent().get_path()).get_slice("/",2),".tscn")
		pos.savePosCommand = false
		pos.currentPos = self.global_position
		pos.posScene = "res://Scenes/Playables/Environment/"+str(get_parent().get_path()).get_slice("/",2)+".tscn"
		
	arrow.active_objective = Global.activeObjective[1]
	if self.global_position.distance_to(Global.activeObjective[1]) < closeEnough:
		$Arrow.visible = false
	else:
		$Arrow.visible = true


	if $CanvasLayer/RichTextLabel.bbcode_text == "[center]"+Global.activeObjective[2]+"[/center]":
		$CanvasLayer.visible = Global.activeObjective[0]

func _ready():
	if Global.parte == "executivo":
		personagemAtivo = "terezinha"
	elif Global.parte == "administrativo":
		personagemAtivo = "joninhas"
	$CanvasLayer.visible = false
	if size > 1.0:
		get_tree().quit() # Crasha o game
	$ActiveSprite.animation = personagemAtivo+"Baixo"
	$ActiveSprite.speed_scale = float(speed)/350.0
	self.scale = Vector2(size, size)
	
	closeEnough = closeEnough * size
	
	if connect("sizeSignal", $Arrow, "_recieve_size") != OK:
		print("Deu erro no connect 'sizeSignal'")
	emit_signal("sizeSignal", size)
	
# Física do jogo
func _physics_process(_delta):
	if Input.is_action_pressed("touch") and Global.canMove:
		# Define a posição do alvo do jogador com base na posição do mouse
		target_position = get_viewport().get_mouse_position()
		# Calcula o ângulo entre a posição do jogador e do alvo
		angle = atan2(target_position.x - (get_viewport_transform().xform(self.global_position)).x, target_position.y - (get_viewport_transform().xform(self.global_position)).y)
		# Calcula as velocidades horizontal e vertical com base no ângulo e na velocidade
		x = sin(angle) * 1
		y = cos(angle) * 1
		velocity = Vector2(x*speed, y*speed)
		# Move o jogador e lida com colisões
		var _moveAndSlide = move_and_slide(velocity, Vector2.UP)
		$ActiveSprite.playing = true
		
		if y < cos(PI/12) and y > -cos(-PI/12):
			if x > 0:
				$ActiveSprite.animation = personagemAtivo+"Lado"
				$ActiveSprite.flip_h = true
			else:
				$ActiveSprite.animation = personagemAtivo+"Lado"
				$ActiveSprite.flip_h = false
		else:
			if y > 0:
				$ActiveSprite.animation = personagemAtivo+"Baixo"
			else:
				$ActiveSprite.animation = personagemAtivo+"Cima"
			
		
	elif Global.moving:
		$ActiveSprite.animation = personagemAtivo+"Baixo"
	else:
		$ActiveSprite.playing = false
		$ActiveSprite.frame = 1
		if y < cos(PI/12) and y > -cos(-PI/12):
			if x > 0:
				# sexo horizontal pra direita parado
				pass
			else:
				# sexo horizontal pra esquerda parado
				pass
		else:
			if y > 0:
				# nao sexo vertical pra baixo parado
				pass
			else:
				# nao sexo vertical pra cima parado
				pass

func objective(withAnim):
	if withAnim:
		yield(get_tree().create_timer(0.5), "timeout")
		Global.canMove = false
	
		var currentCameraZoom = $Camera2D.zoom
		$Tween.interpolate_property($Camera2D, "global_position", self.global_position, Global.activeObjective[1], 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
	
		yield(get_tree().create_timer(0.5), "timeout")
	
		$Tween.interpolate_property($Camera2D, "zoom", currentCameraZoom, Vector2(currentCameraZoom.x-0.2,currentCameraZoom.y-0.2), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
	
		$Tween.interpolate_property($Camera2D, "zoom", Vector2(currentCameraZoom.x-0.2,currentCameraZoom.y-0.2), currentCameraZoom, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
	
		$Tween.interpolate_property($Camera2D, "global_position", Global.activeObjective[1], self.global_position, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
	
		Global.canMove = true
	
	$CanvasLayer.visible = true
	$CanvasLayer/RichTextLabel.bbcode_text = "[center]"+Global.activeObjective[2]+"[/center]"
