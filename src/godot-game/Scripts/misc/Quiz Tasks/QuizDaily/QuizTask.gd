# O CÓDIGO ABAIXO NÃO ESTÁ COMENTADO, POIS NÃO ESTA IMPLEMENTADO NO JOGO AINDA E ESTEVE SERVINDO SOMENTE PARA TESTAGEM

extends CanvasLayer

signal quizFinish

func _ready():
	Global.quizAnswered = false
	#_startQuiz()
	pass

func _startQuiz():
	$Opcoes.startQuiz()

func _answered_quiz():
	yield(get_tree().create_timer(1.2), "timeout")
	print("FINISHING QUIZ")
	emit_signal("quizFinish")
	Global.quizAnswered = false
	self.queue_free()
