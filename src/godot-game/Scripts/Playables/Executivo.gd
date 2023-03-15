extends Node2D

# Variáveis para referenciar a câmera, o mapa e seus limites
onready var camera: Camera2D = get_node("Player/Camera2D")
onready var map = get_node("map")
onready var children = get_node("map").get_children()
var map_width = 0
var map_height = 0

# Variáveis para o controle de posição do jogador e para a interação com a porta
var lockIf0 = true
var closeToPorta

func _ready():
	if ExecutivoGlobals.reuniao:
		# Define que o primeiro objetivo está ativo e qual é a posição do objeto 'ADM' (Representa a entrada do prédio)
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $ReuniaoAncora.global_position
		$NPCQuiz1.visible = false
	
	# Habilita o movimento do jogador
	Global.canMove = true
	
	# Se a posição atual for em um cenário jogável, posicione o jogador na posição atual
	# Caso contrário, posicione-o na posição da cidade e toque a animação de transição
	if pos.posScene == "res://Scenes/Playables/Environment/Executivo.tscn":
		$Player.global_position = pos.currentPos
		pos.posScene = null
	else:
		$Player.global_position = pos.posADM
		#$WalkInPlayer.play("WalkIn")
		#Global.moving = true
	
	# Define o zoom da câmera e obtém os limites do mapa
	camera.zoom = Vector2(0.5,0.5)
	set_process(true)

func _process(_delta):
	# Define os limites da câmera para o tamanho do mapa
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = 576
	camera.limit_bottom = 640
	
	# Verifica se o jogador está próximo da porta de interação
	if $Player/HitBox.global_position.distance_to($PortaAncora.global_position) < 160:
		closeToPorta = true
	else:
		closeToPorta = false
	
	
	
	if $Player/HitBox.global_position.distance_to($ReuniaoAncora/ReuniaoAtivador.global_position) < 30 and ExecutivoGlobals.reuniao:
		ExecutivoGlobals.reuniao = false
		pos.savePosCommand = true
		yield(get_tree().create_timer(0.05), "timeout")
		_reuniao_anim()
	
	if $"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa".phraseNum == 1 and $"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa".finished == false and ExecutivoGlobals.deadBolt0:
			ExecutivoGlobals.deadBolt0 = false
			$ReuniaoAncora/ReuniaoAnim/Camera2D.position = Vector2(358,596)
			#_reuniao_anim().resume()
			print("AGORA?")
	if $"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa".phraseNum == 2 and $"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa".finished == false and ExecutivoGlobals.deadBolt1:
			ExecutivoGlobals.deadBolt1 = false
			$ReuniaoAncora/ReuniaoAnim/Camera2D.position = Vector2(37,596)

	
func _on_TextureButton_pressed():
	# Verifica se o jogador está perto da porta
	if closeToPorta:
		# Impede o movimento do jogador durante a transição de cena
		Global.canMove = false
		# Aguarda um curto período antes de mudar de cena, para que a animação da porta seja executada
		yield(get_tree().create_timer(0.15), "timeout")
		# Tenta mudar para a cena "Cidade.tscn", exibindo uma mensagem de erro em caso de falha		
		if get_tree().change_scene("res://Scenes/Playables/Environment/Cidade.tscn") != OK:
			print("ERRO")

# Quando a animação de entrada do jogador termina, define a variável Global.moving (que controla a animação de andar) como false
func _on_WalkInPlayer_animation_finished(_anim_name):
	Global.moving = false
	
func _reuniao_anim():
	Global.canMove = false
	$Player/Camera2D.current = false
	$GUI.visible = false
	Global.activeObjective[0] = false
	$ReuniaoAncora/ReuniaoAnim/Camera2D.current = true
	$ReuniaoAncora/ReuniaoAnim.play("CameraZoomIn")
	yield($ReuniaoAncora/ReuniaoAnim, 'animation_finished')
	
	
	$ReuniaoAncora/ReuniaoAnim.play("CameraFlyOver")
	yield($ReuniaoAncora/ReuniaoAnim, 'animation_finished')
	$"ReuniaoAncora/ReuniaoAnim/DialogBox 2".visible = true
	$"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa"._startDialog()
	yield($"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa", "finish")
	$ReuniaoAncora/ReuniaoAnim.play_backwards("CameraFlyOver")
	yield($ReuniaoAncora/ReuniaoAnim, 'animation_finished')
	
	$ReuniaoAncora/ReuniaoAnim.playback_speed = 1
	
	$ReuniaoAncora/ReuniaoAnim.play_backwards("CameraZoomIn")
	yield($ReuniaoAncora/ReuniaoAnim, 'animation_finished')
	$ReuniaoAncora/ReuniaoAnim/Camera2D.current = false
	$GUI.visible = true
	$Player/Camera2D.current = true
	Global.canMove = true
	
	$NPCQuiz1.visible = true
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $NPCQuiz1/AncoraQuiz1.global_position


func _on_Quiz1Button_pressed():
	Global.activeObjective[0] = false
	$NPCQuiz1/BalaoExclamacao.visible = false
	$NPCQuiz1/Quiz1Button.visible = false
	$NPCQuiz1/QuizTask.visible = true
	$NPCQuiz1/QuizTask._startQuiz()
	Global.canMove = false
	if $NPCQuiz1/QuizTask/DialogBox/TexturaCaixa.connect("quizCorrect", self, "_finish_quiz") != OK:
		print("ERROR ON QUIZCORRECT CONNECT")

func _finish_quiz():
	yield(get_tree().create_timer(0.5), "timeout")
	Global.canMove = true

