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
	Global.parte = "administrativo"
	
	if $"AbordagemControl/DialogBox 6/TexturaCaixa".connect("finish", self, "_finish_dialog_6") != OK:
			print("ERROR ON DIALOGBOX 6 CONNECT")

	Global.canMove = true
	if AdmGlobals.currentTask == 0:
		# Define que o primeiro objetivo está ativo e qual é a posição do objeto 'ADM' (Representa a entrada do prédio)
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $Task1ADM/ComputadorAncora.global_position

		_play_abordagem_anim()
		$map/Elevador/TextureButton.visible = false
		$Task1ADM.visible = true
	elif AdmGlobals.currentTask == 1:
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $Task1ADM/ComputadorAncora.global_position
		Global.activeObjective[2] = "Volte ao trabalho"
		$Player.objective(true)
		$Task2ADM.visible = true
		
	elif AdmGlobals.currentTask == 2:
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $Task1ADM/ComputadorAncora.global_position
		Global.activeObjective[2] = "Arrume suas coisas e vá para casa"
		$Player.objective(true)
		$Task3ADM.visible = true
		
	# Se a posição atual for em um cenário jogável, posicione o jogador na posição atual
	# Caso contrário, posicione-o na posição da cidade e toque a animação de transição
	if pos.posScene == "res://Scenes/Playables/Environment/Administrativo.tscn":
		$Player.global_position = pos.currentPos
		pos.posScene = null
	else:
		$Player.global_position = pos.posADM
		print($Player.global_position)
	
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
func _on_TextureButton_pressed():
	# Verifica se o jogador está perto da porta
	if closeToPorta and AdmGlobals.currentTask == 0:
		# Impede o movimento do jogador durante a transição de cena
		Global.canMove = false
		# Aguarda um curto período antes de mudar de cena, para que a animação da porta seja executada
		yield(get_tree().create_timer(0.15), "timeout")
		# Tenta mudar para a cena "Cidade.tscn", exibindo uma mensagem de erro em caso de falha		
		if get_tree().change_scene("res://Scenes/Playables/Environment/Cidade.tscn") != OK:
			print("ERRO")
			
	if closeToPorta and (AdmGlobals.currentTask == 1 or AdmGlobals.currentTask == 2 or AdmGlobals.currentTask == 3):
		# Impede o movimento do jogador durante a transição de cena
		Global.canMove = false
		# Aguarda um curto período antes de mudar de cena, para que a animação da porta seja executada
		yield(get_tree().create_timer(0.15), "timeout")
		# Tenta mudar para a cena "Cidade.tscn", exibindo uma mensagem de erro em caso de falha		
		if get_tree().change_scene("res://Scenes/Playables/Environment/ExecutivoFake.tscn") != OK:
			print("ERRO")
			
func _play_abordagem_anim():
	Global.canMove = false
	
	yield(get_tree().create_timer(0.2), "timeout")

	Global.activeObjective[0] = false
	
	$AnimationHandler.get_animation("AbordagemAnim").track_set_key_value(0, 1, Vector2($Player.position.x-106, 120))
	$AnimationHandler.play("AbordagemAnim")
	yield($AnimationHandler, "animation_finished")
	
	$"AbordagemControl/DialogBox 6".visible = true
	$"AbordagemControl/DialogBox 6/TexturaCaixa"._startDialog()
	
	# AQUI A GNT ESPERA A CAIXA DE DIALOGO ACABAR (FUNCAO _FINISH_DIALOG_6())
	
func _finish_dialog_6():
	$"AbordagemControl/DialogBox 6".visible = false
	
	$AnimationHandler.play_backwards("AbordagemAnim")
	yield($AnimationHandler, "animation_finished")
	
	yield(get_tree().create_timer(0.1), "timeout")
	Global.canMove = true
	
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $Task1ADM/ComputadorAncora.global_position
	Global.activeObjective[2] = "Comece a trabalhar em seu computador."
	$Player.objective(true)
	$map/Elevador/TextureButton.visible = true

func reincarn():
	yield(get_tree().create_timer(3.0), "timeout")
	SceneTransition.change_scene("res://Scenes/Non Playables/misc/Reincarn.tscn", 1, 1)
