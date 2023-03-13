# O CÓDIGO ABAIXO NÃO ESTA COMENTADO, POIS NÃO ESTA IMPLEMENTADO NO JOGO AINDA E ESTEVE SERVINDO SOMENTE PARA TESTAGEM

extends TextureButton


func _on_TextoBut_pressed():
	print(str(self.get_parent()).get_slice(":", 0))
	if str(str(Global.correctBoxQuiz1).get_slice(":", 0)) == str(self.get_parent()).get_slice(":", 0):
		Global.correctBoxQuiz1.bbcode_text = "[color=#d3fe73]Sair do elevador e contactar a equipe de compliance imediatamente.[/color]"
		Global.correctAnswerQuiz1 = true
