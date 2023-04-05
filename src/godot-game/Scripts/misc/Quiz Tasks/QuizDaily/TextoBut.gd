extends TextureButton

# Sinal emitido quando o quiz é respondido
signal answeredQuiz

func _ready():
	# Tenta conectar o sinal "answeredQuiz" ao método "_answered_quiz" do nó pai do nó avô do nó avô do nó atual
	if self.connect("answeredQuiz", (self.get_parent().get_parent().get_parent().get_parent()), "_answered_quiz") != OK:
		# Imprime uma mensagem de erro caso não consiga conectar o sinal
		print("ERRO ANSWEREDQUIZ CONNECT")
		
func _on_TextoBut_pressed():
	# Verifica se o número da caixa clicada é igual ao número da caixa correta
	if str(str(Global.correctBoxQuiz).get_slice(":", 0)) == str(self.get_parent()).get_slice(":", 0):
		# Se a caixa clicada for a correta, seta o texto formatado da caixa como correto e emite o sinal "answeredQuiz"
		Global.correctBoxQuiz.bbcode_text = "[center][color=#d3fe73]"+self.get_parent().text+"[/color][/center]"
		emit_signal("answeredQuiz")
		# Define que o quiz foi respondido corretamente
		Global.quizAnswered = true
		
		get_parent().get_parent().get_parent().get_parent().get_node("Audio").set_playback_pos("res://Audio Files/QuizRight.mp3", 0)
		get_parent().get_parent().get_parent().get_parent().get_node("Audio").set_volume(Global.volPercentage)
		yield(get_tree().create_timer(2), "timeout")
		get_parent().get_parent().get_parent().get_parent().get_node("Audio").stop()
	else:
		# Se a caixa clicada for a errada, seta o texto formatado da caixa como errado
		self.get_parent().bbcode_text = "[center][color=#FF7085]"+self.get_parent().text+"[/color][/center]"
