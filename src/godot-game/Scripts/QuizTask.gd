extends CanvasLayer

func _ready():
	if $DialogBox/TexturaCaixa.connect("finish", self, "_on_TexturaCaixa_finish") != OK:
		print ("An unexpected error occured when trying to switch to the scene")
	Global.jumpStartQuiz1 = true
	
func _on_TexturaCaixa_finish():
	$DialogBox.visible = false
	$Opcoes.visible = true
	Global.startQuiz1 = true

func _process(_delta):
	if Global.correctAnswerQuiz1 == true:
		yield(get_tree().create_timer(1.0), "timeout")
		#$DialogBox/TexturaCaixa.jumpStart(2,2)
		$Opcoes.visible = false
		$DialogBox.visible = true
		Global.jumpStartFeedback1 = true
		
