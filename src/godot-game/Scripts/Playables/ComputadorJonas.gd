extends Control

func _ready():
	# Verifica se foi possível conectar o sinal "quizFinish" ao método "_on_quiz_finish" do objeto $QuizTask
	if $QuizTask.connect("quizFinish", self, "_on_quiz_finish") != OK:
		print("ERRO AO CONECTAR")

func _on_BotaoComputador_pressed():
	# Verifica se o jogador está próximo o suficiente do computador para usá-lo
	if (self.get_parent().get_node("Player").global_position).distance_to($ComputadorAncora.global_position) < 150:
		# Desativa o objetivo anterior e impede o movimento do jogador
		Global.activeObjective[0] = false
		Global.canMove = false
		# Pausa a execução por um curto período de tempo para dar tempo das animações ocorrerem
		yield(get_tree().create_timer(0.05), "timeout")

		# Esconde o botão do computador e a GUI principal do jogo
		$BotaoComputador.visible = false
		get_parent().get_node("GUI").visible = false

		# Define um novo objetivo para o jogador e habilita a movimentação entre setores
		Global.activeObjective[1] = self.get_parent().get_node("PortaAncora").global_position
		Global.activeObjective[2] = "Vá para o setor Executivo."
		AdmGlobals.canGo = true

		# Mostra a tela do computador e a animação do ataque hacker
		$TelaComputador.visible = true
		yield(get_tree().create_timer(1), "timeout")
		$TelaComputador/AtaqueHacker.visible = true
		
		get_parent().get_node("Audio").set_playback_pos("res://Audio Files/AtaqueHacker.mp3" , 0)
		yield(get_tree().create_timer(2.3), "timeout")
		get_parent().get_node("Audio").stop()
		
		# Pausa a execução por um curto período de tempo para dar tempo das animações ocorrerem
		yield(get_tree().create_timer(5), "timeout")

		# Inicia o mini-jogo de quiz e esconde o balão de objetivo
		$QuizTask.visible = true
		$QuizTask._startQuiz()
		$BalaoObj.visible = false

func _on_quiz_finish():
	# Ativa o objetivo anterior e permite o movimento do jogador
	Global.activeObjective[0] = true
	yield(get_tree().create_timer(0.5), "timeout")
	Global.canMove = true

	# Esconde a tela do computador e a animação do ataque hacker
	$TelaComputador.visible = false
	$TelaComputador/AtaqueHacker.visible = false

	# Atualiza o objeto em que o jogador deve interagir e exibe a GUI principal do jogo
	AdmGlobals.currentTask = 1
	self.get_parent().get_node("Player").objective(true)
	get_parent().get_node("GUI").visible = true
