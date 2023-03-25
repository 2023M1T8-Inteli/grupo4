extends CanvasLayer

func _reset():
	$DialogBox/TexturaCaixa.phraseNum = 0  # Reseta o número de frases da caixa de diálogo para 0
	$DialogBox/TexturaCaixa.finished = false  # Reseta a flag de finalização da caixa de diálogo para false
	$DialogBox/TexturaCaixa.deadbolt = true  # Reseta a flag de "deadbolt" da caixa de diálogo para true
	self.visible = true  # Torna a tela visível
	
	$Opcoes.phraseNum = 0  # Reseta o número de frases de opções para 0
	
	$DialogBox/TexturaCaixa.visible = false  # Torna a caixa de diálogo invisível
	$Opcoes.visible = false  # Torna a tela de opções invisível
	$Opcoes/MouseFilter.visible = false  # Torna o filtro de mouse das opções invisível
	
	Global.quizAnswered = false  # Reseta a flag de resposta do quiz globalmente
	
	$Opcoes.dialog = []  # Limpa o vetor de diálogos das opções
	$Opcoes.questions = []  # Limpa o vetor de questões das opções
	
	$Filter.visible = true  # Torna o filtro visível

func _startQuiz():
	if $DialogBox/TexturaCaixa.connect("finishDialog", self, "_on_TexturaCaixa_finish") != OK:
		print ("Ocorreu um erro inesperado ao tentar conectar finishDialog")
	$DialogBox/TexturaCaixa.jumpStartQuiz()  # Começa o quiz pulando as frases anteriores
	$DialogBox/TexturaCaixa.visible = true  # Torna a caixa de diálogo visível
	if $DialogBox/TexturaCaixa.connect("quizCorrect", self, "_finish_quiz"):
		print("ERRO CONNECT QUIZCORRECT")  # Mostra uma mensagem de erro caso ocorra um erro de conexão com quizCorrect

func _on_TexturaCaixa_finish():
	$DialogBox.visible = false  # Torna a caixa de diálogo invisível
	$Opcoes.visible = true  # Torna a tela de opções visível
	$Opcoes.startQuiz()  # Começa o quiz

func _answered_quiz():
	yield(get_tree().create_timer(1.2), "timeout")  # Espera 1.2 segundos
	$Opcoes.visible = false  # Torna a tela de opções invisível
	$DialogBox.visible = true  # Torna a caixa de diálogo visível
	
func _finish_quiz():
	print("FINALIZANDO QUIZ")
	self.visible = false  # Torna a tela invisível
	$DialogBox/TexturaCaixa.visible = false  # Torna a caixa de diálogo invisível
