# O CÓDIGO ABAIXO NÃO ESTÁ COMENTADO, POIS NÃO ESTA IMPLEMENTADO NO JOGO AINDA E ESTEVE SERVINDO SOMENTE PARA TESTAGEM

extends CanvasLayer

func _ready():
	#_startQuiz()
	pass

func _startQuiz():
	if $DialogBox/TexturaCaixa.connect("finishDialog", self, "_on_TexturaCaixa_finish") != OK:
		print ("An unexpected error occured when trying to connect finishDialog")
	$DialogBox/TexturaCaixa.jumpStartQuiz()
	$DialogBox/TexturaCaixa.visible = true
	if $DialogBox/TexturaCaixa.connect("quizCorrect", self, "_finish_quiz"):
		print("ERRO CONNECT QUIZCORRECT")
func _on_TexturaCaixa_finish():
	$DialogBox.visible = false
	$Opcoes.visible = true
	$Opcoes.startQuiz()

func _answered_quiz():
	yield(get_tree().create_timer(1.2), "timeout")
	$Opcoes.visible = false
	$DialogBox.visible = true
	
func _finish_quiz():
	print("FINISHING QUIZ")
	self.visible = false
	$DialogBox/TexturaCaixa.visible = false
