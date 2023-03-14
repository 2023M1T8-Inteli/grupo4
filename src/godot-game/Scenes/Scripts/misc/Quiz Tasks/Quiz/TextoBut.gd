# O CÓDIGO ABAIXO NÃO ESTA COMENTADO, POIS NÃO ESTA IMPLEMENTADO NO JOGO AINDA E ESTEVE SERVINDO SOMENTE PARA TESTAGEM
extends TextureButton

func _on_TextoBut_pressed():
	if str(str(Global.correctBoxQuiz).get_slice(":", 0)) == str(self.get_parent()).get_slice(":", 0):
		Global.correctBoxQuiz.bbcode_text = "[color=#d3fe73]"+self.get_parent().text+"[/color]"
		Global.correctAnswerQuiz = true
	else:
		self.get_parent().bbcode_text = "[color=#FF7085]"+self.get_parent().text+"[/color]"
