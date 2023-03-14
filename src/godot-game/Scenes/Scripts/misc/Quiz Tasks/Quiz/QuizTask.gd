# O CÓDIGO ABAIXO NÃO ESTÁ COMENTADO, POIS NÃO ESTA IMPLEMENTADO NO JOGO AINDA E ESTEVE SERVINDO SOMENTE PARA TESTAGEM

extends CanvasLayer

func _ready():
	if $DialogBox/TexturaCaixa.connect("finish", self, "_on_TexturaCaixa_finish") != OK:
		print ("An unexpected error occured when trying to switch to the scene")
	Global.jumpStartQuiz = true
	
func _on_TexturaCaixa_finish():
	$DialogBox.visible = false
	$Opcoes.visible = true
	Global.startQuiz = true

func _process(_delta):
	if Global.correctAnswerQuiz == true:
		yield(get_tree().create_timer(2), "timeout")
		#$DialogBox/TexturaCaixa.jumpStart(2,2)
		$Opcoes.visible = false
		$DialogBox.visible = true
		
