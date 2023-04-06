extends Control

# Método _ready é chamado quando o nó é carregado
func _ready():
	# Conecta o sinal quizFinish emitido pelo nó QuizTask ao método _on_quiz_finish
	if $QuizTask.connect("quizFinish", self, "_on_quiz_finish") != OK:
		print("ERRO AO CONECTAR")
	# Conecta o sinal finish emitido pelo nó TexturaCaixa ao método _finish_dialog
	if $"DialogBox 18/TexturaCaixa".connect("finish", self, "_finish_dialog") != OK:
		print("ERRO AO CONECTAR")

# Método que anima o preenchimento da barra de progresso
func animate():
	# Interpola a propriedade "value" do nó TextureProgress de 0 para 100 em 1 segundo,
	# usando a interpolação linear e a transição ease-out
	$Tween.interpolate_property($TextureProgress, "value", 0, 100, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	# Inicia a animação
	$Tween.start()

# Método chamado quando o botão BotaoObj é pressionado
func _on_BotaoObj_pressed():
	# Verifica se o jogador está próximo ao nó ComputadorAncora
	if (self.get_parent().get_node("Player").global_position).distance_to($ComputadorAncora.global_position) < 150:
		# Define que o objetivo não está mais ativo e que o jogador não pode se mover
		Global.activeObjective[0] = false
		Global.canMove = false
		# Inicia a animação
		animate()
		# Espera 1 segundo antes de continuar
		yield(get_tree().create_timer(1), "timeout")
		# Define que o jogador pode se mover novamente e esconde a barra de progresso, o balão e o botão de objetivo
		Global.canMove = true
		$TextureProgress.visible = false
		$BalaoObj.visible = false
		$BotaoObj.visible = false
		# Espera 0.2 segundos antes de continuar
		yield(get_tree().create_timer(0.2), "timeout")
		# Define que o objetivo voltou a ser ativo e atualiza a posição e descrição do objetivo
		Global.activeObjective[0] = true
		Global.activeObjective[1] = get_parent().get_node("PortaAncora").global_position
		Global.activeObjective[2] = "Saia do prédio."
		# Ativa o objetivo no nó Player e atualiza a tarefa atual
		get_parent().get_node("Player").objective(true)
		AdmGlobals.currentTask = 4


func _on_Area2D_body_entered(body):
	# Verifica se o corpo que entrou no trigger é o Player e se a tarefa atual é 3
	if str(body).get_slice(":", 0) == "Player" and AdmGlobals.currentTask == 4:
		# Define a variável Global.canMove como falso para impedir que o jogador se mova
		Global.canMove = false

		# Espera 0.2 segundos antes de continuar
		yield(get_tree().create_timer(0.2), "timeout")

		# Define a primeira tarefa como inativa
		Global.activeObjective[0] = false

		# Configura a animação de abordagem para iniciar na posição atual do NPC e no x do jogador -106, e toca a animação
		get_parent().get_node("AnimationHandler").get_animation("AbordagemAnim").track_set_key_value(0, 0, Vector2(470, 160))
		get_parent().get_node("AnimationHandler").get_animation("AbordagemAnim").track_set_key_value(0, 1, Vector2(get_parent().get_node("Player").position.x-106, 160))
		get_parent().get_node("AnimationHandler").play("AbordagemAnim")
		# Espera até que a animação termine antes de continuar
		yield(get_parent().get_node("AnimationHandler"), "animation_finished")
		
		get_parent().get_node("AbordagemControl/NPC1/AnimatedSprite").animation = "down"
		get_parent().get_node("AbordagemControl/NPC1/AnimatedSprite").playing = false
		get_parent().get_node("AbordagemControl/NPC1/AnimatedSprite").frame = 0

		# Torna a janela de diálogo visível e inicia o diálogo
		$"DialogBox 18".visible = true
		$"DialogBox 18/TexturaCaixa"._startDialog()

		# Desativa as colisões dos shapes do trigger
		$Area2D/CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D2.disabled = true


func _finish_dialog():
	# Torna a janela de quiz visível e inicia o quiz
	$QuizTask.visible = true
	$QuizTask._startQuiz()


func _on_quiz_finish():
	# Configura a animação de abordagem para iniciar no x do jogador -106 e na posição atual do NPC, e toca a animação
	get_parent().get_node("AnimationHandler").get_animation("AbordagemAnim").track_set_key_value(0, 0, Vector2(get_parent().get_node("Player").position.x-106, 160))
	get_parent().get_node("AnimationHandler").get_animation("AbordagemAnim").track_set_key_value(0, 1, Vector2(470, 160))
	get_parent().get_node("AnimationHandler").play("AbordagemAnim")
	# Espera até que a animação termine antes de continuar
	
	get_parent().get_node("AbordagemControl/NPC1/AnimatedSprite").playing = true
	get_parent().get_node("AbordagemControl/NPC1/AnimatedSprite").animation = "horizontal"
	get_parent().get_node("AbordagemControl/NPC1/AnimatedSprite").flip_h = true
	yield(get_parent().get_node("AnimationHandler"), "animation_finished")
	
	get_parent().get_node("AbordagemControl/NPC1/AnimatedSprite").playing = false
	get_parent().get_node("AbordagemControl/NPC1/AnimatedSprite").frame = 0
	get_parent().get_node("AbordagemControl/NPC1/AnimatedSprite").flip_h = false
	
	# Define a variável Global.canMove como verdadeiro para permitir que o jogador se mova novamente
	Global.canMove = true

	# Define a primeira tarefa como ativa novamente, define a terceira tarefa e permite que o jogador vá para o setor executivo
	Global.activeObjective[0] = true
	Global.activeObjective[2] = "No seu celular, acesse o app do eMail"
	Global.celularComplianceTask = 1
	get_parent().get_node("GUI").shake_phone_icon(true)
	Global.currentApp = "email"
	get_parent().get_node("Player").objective(false)
	get_parent().get_node("GUI").connect("finishedCompliance2", self, "on_task_finish")

	# Torna o próprio nó invisível
	self.visible = false

func on_task_finish():
	Global.activeObjective[0] = true
	Global.activeObjective[2] = "Saia do prédio."
	get_parent().get_node("Player").objective(false)
	AdmGlobals.currentTask = 5
	
