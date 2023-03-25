extends Control

func _ready():
	# Verifica se foi possível conectar o sinal "quizFinish" ao método "_on_quiz_finish"
	if $QuizTask.connect("quizFinish", self, "_on_quiz_finish") != OK:
		print("ERRO AO CONECTAR")

# Método chamado quando o botão "BotaoComputador" é pressionado
func _on_BotaoComputador_pressed():
	# Verifica se o jogador está perto do objeto "ComputadorAncora"
	if (self.get_parent().get_node("Player").global_position).distance_to($ComputadorAncora.global_position) < 150:
		# Esconde o balão de fala do personagem
		$BalaoObj.visible = false
		
		# Define que o primeiro objetivo não está mais ativo
		Global.activeObjective[0] = false
		
		# Impede que o jogador se movimente
		Global.canMove = false
		
		# Espera 0.05 segundos antes de continuar a execução do código
		yield(get_tree().create_timer(0.05), "timeout")
		
		# Esconde o botão do computador
		$BotaoComputador.visible = false
		
		# Define o próximo objetivo como a posição da porta "PortaAncora" e uma mensagem para o jogador
		Global.activeObjective[1] = self.get_parent().get_node("PortaAncora").global_position
		Global.activeObjective[2] = "Vá para o setor Executivo."
		
		# Permite que o jogador vá para o setor Executivo
		AdmGlobals.canGo = true
		
		# Esconde a GUI do jogo
		get_parent().get_node("GUI").visible = false
		
		# Mostra a tela do computador e espera 2 segundos antes de mostrar o conteúdo
		$TelaComputador.visible = true
		yield(get_tree().create_timer(2), "timeout")
		$TelaComputador/LinkedIn.visible = true
		yield(get_tree().create_timer(2), "timeout")
		$TelaComputador/Comentarios.visible = true
		
		# Espera 5 segundos antes de mostrar o Quiz
		yield(get_tree().create_timer(5), "timeout")
		
		# Mostra o Quiz e inicia a sua execução
		$QuizTask.visible = true
		$QuizTask._startQuiz()

# Método chamado quando o Quiz é finalizado
func _on_quiz_finish():
	# Define que o primeiro objetivo está ativo novamente e espera 0.5 segundos antes de continuar a execução do código
	Global.activeObjective[0] = true
	yield(get_tree().create_timer(0.5), "timeout")
	
	# Permite que o jogador se movimente novamente e mostra a GUI do jogo
	Global.canMove = true
	$TelaComputador.visible = false
	get_parent().get_node("GUI").visible = true
	
	# Define que a tarefa atual é a 2 e mostra o botão para ir ao elevador
	AdmGlobals.currentTask = 2
	self.get_parent().get_node("map/Elevador/TextureButton").visible = true
	
	# Define o objetivo do jogador como verdadeiro
	self.get_parent().get_node("Player").objective(true)
