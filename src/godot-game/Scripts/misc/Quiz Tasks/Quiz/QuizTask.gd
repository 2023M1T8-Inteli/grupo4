extends CanvasLayer

func _ready():
	# Inicia o quiz
	#_startQuiz()
	pass
	
func _startQuiz():
	# Conecta o sinal "finishDialog" do diálogo da caixa de textura com a função "_on_TexturaCaixa_finish"
	if $DialogBox/TexturaCaixa.connect("finishDialog", self, "_on_TexturaCaixa_finish") != OK:
		# Caso haja um erro na conexão, exibe uma mensagem de erro
		print("Um erro inesperado ocorreu ao tentar conectar o sinal finishDialog")
	
	# Inicia o quiz na caixa de textura
	$DialogBox/TexturaCaixa.jumpStartQuiz()
	
	# Exibe a caixa de textura
	$DialogBox/TexturaCaixa.visible = true
	
	# Conecta o sinal "quizCorrect" da caixa de textura com a função "_finish_quiz"
	if $DialogBox/TexturaCaixa.connect("quizCorrect", self, "_finish_quiz") != OK:
		# Caso haja um erro na conexão, exibe uma mensagem de erro
		print("Um erro ocorreu ao tentar conectar o sinal quizCorrect")

func _on_TexturaCaixa_finish():
	# Quando o diálogo da caixa de textura terminar, esconde a caixa de diálogo e exibe as opções
	$DialogBox.visible = false
	$Opcoes.visible = true
	$Opcoes.startQuiz()

func _answered_quiz():
	# Espera 1.2 segundos antes de esconder as opções e exibir a caixa de diálogo novamente
	yield(get_tree().create_timer(1.2), "timeout")
	$Opcoes.visible = false
	$DialogBox.visible = true
	
func _finish_quiz():
	# Quando o quiz for finalizado, esconde o CanvasLayer e a caixa de diálogo e seta a variável global quizAnswered para false
	print("Finalizando o quiz")
	self.visible = false
	$DialogBox.visible = false	
	Global.quizAnswered = false
