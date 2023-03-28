extends CanvasLayer

# Sinal emitido quando o quiz é finalizado
signal quizFinish

func _reset():
	# Define que a resposta do quiz ainda não foi respondida
	Global.quizAnswered = false
	
	$Opcoes.visible = false

	$Opcoes.questions = []
	$Opcoes.phraseNum = 0

func _ready():
	# Define que a resposta do quiz ainda não foi respondida
	Global.quizAnswered = false
	
	# Inicia o quiz
	#_startQuiz()

func _startQuiz():
	# Chama a função "startQuiz" do nó filho "Opcoes"
	$Opcoes.startQuiz()

func _answered_quiz():
	# Aguarda 1.2 segundos
	yield(get_tree().create_timer(1.2), "timeout")
	
	# Imprime no console que o quiz está sendo finalizado
	print("FINALIZANDO QUIZ")
	
	# Emite o sinal "quizFinish"
	emit_signal("quizFinish")
	
	# Define que a resposta do quiz ainda não foi respondida
	Global.quizAnswered = false
	
	# Some
	self.visible = false
