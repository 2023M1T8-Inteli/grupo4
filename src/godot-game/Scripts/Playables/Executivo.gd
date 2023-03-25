extends Node2D

# Variáveis para referenciar a câmera, o mapa e seus limites
onready var camera: Camera2D = get_node("Player/Camera2D")
onready var map = get_node("map")
onready var children = map.get_children()  # Não é necessário chamar get_node novamente, já que 'map' já foi declarado
var map_width = 0
var map_height = 0

# Variáveis para o controle de posição do jogador e para a interação com a porta
var close_to_porta = false  # Renomeei para close_to_porta para seguir as convenções do Python
var updateTimer = false
var playerSavePos

func _ready():
	# Se o jogador estiver em uma reunião, define que o primeiro objetivo está ativo e qual é a posição do objeto 'ADM' (representa a entrada do prédio)
	if ExecutivoGlobals.reuniao:
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $ReuniaoAncora.global_position
		Global.activeObjective[2] = "Vá para a reunião!"
		$Player.objective(true)
		$NPCQuiz1.visible = false
		
		$GUI/Audio.set_volume(Global.volPercentage)
		$GUI/Audio.play_ambient("res://Audio Files/OfficeAmbiente.mp3")
	
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
	camera.zoom = Vector2(0.5, 0.5)
	set_process(true)
	
	# Obtém a largura e altura do mapa somando as larguras e alturas dos filhos de 'map'
	for child in children:
		map_width += child.rect_size.x
		map_height += child.rect_size.y

func _process(_delta):
	# Define os limites da câmera para o tamanho do mapa
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = map_width
	camera.limit_bottom = map_height
	
	# Verifica se o jogador está próximo da porta de interação
	if $Player/HitBox.global_position.distance_to($PortaAncora.global_position) < 40:
		close_to_porta = true
	else:
		close_to_porta = false
	
	# Verifica se o temporizador está ativado e atualiza o texto da tela com o tempo restante
	if updateTimer:
		$ControlQuiz2/CanvasLayer/RichTextLabel.bbcode_text = "[center]"+str(int($ControlQuiz2/Timer.time_left))+"[/center]"

# Função chamada quando o botão é pressionado
func _on_TextureButton_pressed():
	# Verifica se o jogador está perto da porta
	if close_to_porta:
		# Impede o movimento do jogador durante a transição de cena
		Global.canMove = false
		# Aguarda um curto período antes de mudar de cena, para que a animação da porta seja executada
		yield(get_tree().create_timer(0.15), "timeout")
		# Tenta mudar para a cena "Cidade.tscn", exibindo uma mensagem de erro em caso de falha		
		if get_tree().change_scene("res://Scenes/Playables/Environment/Cidade.tscn") != OK:
			print("ERRO")

# Função chamada quando a animação de entrada do jogador termina
func _on_WalkInPlayer_animation_finished(_anim_name):
	# Define a variável Global.moving (que controla a animação de andar) como false
	Global.moving = false

# LIDAR COM A ANIMACAO INGAME DE REUNIAO
func _reuniao_anim():
	Global.canMove = false # Impede o movimento do jogador durante a animação
	$Player/Camera2D.current = false # Desativa a camera do player
	$GUI.visible = false # Esconde a GUI (interface do usuário) durante a animação
	Global.activeObjective[0] = false # Define que o objetivo atual não está mais ativo
	
	# Define a posição da câmera de animação como a mesma do jogador
	$ReuniaoAncora/ReuniaoAnim/Camera2D.global_position = $Player/Camera2D.global_position
	
	$ReuniaoAncora/ReuniaoAnim/Camera2D.current = true # Define a câmera de animação como ativa
	$ReuniaoAncora/ReuniaoAnim.play("CameraZoomIn") # Inicia a animação de zoom da câmera
	yield($ReuniaoAncora/ReuniaoAnim, 'animation_finished') # Aguarda o término da animação de zoom
	
	# Define a posição inicial da animação de sobrevoo da câmera
	$ReuniaoAncora/ReuniaoAnim.get_animation("CameraFlyOver").track_set_key_value(0, 0, $Player/Camera2D.global_position)
	$ReuniaoAncora/ReuniaoAnim.play("CameraFlyOver") # Inicia a animação de sobrevoo da câmera
	yield($ReuniaoAncora/ReuniaoAnim, 'animation_finished') # Aguarda o término da animação de sobrevoo
	
	# Inicia a caixa de diálogo
	$"ReuniaoAncora/ReuniaoAnim/DialogBox 2".visible = true
	$"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa"._startDialog()
	yield($"ReuniaoAncora/ReuniaoAnim/DialogBox 2/TexturaCaixa", "finish") # Aguarda o término do dialogo
	
	# Redefine a velocidade da animação
	$ReuniaoAncora/ReuniaoAnim.playback_speed = 1
	
	# Inicia a animação de zoom da câmera inversa
	$ReuniaoAncora/ReuniaoAnim.play_backwards("CameraZoomIn")
	yield($ReuniaoAncora/ReuniaoAnim, 'animation_finished') # Aguarda o término da animação de zoom
	
	# Reativa a camera do player, o GUI e o movimento do player
	$ReuniaoAncora/ReuniaoAnim/Camera2D.current = false
	$GUI.visible = true
	$Player/Camera2D.current = true
	Global.canMove = true
	
	# Inicia a proxima task, renderizando o NPC como visivel e definindo o objetivo
	$NPCQuiz1.visible = true
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $NPCQuiz1/AncoraQuiz1.global_position
	Global.activeObjective[2] = "Fale com o seu \n colega."
	
	# Renderiza o objetivo na tela
	$Player.objective(false)
	
# LIDAR COM A ANIMACAO/ABORDAGEM DO ASSEDIO
func _assedio_anim():
	# Define como visivel o ColorRect que controla o assedio e a textura do assediador
	$ControlAssedio/ColorRect.visible = true
	
	# Desativa o movimento do player e seu objetivo
	Global.canMove = false
	Global.activeObjective[0] = false
	
	# Define a posição global da câmera para a posição global da câmera do jogador e ativa a camera da task de assedio
	$ControlAssedio/Camera2D.global_position = $Player/Camera2D.global_position
	$ControlAssedio/Camera2D.current = true
	$Player/Camera2D.current = false
	
	# Pega a posição do sprite do jogador e inicia a animação de caminhada do assediador
	$ControlAssedio/AnimationPlayer.get_animation("WalkUp").track_set_key_value(0, 1, Vector2($Player.position.x, 208))
	$ControlAssedio/AnimationPlayer.get_animation("WalkUpBackwards").track_set_key_value(0, 0, Vector2($Player.position.x, 208))
	$ControlAssedio/AnimationPlayer.play("WalkUp")
	yield($ControlAssedio/AnimationPlayer, "animation_finished")
	
	# Torna o assediador olhando para o lado invisível, posiciona o assediador olhando pra cima na posicao do outro e torna-o visivel,
	# dando a impressao de que o assediador virou-se para o jogador
	$ControlAssedio/ColorRect.visible = false
	$ControlAssedio/AssediadorCima.position = $ControlAssedio/ColorRect.position
	$ControlAssedio/AssediadorCima.visible = true
	
	# Torna visível uma caixa de diálogo e inicia o evento de diálogo
	$"ControlAssedio/DialogBox 12".visible = true
	$"ControlAssedio/DialogBox 12/TexturaCaixa"._startDialog()
	
	# Aguarda o término do evento de diálogo
	yield($"ControlAssedio/DialogBox 12/TexturaCaixa", "finish")
	
	# Remove o assediador olhando pra cima e torna o outro visivel
	$ControlAssedio/AssediadorCima.queue_free()
	$ControlAssedio/ColorRect.visible = true
	
	# Inverte a direção do sprite do assediador e inicia a animação de caminhada para baixo até a posição original
	$ControlAssedio/ColorRect.flip_h = true
	$ControlAssedio/AnimationPlayer.play_backwards("WalkUp")
	yield($ControlAssedio/AnimationPlayer, "animation_finished")
	
	# Torna o assediador invisível e ativa parte da "Task 1.1" (Eq. de Compliance)
	$ControlAssedio/ColorRect.visible = false
	$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/BalaoExclamacao".visible = true
	$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/NPCBomBotao".visible = true
	
	# Torna a câmera do jogador ativa e desativa a câmera da área de cerco, além de permitir que o jogador se mova novamente
	$Player/Camera2D.current = true
	$ControlAssedio/Camera2D.current = false
	$Assedio/CollisionShape2D.disabled = true
	Global.canMove = true
	
	# Define o proximo objetivo do jogador
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $"ControlAssedio/Eq Compliance/NPC2 (O BOM)/NPCBomAncora".global_position
	Global.activeObjective[2] = "Fale com a equipe de Compliance!"
	
	# Renderiza o objetivo na tela
	$Player.objective(true)

# LIDAR COM O QUIZ #1
func _on_Quiz1Button_pressed():
	Global.activeObjective[0] = false # Define a primeira missão como inativa
	$NPCQuiz1/BalaoExclamacao.visible = false # Esconde o balão de exclamação do NPC
	$NPCQuiz1/Quiz1Button.visible = false # Esconde o botão de início de quiz do NPC
	$NPCQuiz1/QuizTask.visible = true # Mostra a tarefa do quiz do NPC
	$NPCQuiz1/QuizTask._startQuiz() # Inicia o quiz do NPC
	Global.canMove = false # Desativa a movimentação do jogador
	
	# Conecta a função de finalização do quiz com o sinal de acerto do mesmo
	if $NPCQuiz1/QuizTask/DialogBox/TexturaCaixa.connect("quizCorrect", self, "_finish_quiz1") != OK:
		print("ERROR ON QUIZCORRECT CONNECT")

func _finish_quiz1():
	yield(get_tree().create_timer(0.5), "timeout") # Aguarda um curto período de tempo
	Global.canMove = true # Reativa a movimentação do jogador
	# Define o proximo objetivo do player
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $ControlQuiz2/Quiz2Ancora.global_position
	Global.activeObjective[2] = "Fale com seus \n colegas."
	
	$NPCQuiz1/QuizTask.visible = false # Esconde a tarefa do quiz do NPC
	$NPCQuiz1/QuizTask/DialogBox.visible = false # Esconde a caixa de diálogo da tarefa do quiz do NPC
	
	# Renderiza o objetivo na tela do player
	$Player.objective(false)
	
	# Ativa as caixas de colisao do Assedio e do Quiz2 (para detectar a entrada do player)
	$Assedio/CollisionShape2D.disabled = false
	$Quiz2/CollisionShape2D.disabled = false

# LIDAR COM O QUIZ #2
func _on_Area2D_body_entered(body):
	if body == $Player:
		playerSavePos = $Player.global_position # Salva a posição atual do jogador
		
		$ControlQuiz2/QuizTask.visible = true # Mostra a tarefa do quiz do segundo NPC
		$ControlQuiz2/QuizTask._startQuiz() # Inicia o quiz do segundo NPC
		
		Global.canMove = false # Define a possibilidade de movimentação do jogador como falsa
		Global.activeObjective[0] = false # Define a primeira missão como inativa
		$ControlQuiz2/BaloesExclamacao.visible = false # Esconde o balão de exclamação do NPC
		
		# Conecta a função de finalização do quiz com o sinal de acerto do mesmo
		if $ControlQuiz2/QuizTask/DialogBox/TexturaCaixa.connect("quizCorrect", self, "_finish_quiz2") != OK:
			print("ERROR ON QUIZCORRECT CONNECT")

# Esta função é chamada quando o quiz 2 é concluído.
func _finish_quiz2():
	yield(get_tree().create_timer(0.5), "timeout") # Espera um pouquinho antes de iniciar a funcao
	Global.canMove = true # Desativa a movimentacao do player
	$Quiz2/CollisionShape2D.disabled = true # Desativa a caixa de colisao do Quiz2
	
	# Mostra a caixa de diálogo de conformidade de Eq
	$"ControlQuiz2/Eq Compliance".visible = true
	
	# Configura o objetivo atual do jogador
	Global.activeObjective[0] = true
	Global.activeObjective[1] = $"ControlQuiz2/Eq Compliance/NPCBomAncora".global_position
	Global.activeObjective[2] = "Fale com a equipe de Compliance."
	$Player.objective(true)
	
	yield(get_tree().create_timer(4), "timeout") # Espera a animacao de objetivo
	
	$ControlQuiz2/CanvasLayer.visible = true # Exibe o timer
	$ControlQuiz2/Timer.start() # Inicia o timer
	# Define como verdadeira a variavel que atualiza o display do timer e checa se o mesmo acabou para reiniciar o quiz2
	updateTimer = true

# Esta função é chamada quando o corpo Player entra na área de colisão da Reuniao.
func _on_Reuniao_body_entered(body):
	# Verifica se o corpo é o jogador e se a reunião ainda não aconteceu
	if body == $Player and ExecutivoGlobals.reuniao:
		ExecutivoGlobals.reuniao = false # Dita que a reuniao ja foi tocada
		pos.savePosCommand = true # Salva a posicao do Player
		yield(get_tree().create_timer(0.05), "timeout") # Espera um pouquinho
		_reuniao_anim() # Toca a animacao de reuniao

# Esta função é chamada quando o corpo Player entra na área de colisão do Assedio.
func _on_Assedio_body_entered(body):
	if body == $Player:
		# Inicia a animacao de assedio
		_assedio_anim()

# Esta função é chamada quando o botão "NPCBomBotao" é pressionado.
func _on_NPCBomBotao_pressed():
	# Verifica se o jogador está próximo o suficiente do NPCBom para iniciar o diálogo
	if $Player/HitBox.global_position.distance_to($"ControlAssedio/Eq Compliance/NPC2 (O BOM)/NPCBomAncora".global_position) < 50:
		# Define a variável global canMove como falsa, para impedir o jogador de se mover durante o diálogo
		Global.canMove = false
		# Define o objetivo como não ativo
		Global.activeObjective[0] = false
		# Torna a caixa de diálogo do NPCBom visível
		$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/DialogBox 13".visible = true
		# Inicia o diálogo da caixa de texto
		$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/DialogBox 13/TexturaCaixa"._startDialog()
		# Torna o botão do NPCBom invisível
		$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/NPCBomBotao".visible = false
		# Torna o balão de exclamação do NPCBom invisível
		$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/BalaoExclamacao".visible = false
		# Define a variável global canMove como verdadeira, permitindo que o jogador se mova novamente
		Global.canMove = true
		# Torna a caixa de diálogo do NPCBom invisível
		$"ControlAssedio/Eq Compliance/NPC2 (O BOM)/DialogBox 13".visible = false
		# Define o objetivo como ativo
		Global.activeObjective[0] = true
		# Define o objetivo com a posição da âncora do quiz2
		Global.activeObjective[1] = $ControlQuiz2/Quiz2Ancora.global_position
		# Define o objetivo com o texto "Fale com seus colegas."
		Global.activeObjective[2] = "Fale com seus \n colegas."
		# Torna o balão de exclamação do Quiz2 visível
		$ControlQuiz2/BaloesExclamacao.visible = true
		# Renderiza o objetivo na tela
		$Player.objective(false)

# Esta função é chamada quando o timer acaba
func _on_Timer_timeout():
	# Reinicia o quiz2
	_finish_quiz2_part2()

# Essa funcao serve para reiniciar o quiz2
func _finish_quiz2_part2():
	$ControlQuiz2/CanvasLayer.visible = false # Desativa, visualmente, o timer
	updateTimer = false # Desativa a funcao de checagem do timer
	Global.canMove = false # Desativa a movimentacao do player
	
	# Inicia, de modo neutro e compativel, o dialogo que precede o reinicio do quiz2
	$"ControlQuiz2/DialogBox 14".visible = true 
	$"ControlQuiz2/DialogBox 14/TexturaCaixa".phraseNum = 0
	$"ControlQuiz2/DialogBox 14/TexturaCaixa".dialog = null
	$"ControlQuiz2/DialogBox 14/TexturaCaixa".buttonPressed = null
	
	$"ControlQuiz2/DialogBox 14/TexturaCaixa"._startDialog()
	
	# Espera o dialogo acabar (+ 0.4 segundos)
	yield($"ControlQuiz2/DialogBox 14/TexturaCaixa", "finish")
	yield(get_tree().create_timer(0.4), "timeout")
	
	# Inicia uma animacao de flash antes de reiniciar o quiz
	$ControlQuiz2/CanvasLayer2.visible = true 
	$ControlQuiz2/AnimationPlayer.play("flash")
	yield($ControlQuiz2/AnimationPlayer, 'animation_finished')
	
	# Teleporta o player para a posicao salva quando o quiz foi iniciado
	$Player.global_position = playerSavePos
	
	# Reinicia o quiz, revertendo as variaveis para o seu estado padrao
	Global.quizAnswered = false
	$ControlQuiz2/QuizTask._reset()
	_on_Area2D_body_entered($Player)
	
	# Toca a animacao de flash ao inverso e esconde o canvaslayer2 que controla essa animacao
	$ControlQuiz2/AnimationPlayer.play_backwards("flash")
	yield($ControlQuiz2/AnimationPlayer, 'animation_finished')
	$ControlQuiz2/CanvasLayer2.visible = false

# Função que é chamada quando o botão do NPC para iniciar o quiz é pressionado
func _on_NPCCompQuiz2Botao_pressed():
	# Verifica se o jogador está próximo o suficiente do NPC para iniciar o dialogo
	if $Player/HitBox.global_position.distance_to($"ControlQuiz2/Eq Compliance/NPCBomAncora".global_position) < 50:
		# Esconde a tela do timer, para não ficar visível enquanto a conversa acontece
		$ControlQuiz2/CanvasLayer.visible = false
		# Para o timer do quiz
		$ControlQuiz2/Timer.stop()
		updateTimer = false
		# Impede que o jogador se mova enquanto estiver conversando
		Global.canMove = false
		# Desativa o objetivo atual do jogador, para evitar que ele interfira na conversa
		Global.activeObjective[0] = false
		# Mostra a caixa de diálogo do NPC
		$"ControlQuiz2/Eq Compliance/DialogBox 15".visible = true
		# Inicia a animação de texto na caixa de diálogo
		$"ControlQuiz2/Eq Compliance/DialogBox 15/TexturaCaixa"._startDialog()
		# Esconde o botão de iniciar o quiz
		$"ControlQuiz2/Eq Compliance/NPCCompQuiz2Botao".visible = false
		# Esconde o balão de exclamação acima do NPC
		$"ControlQuiz2/Eq Compliance/BalaoExclamacao".visible = false
		# Espera até que a animação de texto na caixa de diálogo termine
		yield($"ControlQuiz2/Eq Compliance/DialogBox 15/TexturaCaixa", "finish")
		# Permite que o jogador se mova novamente
		Global.canMove = true
		# Esconde a caixa de diálogo do NPC
		$"ControlQuiz2/Eq Compliance/DialogBox 15".visible = false
		# Define o novo objetivo do jogador
		Global.activeObjective[0] = true
		Global.activeObjective[1] = $PortaAncora.global_position
		Global.activeObjective[2] = "Saia do prédio."
		# Renderiza o objetivo na tela
		$Player.objective(false)
		
		# Aguarda 3 segundos antes de mudar para a próxima cena
		yield(get_tree().create_timer(3.0), "timeout")
		# Muda para a cena "Limbo2.tscn"
		SceneTransition.change_scene("res://Scenes/Playables/Environment/Limbo2.tscn", 1, 1)
