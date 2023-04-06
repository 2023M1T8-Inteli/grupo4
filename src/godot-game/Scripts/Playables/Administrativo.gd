extends Node2D

# Variáveis para referenciar a câmera, o mapa e seus limites
onready var camera: Camera2D = get_node("Player/Camera2D")
onready var map = get_node("map")
onready var children = map.get_children()
var map_width = 0
var map_height = 0

# Variáveis para o controle de posição do jogador e para a interação com a porta
var closeToPorta = false

func _ready() -> void:
	
	# Toca o som do ambiente
	$GUI/Audio.set_volume(Global.volPercentage)
	$GUI/Audio.play_ambient("res://Audio Files/OfficeAmbiente2.mp3")
	
	Global.celularVisible = true
	
	# Define a parte do jogo atual
	Global.parte = "administrativo"

	# Conecta o sinal "finish" do "DialogBox 6" para o método "_finish_dialog_6"
	if $"AbordagemControl/DialogBox 6/TexturaCaixa".connect("finish", self, "_finish_dialog_6") != OK:
		print("ERRO AO CONECTAR O SINAL \"finish\" DO DIALOGBOX 6")

	# Define que o jogador pode se mover
	Global.canMove = true
	

	# Define qual é o objetivo atual
	if AdmGlobals.currentTask == 0:
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $Task1ADM/ComputadorAncora.global_position
		_play_abordagem_anim()
		$map/Elevador/TextureButton.visible = false
		$Task1ADM.visible = true
	elif AdmGlobals.currentTask == 2:
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $Task1ADM/ComputadorAncora.global_position
		Global.activeObjective[2] = "Volte ao trabalho."
		$Player.objective(true)
		$Task2ADM.visible = true
	elif AdmGlobals.currentTask == 3:
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $Task1ADM/ComputadorAncora.global_position
		Global.activeObjective[2] = "Arrume suas coisas e vá para casa."
		$Player.objective(true)
		$Task3ADM.visible = true

	# Verifica se a posição atual é em um cenário jogável, posicionando o jogador de acordo
	if pos.posScene == "res://Scenes/Playables/Environment/Administrativo.tscn":
		$Player/Camera2D.smoothing_enabled = false
		$Player.global_position = pos.currentPos
		pos.posScene = null
		yield(get_tree().create_timer(0.05), "timeout")
		$Player/Camera2D.smoothing_enabled = true
	else:
		$Player/Camera2D.smoothing_enabled = false
		$Player.global_position = pos.posADM
		print($Player.global_position)
		yield(get_tree().create_timer(0.05), "timeout")
		$Player/Camera2D.smoothing_enabled = true

	# Define o zoom da câmera e obtém os limites do mapa
	camera.zoom = Vector2(0.5, 0.5)
	set_process(true)

func _process(_delta: float) -> void:
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
	# Verifica se o jogador está perto da porta, se a tarefa atual é 1, 2 ou 3 e se ele pode se mover
	if closeToPorta and AdmGlobals.currentTask == 1 and AdmGlobals.canGo:
		AdmGlobals.canGo = false
		# Impede o movimento do jogador durante a transição de cena
		Global.canMove = false
		# Aguarda um curto período antes de mudar de cena, para que a animação da porta seja executada
		yield(get_tree().create_timer(0.15), "timeout")
		# Tenta mudar para a cena "Cidade.tscn", exibindo uma mensagem de erro em caso de falha	
		if get_tree().change_scene("res://Scenes/Playables/Environment/ExecutivoFake.tscn") != OK:
			print("ERRO")
			
			
	if closeToPorta and AdmGlobals.currentTask == 5:
		# Impede o movimento do jogador durante a transição de cena
		Global.canMove = false
		
		# Aguarda um curto período antes de mudar de cena, para que a animação da porta seja executada
		yield(get_tree().create_timer(0.15), "timeout")
		
		# Tenta mudar para a cena "Limbo3.tscn", exibindo uma mensagem de erro em caso de falha
		SceneTransition.change_scene("res://Scenes/Playables/Environment/Limbo3.tscn", 1, 1)
		
# Executa a animação de abordagem
func _play_abordagem_anim():
	# Desativa o movimento do player
	Global.canMove = false
	
	# Aguarda um curto período antes de executar a animação
	yield(get_tree().create_timer(0.2), "timeout")
	
	# Define a posição da animação de abordagem em relação à posição do jogador
	$AnimationHandler.get_animation("AbordagemAnim").track_set_key_value(0, 1, Vector2($Player.position.x-106, 120))
	$AnimationHandler.play("AbordagemAnim")
	
	# Aguarda o término da animação de abordagem
	yield($AnimationHandler, "animation_finished")
	
	$AbordagemControl/NPC1/AnimatedSprite.animation = "up"
	$AbordagemControl/NPC1/AnimatedSprite.playing = false
	$AbordagemControl/NPC1/AnimatedSprite.frame = 0
	
	# Exibe a caixa de diálogo e inicia a conversa
	$"AbordagemControl/DialogBox 6".visible = true
	$"AbordagemControl/DialogBox 6/TexturaCaixa"._startDialog()
	
	# Espera o término da caixa de diálogo
	# Função _FINISH_DIALOG_6() é chamada aqui
	
# Executa as ações após o término da caixa de diálogo
func _finish_dialog_6():
	# Esconde a caixa de diálogo
	$"AbordagemControl/DialogBox 6".visible = false
	
	# Reverte a animação de abordagem
	$AnimationHandler.play_backwards("AbordagemAnim")
	
	$AbordagemControl/NPC1/AnimatedSprite.flip_h = true
	$AbordagemControl/NPC1/AnimatedSprite.playing = true
	$AbordagemControl/NPC1/AnimatedSprite.animation = "horizontal"
	
	# Aguarda o término da animação
	yield($AnimationHandler, "animation_finished")
	
	$AbordagemControl/NPC1/AnimatedSprite.flip_h = false
	$AbordagemControl/NPC1/AnimatedSprite.playing = false
	$AbordagemControl/NPC1/AnimatedSprite.frame = 0
	
	# Espera um curto período antes de permitir que o jogador se mova novamente
	yield(get_tree().create_timer(0.1), "timeout")
	Global.canMove = true
	
	# Define a primeira tarefa como ativa e define sua posição e descrição
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $Task1ADM/ComputadorAncora.global_position
	Global.activeObjective[2] = "Comece a trabalhar em seu computador."
	
	# Atualiza o objetivo do jogador
	$Player.objective(true)
	
	# Torna o botão do elevador visível
	$map/Elevador/TextureButton.visible = true
