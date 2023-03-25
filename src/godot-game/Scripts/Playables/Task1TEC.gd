extends Control

# Nomeia variaveis de nodes pais para facilitar o codigo
onready var pai = get_parent()
onready var player = get_parent().get_node("Player")

func _process(_delta):
	# Se a janela de diálogo estiver visível
	if $"DialogBox 20".visible == true:
		# Define se a câmera deve seguir o NPC ou não, dependendo de quem está falando
		player.get_node("Camera2D").current = false if $"DialogBox 20/TexturaCaixa/NomeNPC".bbcode_text != "Joao" else true
		$Camera2D.current = true if $"DialogBox 20/TexturaCaixa/NomeNPC".bbcode_text != "Joao" else false

# Quando o jogador colide com a área delimitada por um NPC
func _on_Area2D_body_entered(body):
	# Se o objeto que entrou em colisão for o jogador
	if str(body).get_slice(":", 0) == "Player":
		# Define a primeira tarefa como não ativa
		Global.activeObjective[0] = false
		
		# Esconde os balões de fala dos NPCs
		$NPCs/ColorRect/BalaoExclamacao.visible = false
		$NPCs/ColorRect2/BalaoExclamacao.visible = false
		$NPCs/ColorRect3/BalaoExclamacao.visible = false
		
		# Impede que o jogador se mova
		Global.canMove = false
		
		# Armazena a posição e o zoom atual da câmera do jogador
		var playerCameraZoom = player.get_node("Camera2D").get_zoom()
		var playerCameraPos = player.get_node("Camera2D").get_global_position()
		
		# Desativa a câmera do jogador e ativa a câmera da task
		player.get_node("Camera2D").current = false
		$Camera2D.current = true
		
		# Define os valores da animação de movimentação da câmera
		$AnimationPlayer.get_animation("cameraMove").track_set_key_value(0, 0, playerCameraZoom)
		$AnimationPlayer.get_animation("cameraMove").track_set_key_value(1, 0, playerCameraPos)
		
		# Toca a animação de movimentação da câmera
		$AnimationPlayer.play("cameraMove")
		
		# Espera até que a animação termine
		yield($AnimationPlayer, "animation_finished")
		
		# Define o novo zoom da câmera do jogador
		player.get_node("Camera2D").zoom = Vector2(0.6, 0.6)
		
		# Conecta o sinal de término da janela de diálogo
		if $"DialogBox 20/TexturaCaixa".connect("finish", self, "on_dialog1_finish") != OK:
			print("ERRO AO CONECTAR")
		
		# Torna a janela de diálogo visível e inicia a animação de texto
		$"DialogBox 20".visible = true
		player.get_node("Camera2D").set_enable_follow_smoothing(false)
		$"DialogBox 20/TexturaCaixa"._startDialog()
		
func on_dialog1_finish():
	# Reduzir o zoom da câmera para mostrar a cena completa
	player.get_node("Camera2D").zoom = Vector2(1, 1)
	
	# Obter o zoom e a posição atual da câmera do jogador
	var playerCameraZoom = player.get_node("Camera2D").get_zoom()
	var playerCameraPos = player.get_node("Camera2D").get_global_position()
	
	# Configurar as chaves da animação de movimento da câmera
	# A primeira chave é para o zoom, a segunda para a posição
	# O tempo da primeira chave é 0, e da segunda chave é 1
	$AnimationPlayer.get_animation("cameraMoveBack").track_set_key_value(0, 1, playerCameraZoom)
	$AnimationPlayer.get_animation("cameraMoveBack").track_set_key_value(1, 1, playerCameraPos)
	
	# Executar a animação de movimento da câmera
	$AnimationPlayer.play("cameraMoveBack")
	
	# Esperar até que a animação termine
	yield($AnimationPlayer, "animation_finished")
	
	# Conectar o sinal "quizFinish" do QuizTask com o método "_on_quiz_finish" deste script
	# Se a conexão não for bem sucedida, imprimir uma mensagem de erro
	if $QuizTask.connect("quizFinish", self, "_on_quiz_finish") != OK:
		print("ERRO AO CONECTAR")
	
	# Exibir o QuizTask e iniciar o quiz
	$QuizTask.visible = true
	$QuizTask._startQuiz()
	
	# Esconder a DialogBox 20
	$"DialogBox 20".visible = false
	
	# Habilitar o suavizador de movimento da câmera do jogador
	player.get_node("Camera2D").set_enable_follow_smoothing(true)

func _on_quiz_finish():
	# Executar a animação de movimento da câmera em reverso
	$AnimationPlayer.play_backwards("cameraMoveBack")
	
	# Esperar até que a animação termine
	yield($AnimationPlayer, "animation_finished")
	
	# Conectar o sinal "finish" da TexturaCaixa da DialogBox 21 com o método "on_dialog2_finish" deste script
	# Se a conexão não for bem sucedida, imprimir uma mensagem de erro
	if $"DialogBox 21/TexturaCaixa".connect("finish", self, "on_dialog2_finish") != OK:
		print("ERRO AO CONECTAR")
	
	# Exibir a DialogBox 21 e iniciar o diálogo
	$"DialogBox 21".visible = true
	$"DialogBox 21/TexturaCaixa"._startDialog()

func on_dialog2_finish():
	$AnimationPlayer.play_backwards("cameraMove") # Inicia a animação da câmera para retornar à posição anterior
	yield($AnimationPlayer, "animation_finished") # Aguarda a finalização da animação
	
	Global.canMove = true # Define que o jogador pode se mover
	
	player.get_node("Camera2D").current = true # Define a câmera do jogador como a câmera atual
	$Camera2D.current = false # Define a câmera anterior como não sendo a atual
	
	TecGlobals.currentTask = 2 # Define a tarefa atual como a segunda tarefa
	get_parent().get_node("Task2TEC").visible = true # Torna a segunda tarefa visível
	
	$Area2D/CollisionShape2D.disabled = true # Desabilita o colisor do jogador
	
	Global.activeObjective[0] = true # Define o primeiro objetivo como ativo
	Global.activeObjective[1] = self.get_parent().get_node("Task2TEC/Position2D").global_position # Define a posição do segundo objetivo
	Global.activeObjective[2] = "Entre na van de transporte." # Define o texto do segundo objetivo
	self.get_parent().get_node("Player").objective(true) # Renderiza o objetivo como ativo para o jogador
