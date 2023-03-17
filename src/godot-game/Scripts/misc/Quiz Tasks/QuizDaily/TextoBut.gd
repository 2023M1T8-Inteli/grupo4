# O CÓDIGO ABAIXO NÃO ESTA COMENTADO, POIS NÃO ESTA IMPLEMENTADO NO JOGO AINDA E ESTEVE SERVINDO SOMENTE PARA TESTAGEM
extends TextureButton

signal answeredQuiz

func _ready():
	if self.connect("answeredQuiz", (self.get_parent().get_parent().get_parent().get_parent()), "_answered_quiz") != OK:
		print("ERRO ANSWEREDQUIZ CONNECT")
		
func _on_TextoBut_pressed():
	if str(str(Global.correctBoxQuiz).get_slice(":", 0)) == str(self.get_parent()).get_slice(":", 0):
		Global.correctBoxQuiz.bbcode_text = "[center][color=#d3fe73]"+self.get_parent().text+"[/color][/center]"
		print("signal emit")
		emit_signal("answeredQuiz")
		Global.quizAnswered = true
	else:
		self.get_parent().bbcode_text = "[center][color=#FF7085]"+self.get_parent().text+"[/color][/center]"
