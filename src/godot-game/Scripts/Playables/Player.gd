extends KinematicBody2D

# Definindo variaveis

# Facilita minha vida (EBAA)
onready var arrow = $Arrow

# Variaveis de bebado
var amplitude = 60
var frequency = 5

# Variaveis de movimentacao
var angle
var x = 0
var y = 0
var velocity
var target_position: Vector2

# Variaveis que controlam o arrow
var closeEnough = 140

# Variaveis exportadas (facilitam o controle individual do player por cena)
export(String) var personagemAtivo = "zezinho"
export(int) var speed = 350
export(float) var size = 1.0

# Aquele sinal la que facilita mto minha vida (controla tamanho da setinha dependendo do tamanho do player)
signal sizeSignal

func _process(_delta):
	
	# AQUI SALVAMOS A POSICAO DO PLAYER, TENHA EM MENTE QUE ESSA FUNCAO ESTA MUITO VELHA
	# ENTAO TALVEZ NAO FUNCIONE MUITO BEM
	if pos.savePosCommand == true:
		print("res://Scenes/Playables/Environment/",str(get_parent().get_path()).get_slice("/",2),".tscn")
		pos.savePosCommand = false
		pos.currentPos = self.global_position
		pos.posScene = "res://Scenes/Playables/Environment/"+str(get_parent().get_path()).get_slice("/",2)+".tscn"
	
	# Comunica com o node Arrow, indicando se tem objetivo ativo e qual seria sua posicao
	arrow.active_objective = Global.activeObjective[1]
	
	# Esconde o indicador de objetivo se o player esta perto suficiente
	if self.global_position.distance_to(Global.activeObjective[1]) < closeEnough:
		$Arrow.visible = false
	else:
		$Arrow.visible = true

	# Esconde o HUD de objetivo caso tenha algo escrito nele, mas o objetivo nao esteja ativo
	if $CanvasLayer/RichTextLabel.bbcode_text == "[center]"+Global.activeObjective[2]+"[/center]":
		$CanvasLayer.visible = Global.activeObjective[0]

func _ready():
	# Define personagens individualmente dependendo da parte do jogo em que o jogador se encontra
	if Global.parte == "executivo":
		personagemAtivo = "terezinha"
	elif Global.parte == "administrativo":
		personagemAtivo = "joninhas"
	elif Global.parte == "tecnico":
		personagemAtivo = "joaozinho"
	
	# Esconde o HUD de objetivo por padrao
	$CanvasLayer.visible = false
	
	# Se o tamanho do player > 1
	if size > 1.0:
		get_tree().quit() # Crasha o game
		
	# Define a animacao padrao do player como olhando para baixo
	$ActiveSprite.animation = personagemAtivo+"Baixo"
	
	# Redefine a velocidade de animacao de andar em relacao a velocidade atual do jogador
	#$ActiveSprite.speed_scale = float(speed)/350.0
	if float(speed) != 350:
		$ActiveSprite.speed_scale = 0.7
	
	# Redefine tamanho do player usando o tamanho definido pela variavel exportada
	self.scale = Vector2(size, size)
	
	# Redefine o closeEnough em escala com o tamanho do player
	closeEnough = closeEnough * size
	
	# Manda um sinal pra setinha que controla seu tamanho dependendo do tamanho do player
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
		
		# Lida com o direcionamento de sprites
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
				# pra direita parado
				pass
			else:
				# pra esquerda parado
				pass
		else:
			if y > 0:
				# pra baixo parado
				pass
			else:
				# pra cima parado
				pass

func objetivo(comAnimacao):
	if comAnimacao:
		# Cria um timer com um atraso de 0,5 segundos e espera até que ele expire
		yield(get_tree().create_timer(0.5), "timeout")
		# Esconde o nó "GUI" do nó pai
		get_parent().get_node("GUI").visible = false
		# Define a variável global "canMove" como falsa para impedir que o jogador se mova enquanto a animação é reproduzida
		Global.canMove = false
		
		# Armazena o valor atual do zoom da câmera
		var zoomAtualCamera = $Camera2D.zoom
		# Interpola a posição global da câmera de sua posição atual para a posição do objetivo ativo, durante 1 segundo
		$Tween.interpolate_property($Camera2D, "global_position", self.global_position, Global.activeObjective[1], 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		# Inicia a animação
		$Tween.start()
		# Espera até que a animação seja concluída
		yield($Tween, "tween_completed")
		
		# Aguarda por mais 0,5 segundos
		yield(get_tree().create_timer(0.5), "timeout")
		
		# Interpola o zoom da câmera de seu valor atual para um valor levemente menor, durante 0,5 segundos
		$Tween.interpolate_property($Camera2D, "zoom", zoomAtualCamera, Vector2(zoomAtualCamera.x-0.2,zoomAtualCamera.y-0.2), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		# Inicia a animação
		$Tween.start()
		# Espera até que a animação seja concluída
		yield($Tween, "tween_completed")
		
		# Interpola o zoom da câmera de seu valor atual (um pouco menor) para seu valor original, durante 0,5 segundos
		$Tween.interpolate_property($Camera2D, "zoom", Vector2(zoomAtualCamera.x-0.2,zoomAtualCamera.y-0.2), zoomAtualCamera, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		# Inicia a animação
		$Tween.start()
		# Espera até que a animação seja concluída
		yield($Tween, "tween_completed")
		
		# Interpola a posição global da câmera de volta para sua posição original, durante 1 segundo
		$Tween.interpolate_property($Camera2D, "global_position", Global.activeObjective[1], self.global_position, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		# Inicia a animação
		$Tween.start()
		# Espera até que a animação seja concluída
		yield($Tween, "tween_completed")
		
		# Define a variável global "canMove" como verdadeira para permitir que o jogador se mova novamente
		Global.canMove = true
		# Torna o nó "GUI" do nó pai visível novamente
		get_parent().get_node("GUI").visible = true
	
	# Torna o nó "CanvasLayer" visível
	$CanvasLayer.visible = true
	# Define o texto do "RichTextLabel" filho do "CanvasLayer" como o texto do objetivo ativo, centralizado
	$CanvasLayer/RichTextLabel.bbcode_text = "[center]"+Global.activeObjective[2]+"[/center]"
